Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVFDRFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVFDRFi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 13:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVFDRFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 13:05:38 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:8617 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261392AbVFDRFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 13:05:23 -0400
Message-ID: <42A1DF4B.9070201@snacksy.com>
Date: Sat, 04 Jun 2005 19:05:15 +0200
From: jan malstrom <xanon@snacksy.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Re: 2.6.12-rc5-mm2 Oops
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry. the oops happened right at boot up.
so, just mounting the fs.

please cc me. im not subscribed.

> Hello
> 
> On Sat, 2005-06-04 at 04:23, jan malstrom wrote:
>> i attach the .config
>>
> 
> Please describe what did you do to get this oops.
> 
>>
>> ------------------------
>>
>>
>> SGI XFS with no debug enabled
>> 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
>> cs: IO port probe 0x2000-0x2fff: clean.
>> ehci_hcd 0000:00:1d.7: debug port 1
>> C058 C1AD C1A3 C1A4 C0AC C0B3 C0B4 C0B5 C0E7 C136
>> Unable to handle kernel paging request at virtual address 6b6b6d63
>> c0227ca7
>> *pde = 00000000
>> Oops: 0000 [#1]
>> CPU: 0
>> EIP: 0060:[<c0227ca7>] Not tainted VLI
>> Using defaults from ksymoops -t elf32-i386 -a i386
>> EFLAGS: 00010286 (2.6.12-rc5-mm2)
>> eax: 6b6b6b6b ebx: 00000000 ecx: 00000000 edx: c1578cc0
>> esi: dedf9158 edi: 00000000 ebp: dec55cb8 esp: dec55cb0
>> ds: 007b es: 007b ss: 0068
>> Stack: c0229c87 6b6b6b6b dec55cf4 c02348ce dedf9158 00000000 dedf9458
>> 0000000a
>> dec55ce0 c02343e1 dedf9458 0000000a 000b78e0 00000000 00000000
>> df0cce1c
>> dec55d18 dec55d84 c0234a61 df0cce1c 00000000 dec55d3c 000b78e0
>> 00000000
>> Call Trace:
>> [<c0104b8f>] show_stack+0x7f/0xa0
>> [<c0104d37>] show_registers+0x157/0x1c0
>> [<c0104f94>] die+0x134/0x290
>> [<c011b1b9>] do_page_fault+0x399/0x6ff
>> [<c0104683>] error_code+0x4f/0x54
>> [<c02348ce>] process_safelink+0xae/0x1b0
>> [<c0234a61>] process_safelinks+0x91/0xb0
>> [<c02342d1>] _init_safelink+0x11/0x20
>> [<c023438f>] reiser4_fill_super+0x3f/0x70
>> [<c018affd>] get_sb_bdev+0x12d/0x170
>> [<c022c90f>] reiser4_get_sb+0x2f/0x40
>> [<c018b246>] do_kern_mount+0x56/0xd0
>> [<c01ac164>] do_new_mount+0x74/0xb0
>> [<c01ace30>] do_mount+0x140/0x190
>> [<c01ad402>] sys_mount+0x92/0xd0
>> [<c0103bd9>] syscall_call+0x7/0xb
>> Code: 00 00 00 00 55 89 e5 8b 45 08 5d 8b 80 f8 01 00 00 8b 80 18 02
>> 00 00 c3 8d b6 00 00 00 00 8d bf 00 00 00 00 55 89 e5 8b 45 08 5d <8b>
>> 80 f8 01 00 00 83 c0 2c c3 eb 0d 90 90 90 90 90 90 90 90 90
>>
>>
>> >>EIP; c0227ca7 <get_tree+7/20> <=====
>>
>> >>eax; 6b6b6b6b <phys_startup_32+6b5b6b6b/c0000000>
>> >>edx; c1578cc0 <pg0+d9acc0/3f820400>
>> >>esi; dedf9158 <pg0+1e61b158/3f820400>
>> >>ebp; dec55cb8 <pg0+1e477cb8/3f820400>
>> >>esp; dec55cb0 <pg0+1e477cb0/3f820400>
>>
>> Trace; c0104b8f <show_stack+7f/a0>
>> Trace; c0104d37 <show_registers+157/1c0>
>> Trace; c0104f94 <die+134/290>
>> Trace; c011b1b9 <do_page_fault+399/6ff>
>> Trace; c0104683 <error_code+4f/54>
>> Trace; c02348ce <process_safelink+ae/1b0>
>> Trace; c0234a61 <process_safelinks+91/b0>
>> Trace; c02342d1 <_init_safelink+11/20>
>> Trace; c023438f <reiser4_fill_super+3f/70>
>> Trace; c018affd <get_sb_bdev+12d/170>
>> Trace; c022c90f <reiser4_get_sb+2f/40>
>> Trace; c018b246 <do_kern_mount+56/d0>
>> Trace; c01ac164 <do_new_mount+74/b0>
>> Trace; c01ace30 <do_mount+140/190>
>> Trace; c01ad402 <sys_mount+92/d0>
>> Trace; c0103bd9 <syscall_call+7/b>
>> 

