Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132511AbRDUG1G>; Sat, 21 Apr 2001 02:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132512AbRDUG04>; Sat, 21 Apr 2001 02:26:56 -0400
Received: from [205.162.53.13] ([205.162.53.13]:57352 "EHLO
	primary.cyberlane.net") by vger.kernel.org with ESMTP
	id <S132511AbRDUG0o>; Sat, 21 Apr 2001 02:26:44 -0400
Date: Sat, 21 Apr 2001 01:20:21 -0500
From: Eugene Kuznetsov <divx@euro.ru>
X-Mailer: The Bat! (v1.47 Halloween Edition) UNREG / CD5BF9353B3B7091
Reply-To: Eugene Kuznetsov <divx@euro.ru>
X-Priority: 3 (Normal)
Message-ID: <921508308.20010421012021@euro.ru>
To: linux-kernel@vger.kernel.org
Subject: Problem with i810_audio driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

      I am a happy owner of Intel D815EEA2 mother board. This board
comes with integrated AC-97 audio. When I try to load i810_audio
driver for it, driver identifies the device as
"Intel 810 + AC97 Audio, version 0.02, 19:43:23 Apr 20 2001
i810: Intel ICH2 found at IO 0xef00 and 0xe800, IRQ 6
ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Analog Devices
AD1885)"
and later brings the system into one of three possible conditions.
A) a bit later it says:
   i810_audio: 11168 bytes in 50 milliseconds
   i810_audio: setting clocking to 41260 to compensate
In this case everything is fine ( 16-bit sound is played correctly, I
don't need much more ... ).
B) It says:
   i810_audio: 65528 bytes in 50 milliseconds
   i810_audio: setting clocking to 7032 to compensate
In this case the sound does not work at all - sound card does not
produce anything but silence. With versions of kernel up to 2.4.3 I
also received a lot of "DMA buffer overrun on send" messages in dmesg
when playing anything.
C) Last condition is relatively rare. It says something similar to
case A, but number of bytes is multiple of 11168 and clocking is lower
( e.g. 13753 = 41260/3 ). Sound card works, but output quality is
quite low.
Which of cases A)..C) takes place, seems to be random ( I haven't
noticed any pattern ). However, attempts to do rmmod/insmod
do not have any effect. I have to at least reboot the system a few
times to bring the sound to working state.
I tried driver from kernels 2.4.1, 2.4.3 and 2.4.4-pre4. All of them
behave more or less in the same way.
In Windows 2000 this motherboard/audio device works without any problems.
I can provide any additional information if it helps to solve the bug.
Please cc: me, because I am not subscribed to the list.

-- 
Best regards,
 Eugene
mailto:divx@euro.ru


