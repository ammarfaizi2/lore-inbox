Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbULNJcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbULNJcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 04:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbULNJcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 04:32:41 -0500
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:47598 "EHLO
	cascabel.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id S261466AbULNJcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 04:32:16 -0500
Message-ID: <41BEB2F8.3080709@mtg-marinetechnik.de>
Date: Tue, 14 Dec 2004 10:31:36 +0100
From: Richard Ems <richard.ems@mtg-marinetechnik.de>
Organization: MTG Marinetechnik GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: kernel Oops in lockd
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list!

This is a SuSE 9.2 system, with SuSE's kernel kernel-smp-2.6.8-24.5.

2 x Pentium III (Coppermine) 700 MHz
512 MB RAM

Prior to the oops I was giving sensors a try (SuSE's sensors-2.8.7-2).
The system seems to be still running properly after this kernel oops ...



Dec 14 09:44:23 diablo kernel: Unable to handle kernel NULL pointer dereference at virtual address 
0000000c
Dec 14 09:44:23 diablo kernel:  printing eip:
Dec 14 09:44:23 diablo kernel: c01ca820
Dec 14 09:44:23 diablo kernel: *pde = 00000000
Dec 14 09:44:23 diablo kernel: Oops: 0000 [#1]
Dec 14 09:44:23 diablo kernel: SMP
Dec 14 09:44:23 diablo kernel: Modules linked in: eeprom w83781d i2c_sensor i2c_isa i2c_dev 
i2c_piix4 i2c_core autofs4 nfsd exportfs af_packet ipt_multiport ipt_conntrack
Dec 14 09:44:23 diablo kernel: CPU:    0
Dec 14 09:44:23 diablo kernel: EIP:    0060:[<c01ca820>]    Not tainted VLI
Dec 14 09:44:23 diablo kernel: EFLAGS: 00010246   (2.6.8-24.5-smp SL92_BRANCH-20041117111006)
Dec 14 09:44:23 diablo kernel: EIP is at nlmclnt_mark_reclaim+0x50/0x70
Dec 14 09:44:23 diablo kernel: eax: 00000000   ebx: d43f2a80   ecx: d43f2a84   edx: d43f2468
Dec 14 09:44:23 diablo kernel: esi: c5e1cde0   edi: 00000002   ebp: c03b5874   esp: d3ff7f1c
Dec 14 09:44:23 diablo kernel: ds: 007b   es: 007b   ss: 0068
Dec 14 09:44:23 diablo kernel: Process lockd (pid: 4429, threadinfo=d3ff6000 task=d1991890)
Dec 14 09:44:23 diablo kernel: Stack: c5e1cde0 0000005b c01ca8bb 00000005 c03b5b80 c5e1cde0 d3ff7f74 
c01cc548
Dec 14 09:44:23 diablo kernel:        d3ff7f48 00000000 dffdeba0 6473666e cdcbb500 0000005b cdfd1600 
cdfd5800
Dec 14 09:44:23 diablo kernel:        c01d20e0 cdfd5800 c01d1fe0 cdfd5800 cdfd1600 c01d210b 77030002 
0264a8c0
Dec 14 09:44:23 diablo kernel: Call Trace:
Dec 14 09:44:23 diablo kernel:  [<c01ca8bb>] nlmclnt_recovery+0x7b/0xe0
Dec 14 09:44:23 diablo kernel:  [<c01cc548>] nlm_host_rebooted+0x118/0x120
Dec 14 09:44:23 diablo kernel:  [<c01d20e0>] nsmsvc_decode_stat_chge+0x0/0xa0
Dec 14 09:44:23 diablo kernel:  [<c01d1fe0>] nsmsvc_proc_notify+0x50/0xc0
Dec 14 09:44:23 diablo kernel:  [<c01d210b>] nsmsvc_decode_stat_chge+0x2b/0xa0
Dec 14 09:44:23 diablo kernel:  [<c03302f6>] svc_process+0x4b6/0x7b0
Dec 14 09:44:23 diablo kernel:  [<c01cca7a>] lockd+0x13a/0x280
Dec 14 09:44:23 diablo kernel:  [<c01cc940>] lockd+0x0/0x280
Dec 14 09:44:23 diablo kernel:  [<c01052b9>] kernel_thread_helper+0x5/0xc
Dec 14 09:44:23 diablo kernel: Code: c2 0f 18 00 90 81 f9 2c 15 3b c0 74 34 8d 59 fc 8b 43 28 8b 40 
08 8b 40 0c 8b 80 a0 00 00 00 81 78 38 69 69 00 00 75 d3 8b 43 58 <39>


Thanks, Richard

-- 
Richard Ems

MTG Marinetechnik GmbH
Wandsbeker Königstr. 62
22041 Hamburg
Telefon: +49 40 65803 312
TeleFax: +49 40 65803 392
mail: richard.ems@mtg-marinetechnik.de

