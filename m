Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270401AbRHSNXM>; Sun, 19 Aug 2001 09:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270405AbRHSNXD>; Sun, 19 Aug 2001 09:23:03 -0400
Received: from CPE-61-9-149-76.vic.bigpond.net.au ([61.9.149.76]:17401 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S270401AbRHSNWw>; Sun, 19 Aug 2001 09:22:52 -0400
Message-ID: <3B7FBC03.A3419B18@eyal.emu.id.au>
Date: Sun, 19 Aug 2001 23:15:47 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <laughing@shared-source.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.8-ac7 too many oopses
In-Reply-To: <20010818025122.A32575@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running this for a few days now and this is the first time in a
long
while that I get kernel oops. I did not see an immediate activity that
triggers this but here are the two recent ones.

This is a vanilla 2.4.8-ac7. As much as possible is a module. 


Aug 19 04:36:37 eyal kernel: invalid operand: 0000
Aug 19 04:36:37 eyal kernel: CPU:    0
Aug 19 04:36:37 eyal kernel: EIP:   
0010:[ipt_limit:__insmod_ipt_limit_O/lib/modules/2.4.8-ac7/kernel/net/ipv4/+-353056/96]
Aug 19 04:36:37 eyal kernel: EFLAGS: 00010246
Aug 19 04:36:37 eyal kernel: eax: 00000000   ebx: cf323dc8   ecx:
cf323dc8   edx: 00000008
Aug 19 04:36:37 eyal kernel: esi: 00000000   edi: cf323f3a   ebp:
00000000   esp: cf323d34
Aug 19 04:36:37 eyal kernel: ds: 0018   es: 0018   ss: 0018
Aug 19 04:36:37 eyal kernel: Process find (pid: 3367,
stackpage=cf323000)
Aug 19 04:36:37 eyal kernel: Stack: cf323fb0 cf7ceb44 cf7ceb20 c81eb2c0
d596e004 c146d000 cf323f00 cf323de0 
Aug 19 04:36:37 eyal kernel:        cf323dd8 cf323dd4 cf323dd0 cf323dc8
cf323f38 c1469080 00000000 00000000 
Aug 19 04:36:37 eyal kernel:        00000000 00000001 00000286 000000d2
0000ffc0 00000000 00000000 00000000 
Aug 19 04:36:37 eyal kernel: Call Trace:
[ipt_limit:__insmod_ipt_limit_O/lib/modules/2.4.8-ac7/kernel/net/ipv4/+-307168/96]
[ipt_limit:__insmod_ipt_limit_O/lib/modules/2.4.8-ac7/kernel/net/ipv4/+-296416/96]
[fast_clear_page+10/80] [mmx_clear_page+38/48] [handle_mm_fault+95/208] 
Aug 19 04:36:37 eyal kernel:    [do_page_fault+0/1120]
[do_page_fault+355/1120] [do_page_fault+0/1120] [start_request+315/512]
[ide_do_request+646/720] [schedule+560/864] 
Aug 19 04:36:37 eyal kernel:    [cached_lookup+16/96]
[path_walk+1513/1712] [in_group_p+30/48] [vfs_permission+121/256]
[permission+42/48] [open_namei+732/1280] 
Aug 19 04:36:37 eyal kernel:   
[ipt_limit:__insmod_ipt_limit_O/lib/modules/2.4.8-ac7/kernel/net/ipv4/+-351344/96]
[filldir+0/224] [vfs_readdir+97/144] [filldir+0/224]
[sys_getdents+74/160] [filldir+0/224] 
Aug 19 04:36:37 eyal kernel:    [system_call+51/56] 
Aug 19 04:36:37 eyal kernel: 
Aug 19 04:36:37 eyal kernel: Code: 0f 0b 89 f0 83 f8 01 7f 48 89 e8 45
83 7c 24 54 00 75 1e 80 


Aug 19 22:33:53 eyal kernel: invalid operand: 0000
Aug 19 22:33:53 eyal kernel: CPU:    0
Aug 19 22:33:53 eyal kernel: EIP:   
0010:[ipt_limit:__insmod_ipt_limit_O/lib/modules/2.4.8-ac7/kernel/net/ipv4/+-353056/96]
Aug 19 22:33:53 eyal kernel: EFLAGS: 00010246
Aug 19 22:33:53 eyal kernel: eax: 00000000   ebx: cbe2bdc8   ecx:
cbe2bdc8   edx: 00000008
Aug 19 22:33:53 eyal kernel: esi: 00000000   edi: cbe2bf3a   ebp:
00000000   esp: cbe2bd34
Aug 19 22:33:53 eyal kernel: ds: 0018   es: 0018   ss: 0018
Aug 19 22:33:53 eyal kernel: Process bash (pid: 396, stackpage=cbe2b000)
Aug 19 22:33:53 eyal kernel: Stack: cbe2bfb0 cfb03b44 cfb03b20 c9f8e6c0
40001ea0 c146d000 cbe2bf00 cbe2bde0 
Aug 19 22:33:53 eyal kernel:        cbe2bdd8 cbe2bdd4 cbe2bdd0 cbe2bdc8
cbe2bf38 c1469080 00000000 00000000 
Aug 19 22:33:53 eyal kernel:        00000000 00000001 c024b600 c01ec000
0000bf00 00000000 00000000 00000000 
Aug 19 22:33:53 eyal kernel: Call Trace:
[ipt_limit:__insmod_ipt_limit_O/lib/modules/2.4.8-ac7/kernel/net/ipv4/+-307168/96]
[ipt_limit:__insmod_ipt_limit_O/lib/modules/2.4.8-ac7/kernel/net/ipv4/+-296416/96]
[n_tty_receive_buf+3813/3872] [ide_dmaproc+309/528]
[__alloc_pages+90/576] 
Aug 19 22:33:53 eyal kernel:    [fast_clear_page+10/80]
[mmx_clear_page+38/48] [do_anonymous_page+93/144] [do_no_page+49/288]
[handle_mm_fault+95/208] [do_page_fault+0/1120] 
Aug 19 22:33:53 eyal kernel:    [do_page_fault+355/1120]
[do_page_fault+0/1120] [do_munmap+86/560]
[ipt_limit:__insmod_ipt_limit_O/lib/modules/2.4.8-ac7/kernel/net/ipv4/+-351344/96]
[filldir+0/224] [vfs_readdir+97/144] 
Aug 19 22:33:53 eyal kernel:    [filldir+0/224] [sys_getdents+74/160]
[filldir+0/224] [system_call+51/56] 
Aug 19 22:33:53 eyal kernel: 
Aug 19 22:33:53 eyal kernel: Code: 0f 0b 89 f0 83 f8 01 7f 48 89 e8 45
83 7c 24 54 00 75 1e 80
