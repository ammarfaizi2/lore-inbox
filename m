Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUDBN1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 08:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbUDBN1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 08:27:53 -0500
Received: from [80.72.36.106] ([80.72.36.106]:6588 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264045AbUDBN1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 08:27:46 -0500
Date: Fri, 2 Apr 2004 15:27:41 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: wolk-devel@lists.sourceforge.net, Alan Stern <stern@rowland.harvard.edu>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, speedtouch@ml.free.fr,
       akpm@osdl.org
Subject: Re: [linux-usb-devel] speedtouch and/or USB problem (2.6.4-WOLK2.3
 and 2.6.5-rc3-mm4)
In-Reply-To: <200403311121.27731@WOLK>
Message-ID: <Pine.LNX.4.58.0404021519270.30573@alpha.polcom.net>
References: <Pine.LNX.4.44L0.0403271851040.2209-100000@ida.rowland.org>
 <200403311121.27731@WOLK>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004, Marc-Christian Petersen wrote:

> On Sunday 28 March 2004 00:51, Alan Stern wrote:
> 
> Hi Grzegorz,
> 
> > > When running modem_run on 2.6.4-WOLK2.3 it locks in D state on one of USB
> > > ioctls. It works at least on 2.6.2-rc2. I have no idea what causes this
> > > bug so I sent it to all lists.
> > > Please help if you can.
> > > Grzegorz Kulewski
> 
> > Try applying this patch:
> > http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108016447231291&q=raw
> 
> Did this help Grzegorz?

No, it did not. This time I tried 2.6.5-rc3-mm4. Seems the patch was 
already applied in this release. modem_run did not lock (disk sleep state) 
in the same place, but it locked after writing synchronization succeded 
to system log. It seems that there is no kernel-stack-for-process-in-proc 
option in mm (Andrew, can you add it?), so there is no callstack.


but still thanks for your help
and looking for next :)


Grzegorz Kulewski

