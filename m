Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSJaKlF>; Thu, 31 Oct 2002 05:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbSJaKlF>; Thu, 31 Oct 2002 05:41:05 -0500
Received: from maruja.satec.es ([213.164.38.66]:24043 "EHLO satec.es")
	by vger.kernel.org with ESMTP id <S264818AbSJaKlB>;
	Thu, 31 Oct 2002 05:41:01 -0500
From: "Adriano Galano" <adriano@satec.es>
To: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Kernel bug in 2.4.7-10smp...
Date: Thu, 31 Oct 2002 11:41:17 +0100
Message-ID: <00dc01c280ca$0ba447e0$6f20a4d5@adriano>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <15809.2056.151239.230395@robur.slu.se>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I'm using RH Linux 7.2 (kernel 2.4.7-10smp) in one Compaq Proliant ML570
with 4 Xeon procesors at 900MHz and one Compaq Smart Array 5300 Controller
with 6x73 GB SCSI disk with ext3 filesystem.

It was working OK, but I have one trouble, description below, and the
computer it's stopped. Could someone help me? How could I fix it?

Oct 20 04:13:24 virtual3 kernel: Unable to handle kernel paging request
at virtual address a5e7ba0b
Oct 20 04:13:24 virtual3 kernel: printing eip:
Oct 20 04:13:24 virtual3 kernel: c0144d00
Oct 20 04:13:24 virtual3 kernel: *pde = 00000000
Oct 20 04:13:24 virtual3 kernel: Oops: 0000
Oct 20 04:13:24 virtual3 kernel: CPU: 0
Oct 20 04:13:24 virtual3 kernel: EIP: 0010:[cdfind+16/48]
Oct 20 04:13:24 virtual3 kernel: EIP: 0010:[]
Oct 20 04:13:24 virtual3 kernel: EFLAGS: 00010287
Oct 20 04:13:24 virtual3 kernel: eax: a5e7b9ff ebx: f5c898c0 ecx:
00004402 edx: c0313630
Oct 20 04:13:24 virtual3 kernel: esi: f5c898c0 edi: 00004402 ebp:
c0313630 esp: d80dbe04
Oct 20 04:13:24 virtual3 kernel: ds: 0018 es: 0018 ss: 0018
Oct 20 04:13:24 virtual3 kernel: Process updatedb (pid: 30973,
stackpage=d80db000)
Oct 20 04:13:24 virtual3 kernel: Stack: c0144d60 00004402 c0313630
000000b0 f5c898c0 f5c898c0 00004402 f6a7dc00
Oct 20 04:13:24 virtual3 kernel: c013d079 00004402 00000000 f88573a3
f5c898c0 00002180 00004402 f67a1de0
Oct 20 04:13:24 virtual3 kernel: f679e354 00000282 00000000 c09aec60
d934ad80 00000002 c0152fbf 00000000
Oct 20 04:13:24 virtual3 kernel: Call Trace: [cdget+64/224]
[init_special_inode+57/192]
[eepro100:__insmod_eepro100_O/lib/modules/2.4.7-10smp/kernel/drivers/+-62166
1/96]
[get_new_inode+79/384] [get_new_inode+227/384]
Oct 20 04:13:24 virtual3 kernel: Call Trace: [] [] [] [] []
Oct 20 04:13:24 virtual3 kernel: [iget4+217/240]
[eepro100:__insmod_eepro100_O/lib/modules/2.4.7-10smp/kernel/drivers/+-61714
4/96]
[real_lookup+115/272] [path_walk+1646/2288] [__user_walk+58/96]
[sys_lstat64+19/112]
Oct 20 04:13:24 virtual3 kernel: [] [] [] [] [] []
Oct 20 04:13:24 virtual3 kernel: [error_code+56/64] [system_call+51/56]
Oct 20 04:13:24 virtual3 kernel: [] []
Oct 20 04:13:24 virtual3 kernel:
Oct 20 04:13:24 virtual3 kernel: Code: 66 39 48 0c 75 0a f0 ff 40 08 c3
90 8d 74 26 00 8b 00 39 d0
Oct 20 15:21:11 virtual3 kernel: <5>ENOMEM in
journal_get_undo_access_Rsmp_b86db3be, retrying.
Oct 20 15:58:12 virtual3 kernel: ENOMEM in
journal_get_undo_access_Rsmp_b86db3be, retrying.
Oct 20 15:59:33 virtual3 kernel: ENOMEM in do_get_write_access,
retrying.
Oct 20 16:09:35 virtual3 kernel: ENOMEM in
journal_get_undo_access_Rsmp_b86db3be, retrying.
Oct 20 17:33:15 virtual3 kernel: ENOMEM in
journal_get_undo_access_Rsmp_b86db3be, retrying.
Oct 20 17:59:53 virtual3 kernel: ENOMEM in
journal_get_undo_access_Rsmp_b86db3be, retrying.
Oct 20 18:28:11 virtual3 kernel: ENOMEM in do_get_write_access,
retrying.
Oct 20 19:02:55 virtual3 kernel: ENOMEM in
journal_get_undo_access_Rsmp_b86db3be, retrying.
Oct 20 20:37:57 virtual3 kernel: ENOMEM in
journal_get_undo_access_Rsmp_b86db3be, retrying.

Best regards,

-Adriano (bryam)
--
Adriano M. Galano Diez
System & Network Engineer
http://www.satec.es
Phone: (+34) 917 089 000
Sourceforge.NET Linux Kernel Foundry Guide http://sf.net/foundry/linuxkernel



