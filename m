Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWINUZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWINUZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWINUZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:25:29 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41487 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751138AbWINUZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:25:28 -0400
Date: Thu, 14 Sep 2006 16:25:26 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Mattia Dongili <malattia@linux.it>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-Reply-To: <20060914201919.GB3963@inferi.kami.home>
Message-ID: <Pine.LNX.4.44L0.0609141622030.6982-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Mattia Dongili wrote:

> > No.  But this log doesn't include the debugging output in the patch from 
> > my previous message.
> 
> doh! I'm pretty sure the patch is applied...
> $ patch -p1 --dry-run < ../add_usb_debug.patch
> patching file drivers/usb/core/driver.c
> Reversed (or previously applied) patch detected!  Assume -R? [n]

Actually I was wrong to think the patch wasn't in there just because it
didn't produce any output.

> Will try again with USB_SUSPEND=y, tomorrow I'll try to find some time
> to test all the other things you suggested  (if still necessary) :)

No, don't do that.  Keep USB_SUSPEND=n, and try only the most recent patch
I sent to Rafael:

http://marc.theaimsgroup.com/?l=linux-kernel&m=115825076000987&w=2

I know for certain that some of Rafael's problems are different from 
yours, because his involve ehci-hcd and ohci-hcd whereas you have only 
UHCI controllers.

Alan Stern

