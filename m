Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTJRRwj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTJRRwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:52:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62080 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261755AbTJRRwh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:52:37 -0400
Date: Sat, 18 Oct 2003 18:52:36 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Walt H <waltabbyh@comcast.net>
Cc: arekm@pld-linux.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: initrd and 2.6.0-test8
Message-ID: <20031018175236.GA7665@parcelfarce.linux.theplanet.co.uk>
References: <3F916A0C.10800@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F916A0C.10800@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 09:27:56AM -0700, Walt H wrote:
> 
> > Hi,
> > 
> > Seems that something changed between test7 and test8 regarding initrd or romfs 
> > support. I'm using highly modularized 2.6.0 kernel which has all filesystems 
> > beside romfs compiled as modules (romfs is compiled inside of kernel).
> > 
> > Modules for my rootfs are loaded from initrd (which is image with romfs as 
> > filesystem) but starting from test8 kernel is not able to mount initrd 
> > filesystem - stops with typical message about not being able to mount rootfs.
> > 
> > cset test7 from 20031012_0407 is known to be ok so something was changed later
> 
> 
> I noticed this happened in 2.6.0-test6-mm4. Backing out this patch fixes
> it in the short-term.

Even better would be to report the bug ;-/

I can't reproduce it here.  2.6.0-test8 vanilla, so far (last 15 minutes)
tried with
	* compressed initrd image
	* plain ext2
and I'll try romfs as soon as I hunt down mkfs for that animal.  All
appears to be working...

What did it say before the "typical message"?  Specifically, were there
any lines starting with RAMDISK:?

.config would be also useful.
