Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267655AbTBFVlf>; Thu, 6 Feb 2003 16:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267667AbTBFVlf>; Thu, 6 Feb 2003 16:41:35 -0500
Received: from sabre.velocet.net ([216.138.209.205]:24842 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S267655AbTBFVlc>;
	Thu, 6 Feb 2003 16:41:32 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Oops
From: Gregory Stark <gsstark@mit.edu>
Date: 06 Feb 2003 16:51:09 -0500
Message-ID: <87y94tw01e.fsf@stark.dyndns.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got an oops. First time in a long time, As soon as this happened just about
every process started oopsing at the exact same place. The "tainted" is bogus,
it comes from openafs.

Linux stark.dyndns.tv 2.4.19 #6 Tue Sep 10 22:08:51 EDT 2002 i686 unknown unknown GNU/Linux

Feb  6 16:25:41 stark kernel: Unable to handle kernel paging request at virtual address e4d16b48
Feb  6 16:25:41 stark kernel:  printing eip:
Feb  6 16:25:41 stark kernel: c014703c
Feb  6 16:25:41 stark kernel: *pde = 00000000
Feb  6 16:25:41 stark kernel: Oops: 0002
Feb  6 16:25:41 stark kernel: CPU:    0
Feb  6 16:25:41 stark kernel: EIP:    0010:[get_empty_inode+44/160]    Tainted: PF
Feb  6 16:25:41 stark kernel: EFLAGS: 00010202
Feb  6 16:25:41 stark kernel: eax: e4d16b48   ebx: e4d16b40   ecx: c7d16020   edx: c7d16d18
Feb  6 16:25:41 stark kernel: esi: c22cd5e0   edi: bf7ffaec   ebp: bf7ff9fc   esp: c349deec
Feb  6 16:25:41 stark kernel: ds: 0018   es: 0018   ss: 0018
Feb  6 16:25:41 stark kernel: Process xmms (pid: 17771, stackpage=c349d000)
Feb  6 16:25:41 stark kernel: Stack: 00000004 c019d7e6 00000004 c019e3ed 00000004 bf7ff92c bf7ffaec bf7ff644 
Feb  6 16:25:41 stark kernel:        c0214894 ffffffe8 c02148ac 00000206 ffffffff 00003dcf c012f8fb c012f923 
Feb  6 16:25:41 stark kernel:        c0141cda 00000000 c14b0120 00000001 c0141fe8 c349df68 00000001 00000004 
Feb  6 16:25:41 stark kernel: Call Trace:    [sock_alloc+6/192] [sys_accept+61/256] [__free_pages+27/32] [free_pages+35/48] [poll_freewait+58/80]
Feb  6 16:25:41 stark kernel:   [do_select+440/464] [select_bits_free+10/16] [sys_select+1151/1168] [sys_socketcall+188/528] [system_call+51/64]


$ lsmod 
Module                  Size  Used by    Tainted: PF 
ipt_MASQUERADE          1720   1 (autoclean)
ipt_LOG                 3224   1 (autoclean)
ipt_state                600   1 (autoclean)
ipt_TCPMSS              2360   1 (autoclean)
iptable_filter          1704   1 (autoclean)
ip_nat_ftp              3472   0 (unused)
iptable_nat            18680   2 [ipt_MASQUERADE ip_nat_ftp]
ip_conntrack_irc        2592   0 (unused)
ip_conntrack_ftp        3488   0 [ip_nat_ftp]
ip_conntrack           20156   4 [ipt_MASQUERADE ipt_state ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_ftp]
ip_tables              12984   8 [ipt_MASQUERADE ipt_LOG ipt_state ipt_TCPMSS iptable_filter iptable_nat]
ethertap                2500   1
plip                   10872   1 (autoclean)
openafs               403712   2
pcmcia_core            39872   0
serial                 50884   0 (autoclean)
isa-pnp                28708   0 (autoclean) [serial]
parport_pc             25288   2 (autoclean)
lp                      6432   0 (autoclean)
parport                25024   2 (autoclean) [plip parport_pc lp]
mga_vid                 7800   0 (unused)
mga                    98104   0 (unused)
agpgart                16552   1
ide-scsi                7632   0
scsi_mod               51356   1 [ide-scsi]
pppoe                   6924   1
pppox                   1128   1 [pppoe]
ppp_generic            16416   3 [pppoe pppox]
slhc                    4480   0 [ppp_generic]
3c59x                  25008   1
ne2k-pci                4800   1
8390                    5968   0 [ne2k-pci]
rtc                     5916   0 (autoclean)




-- 
greg

