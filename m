Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273429AbRIWLzl>; Sun, 23 Sep 2001 07:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273419AbRIWLzb>; Sun, 23 Sep 2001 07:55:31 -0400
Received: from duba03h03-0.dplanet.ch ([212.35.36.23]:42763 "EHLO
	duba03h03-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S273429AbRIWLzN>; Sun, 23 Sep 2001 07:55:13 -0400
Message-ID: <3BADE818.6CDCA8DF@dplanet.ch>
Date: Sun, 23 Sep 2001 15:48:08 +0200
From: "Giacomo A. Catenazzi" <cate@dplanet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10-pre15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops at boot: 2.4.10-pre15, acpi
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note: Oops copied by hand from console.

The oops happens just after:
"APCI: System description table not found"

Unable to handle kernel NULL pointer dereferences at virtual address
000000d4
c015d7e2
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c015d7e2>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: c0133fd0   ecx: 00000000   edx: 000010ca
esi: c021dfd4   edi: c025a4f4   ebp: 0008e000   esp: c1133fb8
ds: 0018   es: 0018   ss: 0018
Stack: c024aa4c c016b904 c1133fb0 00000000 00000000 00000000 00000000
Call Trace: [<c016b904>] [<c016bcba>] [<c010503b>] [<c010547c>]
Code: 8b 80 d4 00 00 00 00 e8 46

>>EIP; c015d7e2 <acpi_get_timer+22/40>   <=====
Trace; c016b904 <bm_initialize+28/a0>
Trace; c016bcba <bm_osl_init+46/54>
Trace; c010503b <init+7/10c>
Trace; c010547c <kernel_thread+28/38>
Code;  c015d7e2 <acpi_get_timer+22/40>
00000000 <_EIP>:
Code;  c015d7e2 <acpi_get_timer+22/40>   <=====
   0:   8b 80 d4 00 00 00         mov    0xd4(%eax),%eax   <=====
Code;  c015d7e8 <acpi_get_timer+28/40>
   6:   00 e8                     add    %ch,%al
Code;  c015d7ea <acpi_get_timer+2a/40>
   8:   46                        inc    %esi


	giacomo
