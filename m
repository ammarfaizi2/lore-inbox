Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbTAJGl0>; Fri, 10 Jan 2003 01:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbTAJGl0>; Fri, 10 Jan 2003 01:41:26 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:33804 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S263276AbTAJGlW>;
	Fri, 10 Jan 2003 01:41:22 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [NEOFB, 2.5.54] panic when initializing
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Fri, 10 Jan 2003 07:39:02 +0100
Message-ID: <87iswxik55.fsf@jupiter.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The boot messages are (I use vga=0x317 as command line)
Video mode to be used for restore is 317
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000005fd0000 (usable)
 BIOS-e820: 0000000005fd0000 - 0000000005fdf000 (ACPI data)
 BIOS-e820: 0000000005fdf000 - 0000000005fe0000 (ACPI NVS)
 BIOS-e820: 0000000005fe0000 - 0000000006000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
95MB LOWMEM available.
[...]
neofb: mapped io at c680d000
Autodetected internal display
Panel is a 1024x768 color TFT display
neofb: mapped framebuffer at c6a0e000
neofb v0.4.1: 2048kB VRAM, using 1024x768, 48.361kHz, 60Hz
fb0: MagicGraph 128XD frame buffer device
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0261cfb
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0261cfb>]    Not tainted
EFLAGS: 00010202
EIP is at neofb_check_var+0x7d3/0x844
eax: c5ecdd7c   ebx: 00000325   ecx: 00000000   edx: 000003d5
esi: c5ecdd7c   edi: c5ecdc00   ebp: c5f79f48   esp: c5f79ef0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c5f78000 task=c5f76040)
Stack: c5ec9800 00000010 c5ecdc00 c5f79f28 000000a5 0000007b c5ecdc0c 0000005e 
       c01354f4 00000000 0000fde6 00000400 00000418 000004a0 00000540 00000300 
       00000303 00000309 00000326 00000003 00000000 00000000 c5f79f68 c025bda8 
Call Trace:
 [<c01354f4>] poison_obj+0x30/0x58
 [<c025bda8>] accel_cursor+0x1e8/0x22c
 [<c022b517>] clear_buffer_attributes+0x17/0x180
 [<c0105096>] do_pre_smp_initcalls+0x2e/0x178
 [<c0105068>] do_pre_smp_initcalls+0x0/0x178
 [<c0107211>] show_regs+0x5/0xc

Code: 8b 01 a8 01 74 08 89 ca 8b 02 a8 01 75 fa 8b 55 c0 8b 42 18 
 <0>Kernel panic: Attempted to kill init!
 
-- 
#include <~/.signature>: permission denied
