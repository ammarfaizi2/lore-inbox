Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbTLHJQz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 04:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265353AbTLHJQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 04:16:55 -0500
Received: from rrba-178-211.telkomadsl.co.za ([165.165.178.211]:16400 "EHLO
	r2d2.ractech.co.za") by vger.kernel.org with ESMTP id S265352AbTLHJQy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 04:16:54 -0500
From: Karel Koster <karel@ractech.co.za>
Organization: RACTech
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at vmscan.c:118
Date: Mon, 8 Dec 2003 11:16:38 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312081116.11185.karel@ractech.co.za>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nov 29 04:03:49 urukhai kernel: kernel BUG at vmscan.c:118!
Nov 29 04:03:49 urukhai kernel: invalid operand: 0000
Nov 29 04:03:49 urukhai kernel: sd_mod scsi_mod ide-cd cdrom maestro3 
ac97_codec soundcore mach64 agpgart parport_pc
lp parport autofs ds yenta_socket pcmcia_core xircom_cb ipt_REJECT iptabl
Nov 29 04:03:49 urukhai kernel: CPU:    0
Nov 29 04:03:49 urukhai kernel: EIP:    0060:[<c013b962>]    Not tainted
Nov 29 04:03:49 urukhai kernel: EFLAGS: 00010206
Nov 29 04:03:49 urukhai kernel:
Nov 29 04:03:49 urukhai kernel: EIP is at reclaim_page [kernel] 0x2a2 
(2.4.20-8)
Nov 29 04:03:49 urukhai kernel: eax: 400b0730   ebx: c51ed76c   ecx: 00000100   
edx: 0000059d
Nov 29 04:03:49 urukhai kernel: esi: c030d100   edi: c51ed750   ebp: 00000d8e   
esp: cced9d7c
Nov 29 04:03:49 urukhai kernel: ds: 0068   es: 0068   ss: 0068
Nov 29 04:03:49 urukhai kernel: Process run-parts (pid: 4395, 
stackpage=cced9000)
Nov 29 04:03:49 urukhai kernel: Stack: ce75ad00 00000000 c030d344 00000000 
c030d100 c030d724 00000003 00000001
Nov 29 04:03:49 urukhai kernel:        c013e8c9 c030d72c 0000031f 000001d2 
00000000 c013e9b5 c030d720 00000000
Nov 29 04:03:49 urukhai kernel:        00000003 00000001 c0134750 ce75ad00 
cced9e14 cced9de0 00000001 c030d720
Nov 29 04:03:49 urukhai kernel: Call Trace:   [<c013e8c9>] __alloc_pages_limit 
[kernel] 0x79 (0xcced9d9c))
Nov 29 04:03:49 urukhai kernel: [<c013e9b5>] __alloc_pages [kernel] 0xc5 
(0xcced9db0))
Nov 29 04:03:49 urukhai kernel: [<c0134750>] generic_file_read [kernel] 0xb0 
(0xcced9dc4))
Nov 29 04:03:49 urukhai kernel: [<c014f393>] copy_strings [kernel] 0x283 
(0xcced9dec))
Nov 29 04:03:49 urukhai kernel: [<c014f802>] kernel_read [kernel] 0x72 
(0xcced9e00))
Nov 29 04:03:49 urukhai kernel: [<c014f408>] copy_strings_kernel [kernel] 0x38 
(0xcced9e2c))
Nov 29 04:03:49 urukhai kernel: [<c015015e>] do_execve [kernel] 0x10e 
(0xcced9e44))
Nov 29 04:03:49 urukhai kernel: [<c0107c00>] sys_execve [kernel] 0x50 
(0xcced9fa4))
Nov 29 04:03:49 urukhai kernel: [<c0109537>] system_call [kernel] 0x33 
(0xcced9fc0))
Nov 29 04:03:49 urukhai kernel:
Nov 29 04:03:49 urukhai kernel:
Nov 29 04:03:49 urukhai kernel: Code: 0f 0b 76 00 d0 ee 25 c0 e9 9d fd ff ff 
90 83 ec 18 ba 01 00

