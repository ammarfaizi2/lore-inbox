Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTJKOev (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 10:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263316AbTJKOev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 10:34:51 -0400
Received: from gagarin.cse.Buffalo.EDU ([128.205.36.11]:6604 "EHLO
	gagarin.cse.buffalo.edu") by vger.kernel.org with ESMTP
	id S263315AbTJKOeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 10:34:50 -0400
Date: Sat, 11 Oct 2003 10:34:49 -0400
From: Chad A Daelhousen <cd9@cse.Buffalo.EDU>
To: linux-kernel@vger.kernel.org
Subject: reiserfs root fs broken: 2.4.22, 2.5.68+
Message-ID: <20031011143449.GA13029@gagarin.cse.Buffalo.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.68 (first dev kernel I tried) and beyond, remount of reiserfs
root filesystems is broken. Whatever caused it has also been backported
to 2.4.22. I assumed someone would notice, but since it's still present
in 2.6.0-test7, that is obviously not the case.

mount claims the partition to be mounted rw, though the kernel was
booted with the ro option and returns EROFS for any write attempts on
the partition. Any attempt to remount fails with "/ not mounted already,
or bad option". Booting with ext2 initrd gives the same results for
remount.

Previous exercises with 2.5.70 showed that recompiling util-linux to
explicitly include the development kernel's headers did not solve the
problem.

Mounting and remounting reiserfs partition at anywhere other than the
root works flawlessly. Mounting ext3 as root also works fine.

Software:
grub 0.93.20030118
util-linux 2.11z
reiserfsprogs 3.6.8

Hardware:
Soyo KT333 Dragon Lite motherboard (VIA KT333 chipset)
/dev/hda: 80GB Seagate Barracuda IV, ATA100
     hda2: ext3 /boot
     hda3: swap
     hda4: reiserfs /

If nobody knows what the problem is offhand, I'll try finding it myself.
(Google found some previous reports of this issue, but no
patches/solutions/workarounds.) Hints appreciated; this is my first
major foray into kernel source.

Please CC me if replying, as I am not subscribed.

-- 
Chad Daelhousen
My opinions are my own, until UB purchases my soul.

