Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030642AbWKUIGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030642AbWKUIGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 03:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030681AbWKUIGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 03:06:14 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:2731 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030642AbWKUIGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 03:06:13 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4562B35C.7090807@s5r6.in-berlin.de>
Date: Tue, 21 Nov 2006 09:05:48 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: linux1394-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: deadlock in "modprobe -r ohci1394" shortly after "modprobe ohci1394"
References: <Pine.LNX.4.44L0.0611201942270.30952-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0611201942270.30952-100000@netrider.rowland.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> The real issue here is the way ieee1394 sets up children of devices with
> no driver.  On the face of it that is quite illogical: If a device has no
> driver, then who can interrogate it to find out about its children?

Perhaps I should turn this dummy driver into an actual representation of
ieee1394 or ieee1394's nodemgr.

> USB faces a similar situation.  In a USB device, all the real work is 
> actually done by "interfaces".  So we set up a device structure for the 
> USB device itself, plus device structures for each of its interfaces.  The 
> parent structure is bound to a (more or less) dummy driver, which insures 
> that the child structures are deleted whenever it gets unbound.

I will eventually more thoroughly look at how USB and other subsystems
with device hierarchies do it.

> Still, maybe some compromise can be reached.  Perhaps Dmitry's idea, or 
> something like it, can be adopted.

Thanks for the input of both of you.
-- 
Stefan Richter
-=====-=-==- =-== =-=-=
http://arcgraph.de/sr/
