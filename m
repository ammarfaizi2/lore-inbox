Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTJRT5T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbTJRT5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:57:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23426 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261798AbTJRT5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:57:18 -0400
Date: Sat, 18 Oct 2003 20:57:17 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Valdis.Kletnieks@vt.edu
Cc: Witold Krecicki <adasi@kernel.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: initrd and 2.6.0-test8
Message-ID: <20031018195716.GG7665@parcelfarce.linux.theplanet.co.uk>
References: <200310182002.15787.adasi@kernel.pl> <200310181941.h9IJfhLW030128@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310181941.h9IJfhLW030128@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 03:41:43PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sat, 18 Oct 2003 20:02:15 +0200, Witold Krecicki <adasi@kernel.pl>  said:
> 
> > But do you have HDD-controller parts as modules or built-in? According to the
> > changelog message, if initrd is detected as 'usual initrd' (e.g. not
> > initramfs), then it's copied to /dev/initrd on rootfs. But as I understand,
> > there is no such thing as rootfs as long as it isn't mounted (ide/scsi
> > modules are not loaded
> 
> What happens in the case of a devfs-based system where the real rootfs
> can't be mounted till after the initrd is loaded, because / is on an LVM
> volume?

Guys, rootfs is there from the very beginning.  It's just a ramfs - doesn't
require any drivers, is writable and is there.  We mount ramdisks, final
root, devfs, etc. on it.  Presense of drivers doesn't matter - we don't
need any drivers to access that beast, since it just sits in pagecache.
No backing device at all.

>  I know my laptop crashed-and-burned on this, even though the IDE
> and LVM modules were built into the kernel....

Details?  How long ago had it started, .config, boot log, etc...
