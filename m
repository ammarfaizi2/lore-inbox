Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUAOC0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUAOC0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:26:00 -0500
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:34935 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264949AbUAOCZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:25:58 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: linux-kernel@vger.kernel.org
Subject: [BUG] ABNT2 keyboards not work with >= 2.6.1 with or without -mm patchs
Date: Wed, 14 Jan 2004 23:26:21 +0000
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401142326.21543.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BUG: ABNT2 keyboards not work with >= 2.6.1 with or without -mm patchs
DESCRIPTION: The "/ ?" not work on console-framebuffer

My debug info:

23:20:01 [root@murilo:~]#dmesg | grep serio
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0). ---> print twice, in each X startup
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0). 
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0). 

23:20:24 [root@murilo:~]#loadkeys br-abnt2
Loading /usr/share/kbd/keymaps/i386/qwerty/br-abnt2.map.gz

23:17:07 [root@murilo:~]#showkey
kb mode was RAW
[ if you are trying this under X, it might not work
since the X server is also reading /dev/console ]

press any key (program terminates 10s after last keypress)...
keycode  28 release
keycode   0 press
keycode   1 release
keycode  53 release
keycode   0 release
keycode   1 release
keycode  53 release
keycode   0 press
keycode   1 release
keycode  53 release
keycode   0 release
keycode   1 release
keycode  53 release



