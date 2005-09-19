Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbVISUik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbVISUik (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbVISUik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:38:40 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:50394 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932629AbVISUij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:38:39 -0400
Date: Mon, 19 Sep 2005 16:38:38 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Bill Davidsen <davidsen@tmr.com>
cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: 2.6.14-rc1 load average calculation broken?
In-Reply-To: <432F09E8.6040703@tmr.com>
Message-ID: <Pine.LNX.4.44L0.0509191635210.4456-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2005, Bill Davidsen wrote:

> Alan Stern wrote:
> > On Fri, 16 Sep 2005, Jan Dittmer wrote:
> 
> 
> > I recognize the problem.  This experimental patch should fix it:
> > 
> > http://marc.theaimsgroup.com/?l=linux-scsi&m=112681273931290&w=2
> > 
> > Alan Stern
> > 
> Hum, I wonder if this could be related to my problem of the USB mass 
> storage becoming unreachable after a while. I have no problems with 
> 2.6.13-rc5-git1, but 2.6.14-rc1 and 2.6.13 show the problem. If I see 
> the problem again I'll look for the hung processes, but I can't run 
> those kernels on the production system any more, if it dies on the 
> weekend I have a 260 miles round trip to reboot it.

I believe that the problem was introduced after 2.6.13 was released.  And
it only occurs when SCSI devices are removed, not while they are in use.

Alan Stern

