Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbULDLiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbULDLiY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 06:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbULDLiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 06:38:24 -0500
Received: from mail10.atl.registeredsite.com ([64.224.219.84]:20660 "EHLO
	mail10.atl.registeredsite.com") by vger.kernel.org with ESMTP
	id S261679AbULDLhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 06:37:39 -0500
To: linux-kernel@vger.kernel.org
Reply-To: "H.Haines Brown" <brownh@hartford-hwp.com>
Message-Id: <20041204113750.3BDC13F1@teufel.hartford-hwp.com>
Date: Sat,  4 Dec 2004 06:37:50 -0500 (EST)
From: brownh@hartford-hwp.com (Haines Brown)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a new installation Debian sarge, I had this as my working
bootloader stanza: 

  title Debian sarge 2.6.8-1-386
    root (hd2,0)
    kernel /vmlinuz ro root=/dev/sdc1 apm=off 
    initrd /initrd.img 

  (pointing to symlink initrd.img@ -> /boot/initrd.img-2.6.8-1-386)

This worked fine until I did an automatic upgrade of all my installed
packages, which seems to have included an upgrade of initrd.img. This
upgrade of packages came with an alert that my bootloader requires
that I add initrd=/initrd.img to the images=/vmlinuz stanza.

I found that the upgrade replaced my
"/boot/initrd.img-2.6.8-1-386" file with a file named
"/boot/initrd.img-2.6.8-1-386.new". Is this a 
legitimate name?

More importantly, this new file has zero-length and so naturally
results in a kernel panic:  

  Cannot open root device 'sdc1' or unknown-block(0,0)
  Please append a correct "root=" boot option
  Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)

Does it look like the new initrd.img package for 2.6.8 is broken or
simply a flawed installation? Should initrd.img-1-386 file not have
ended with ".new"? What should I do to correct this situation?

Haines Brown

