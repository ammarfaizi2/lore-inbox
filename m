Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVGDVsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVGDVsZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 17:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVGDVsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 17:48:25 -0400
Received: from vsmtp1alice.tin.it ([212.216.176.144]:5091 "EHLO
	vsmtp1alice.tin.it") by vger.kernel.org with ESMTP id S261705AbVGDVqQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 17:46:16 -0400
Message-ID: <42C9AD67.5050808@inwind.it>
Date: Mon, 04 Jul 2005 23:43:03 +0200
From: federico <xaero@inwind.it>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050515)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: setkeycodes, sysrq, and USB keyboard
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i have a problem: i got a white Apple usb keyboard, but this keyboard
doesn't have PrintScr nor SysRq.
i read in Documentation/sysrq.txt how to change the SYSRQ scancode.
i launched showkey and acknowledged that R_Alt+F13 is 100,183 => 64b7.
i ran

 # setkeycodes 64b7 84
KDSETKEYCODE: No such device
failed to set scancode b7 to keycode 84

i'm on a gentoo-vanilla 2.6.13_rc1 with kbd-1.12-r5. (or on
2.6.11-gentoo-r9 which produces the same result)

here's some relevant output from strace:

open("/dev/tty", O_RDWR) = 3
ioctl(3, KDGKBTYPE, 0xbffdfcb7) = 0
ioctl(3, KDSETKEYCODE, 0xbffdfd20) = -1 ENODEV (No such device)
dup(2) = 4
fcntl64(4, F_GETFL) = 0x8001 (flags O_WRONLY|O_LARGEFILE)
close(4) = 0
...
write(2, "KDSETKEYCODE: No such device\n", 29KDSETKEYCODE: No such device
) = 29
...
write(2, "failed to set scancode 64b7 to k"..., 42failed to set scancode
64b7 to
keycode 84
) = 42

if anyone has a possible solution i really appreciate.
ciao!

-- 
Federico
