Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTJRSCu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 14:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTJRSCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 14:02:50 -0400
Received: from pf138.torun.sdi.tpnet.pl ([213.76.207.138]:52749 "EHLO
	centaur.culm.net") by vger.kernel.org with ESMTP id S261780AbTJRSCc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 14:02:32 -0400
From: Witold Krecicki <adasi@kernel.pl>
Subject: Re: initrd and 2.6.0-test8
Date: Sat, 18 Oct 2003 20:02:15 +0200
User-Agent: KMail/1.5.9
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200310182002.15787.adasi@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Oct 18, 2003 at 09:27:56AM -0700, Walt H wrote:
> > > Hi,
> > >
> > > Seems that something changed between test7 and test8 regarding initrd
> > > or romfs support. I'm using highly modularized 2.6.0 kernel which has
> > > all filesystems beside romfs compiled as modules (romfs is compiled
> > > inside of kernel).
> > >
> > > Modules for my rootfs are loaded from initrd (which is image with romfs
> > > as filesystem) but starting from test8 kernel is not able to mount
> > > initrd filesystem - stops with typical message about not being able to
> > > mount rootfs.
> > >
> > > cset test7 from 20031012_0407 is known to be ok so something was
> > > changed later
> >
> > I noticed this happened in 2.6.0-test6-mm4. Backing out this patch fixes
> > it in the short-term.
>
> Even better would be to report the bug ;-/
>
> I can't reproduce it here.  2.6.0-test8 vanilla, so far (last 15 minutes)
> tried with
> 	* compressed initrd image
> 	* plain ext2
> and I'll try romfs as soon as I hunt down mkfs for that animal.  All
> appears to be working...
>
> What did it say before the "typical message"?  Specifically, were there
> any lines starting with RAMDISK:?
>
> .config would be also useful.

But do you have HDD-controller parts as modules or built-in? According to the
changelog message, if initrd is detected as 'usual initrd' (e.g. not
initramfs), then it's copied to /dev/initrd on rootfs. But as I understand,
there is no such thing as rootfs as long as it isn't mounted (ide/scsi
modules are not loaded
--
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
