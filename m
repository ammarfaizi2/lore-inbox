Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291088AbSBZQbq>; Tue, 26 Feb 2002 11:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291084AbSBZQb0>; Tue, 26 Feb 2002 11:31:26 -0500
Received: from pC19F4729.dip.t-dialin.net ([193.159.71.41]:35552 "EHLO
	artus.fbunet.de") by vger.kernel.org with ESMTP id <S291081AbSBZQbR>;
	Tue, 26 Feb 2002 11:31:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Fridtjof Busse <fridtjof.busse@gmx.de>
Message-Id: <200202261722.13431@fbunet.de>
To: linux-kernel@vger.kernel.org
Subject: [2.4.18-ac1] Unable to mount root fs
Date: Tue, 26 Feb 2002 17:31:39 +0100
X-OS: Linux on i686
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I successfully patched and compiled 2.4.18-ac1, no problems.
But when I try to boot the system, the kernel is unable to mount the 
root filesystem (/dev/hdf2):

request_module[block-major-33]: Root fs not mounted
VFS: Cannot open root devices "hdf2" or 21:42
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 21:42

The bootloader-options are correct, a 2.4.18 kernel with exactly the 
same config-options has no problems with mounting the root fs.
hdf is secondary master, connected to a Promise UDMA 100 controller on 
an ASUS A7V.

The boot-option in grub.conf looks like

title Linux-ac(2.4.18-ac1)
        root (hd1,0)
        kernel /vmlinuz-2.4.18-ac1 ro root=/dev/hdf2 hdc=ide-scsi
title Linux (2.4.18)
        root (hd1,0)
        kernel /vmlinuz-2.4.18 ro root=/dev/hdf2 hdc=ide-scsi

but only 2.4.18 works.
Is this a bug or did I miss anything?
-- 
Fridtjof Busse
Microsoft is a cross between The Borg and the Ferengi. 
Unfortunately they use Borg to do their marketing and Ferengi to do 
their programming.
