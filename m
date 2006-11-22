Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755971AbWKVO3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971AbWKVO3M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 09:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbWKVO3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 09:29:12 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:5279 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1755971AbWKVO3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 09:29:11 -0500
Subject: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 15:29:02 +0100
Message-Id: <1164205742.13434.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello..

it appears some sort of bug has gotten into .19, in regards to x86
emulation on x86_64.

i have only tested with >=rc5, thw folling, as an example, appears in
dmesg:
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/fonts
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/fonts
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/fonts
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/fonts
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/fonts
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/fonts
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(explorer.exe:11806): Unknown cmd fd(8) cmd(82187201){02}
arg(00222000) on /home/redeeman/.wine/drive_c/windows/system32
ioctl32(explorer.exe:11806): Unknown cmd fd(8) cmd(82187201){02}
arg(00222000) on /home/redeeman/.wine/drive_c/windows
ioctl32(explorer.exe:11806): Unknown cmd fd(8) cmd(82187201){02}
arg(00222000) on /home/redeeman/.wine/drive_c/windows/fonts
ioctl32(explorer.exe:11806): Unknown cmd fd(8) cmd(82187201){02}
arg(00222000) on /home/redeeman/.wine/drive_c/windows

however it doesent seem to affect the regedit and explorer.exe, some
applications when run within wine does some VERY weird shit, i have even
observed a few hardlock which i suspect may be due to this.


im sorry to say that i havent had time to do a git bisect, but i thought
i'd report it anyway.

mvh.
Kasper Sandberg

