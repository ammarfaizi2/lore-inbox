Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbSLQTNT>; Tue, 17 Dec 2002 14:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbSLQTNT>; Tue, 17 Dec 2002 14:13:19 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:59659 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S265568AbSLQTMG> convert rfc822-to-8bit;
	Tue, 17 Dec 2002 14:12:06 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.52, ALSA] Unable to handle kernel paging request at virtual
 address 32347363
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
Date: Tue, 17 Dec 2002 20:13:16 +0100
Message-ID: <87u1hcv4qb.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is when loading the cs4232 driver for my Thinkpad 600.

Unable to handle kernel paging request at virtual address 32347363
c6abb81c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c6abb81c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c489e064   ebx: 32347363   ecx: c6ac2460   edx: c489e014
esi: c6ac0320   edi: 32347363   ebp: c5bdff38   esp: c5bdff2c
ds: 0068   es: 0068   ss: 0068
Stack: c489e014 32347363 c6ae2780 c5bdff54 c6aba660 32347363 00000000 00000000
       c6ae2780 00000004 c5bdff90 c6af807a 00000001 32347363 c6ae0000 00000004
       00000000 00000000 c6ae2780 00000000 00000010 c6aca304 c6aca394 00000000
Call Trace: [<c6ae2780>]  [<c6aba660>]  [<c6ae2780>]  [<c6af807a>]  [<c6ae2780>]  [<c6af836c>]  [<c012ca67>]  [<c0108cd7>]
Code: ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 74 34 83


>>EIP; c6abb81c <END_OF_CODE+66b7fdc/????>   <=====

Trace; c6ae2780 <END_OF_CODE+66def40/????>
Trace; c6aba660 <END_OF_CODE+66b6e20/????>
Trace; c6ae2780 <END_OF_CODE+66def40/????>
Trace; c6af807a <END_OF_CODE+66f483a/????>
Trace; c6ae2780 <END_OF_CODE+66def40/????>
Trace; c6af836c <END_OF_CODE+66f4b2c/????>
Trace; c012ca67 <sys_init_module+113/1a4>
Trace; c0108cd7 <syscall_call+7/b>

Code;  c6abb81c <END_OF_CODE+66b7fdc/????>
00000000 <_EIP>:
Code;  c6abb81c <END_OF_CODE+66b7fdc/????>   <=====
   0:   ae                        scas   %es:(%edi),%al   <=====
Code;  c6abb81d <END_OF_CODE+66b7fdd/????>
   1:   75 08                     jne    b <_EIP+0xb>
Code;  c6abb81f <END_OF_CODE+66b7fdf/????>
   3:   84 c0                     test   %al,%al
Code;  c6abb821 <END_OF_CODE+66b7fe1/????>
   5:   75 f8                     jne    ffffffff <_EIP+0xffffffff>
Code;  c6abb823 <END_OF_CODE+66b7fe3/????>
   7:   31 c0                     xor    %eax,%eax
Code;  c6abb825 <END_OF_CODE+66b7fe5/????>
   9:   eb 04                     jmp    f <_EIP+0xf>
Code;  c6abb827 <END_OF_CODE+66b7fe7/????>
   b:   19 c0                     sbb    %eax,%eax
Code;  c6abb829 <END_OF_CODE+66b7fe9/????>
   d:   0c 01                     or     $0x1,%al
Code;  c6abb82b <END_OF_CODE+66b7feb/????>
   f:   85 c0                     test   %eax,%eax
Code;  c6abb82d <END_OF_CODE+66b7fed/????>
  11:   74 34                     je     47 <_EIP+0x47>
Code;  c6abb82f <END_OF_CODE+66b7fef/????>
  13:   83 00 00                  addl   $0x0,(%eax)


How can I decode the addresses in the modules?

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
