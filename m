Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268083AbUIVW7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268083AbUIVW7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 18:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268085AbUIVW7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 18:59:18 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:14026 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S268083AbUIVW7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 18:59:01 -0400
Date: Thu, 23 Sep 2004 01:58:59 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ReiserFS Mailing List <reiserfs-list@namesys.com>
Subject: Linux-2.6.9-rc2-bk7 Oops - ReiserFS: warning: vs-500: unknown uniqueness 126844928
Message-ID: <20040922225859.GA12833@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
	ReiserFS Mailing List <reiserfs-list@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got no replies for messages <20040713110437.GA4571@m.safari.iki.fi>
and <20040714214146.GA23531@m.safari.iki.fi> to LKML,
so I try again with latest releases.  Now using 2.6.9-rc2-bk7, and I
guess reiserfs might be related somehow so you folks got Cc'ed. 
reiserfsck 3.6.18 found no problems for the partition
(/var, 1G) after reboot, I can access every file in there and I don't
have hardware problems, memtest+ runs happily for 24 hours without
errors and 2.4 series have also worked without too much
unexplained Oopsings with the same hardware.  Besides, there's
always the same 14000030 addresss...

Linux safari.finland.fbi 2.6.9-rc2-bk7 #4 SMP Wed Sep 22 15:25:34 EEST 2004 i686 i686 i386 GNU/Linux
 
Gnu C                  3.4.2
Gnu make               3.80
binutils               2.15.91.0.2
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre5
e2fsprogs              1.35
jfsutils               1.0.24
reiserfsprogs          3.6.18
reiser4progs           line
xfsprogs               2.3.9
pcmcia-cs              3.2.7
quota-tools            3.11.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         sch_hfsc cls_fw cls_route sch_ingress sch_red sch_tbf
	sch_teql sch_prio sch_gred cls_rsvp cls_rsvp6 cls_tcindex sch_cbq sch_dsmark
	ipt_ttl ipt_tos ipt_tcpmss ipt_sctp ipt_recent ipt_pkttype ipt_physdev ipt_mark
	ipt_mac ipt_iprange ipt_helper ipt_esp ipt_ecn ipt_dscp ipt_conntrack ipt_ah
	ipt_addrtype ipt_ULOG ipt_TOS ipt_TCPMSS ipt_SAME ipt_REDIRECT ipt_NOTRACK
	ipt_NETMAP ipt_MASQUERADE ipt_MARK ipt_DSCP ipt_CLASSIFY snd_seq_midi
	snd_seq_oss snd_seq_midi_event snd_seq lp parport_pc parport w83781d i2c_sensor
	i2c_piix4 mga tuner tvaudio msp3400 bttv video_buf i2c_algo_bit v4l2_common
	btcx_risc i2c_core videodev ohci_hcd loop ipt_connlimit ipt_length ipt_TARPIT
	dm_mod ipt_ECN ipt_state ipt_multiport ipt_owner cls_u32 sch_sfq sch_htb
	ipt_REJECT ip6t_LOG ipt_LOG ipt_limit ip6table_filter ip6_tables uhci_hcd md5
	ipv6 snd_ens1371 snd_rawmidi snd_seq_device snd_pcm_oss snd_mixer_oss
	iptable_raw iptable_mangle snd_pcm iptable_nat ip_conntrack iptable_filter
	ip_tables snd_timer snd_page_alloc snd_ac97_codec snd soundcore gameport irlan
	irda crc_ccitt 8139too mii floppy sg scsi_mod


I got this oops when I was doing rpmbuild --rebuild ... 


Sep 22 23:00:40 safari kernel: ReiserFS: warning: vs-500: unknown uniqueness 126844928
Sep 22 23:00:40 safari last message repeated 4 times
Sep 22 23:00:40 safari kernel: ReiserFS: hda1: warning: vs-500: unknown uniqueness 126844928
Sep 22 23:03:08 safari kernel: Unable to handle kernel paging request at virtual address 14000030
Sep 22 23:03:08 safari kernel:  printing eip:
Sep 22 23:03:08 safari kernel: c016e255
Sep 22 23:03:08 safari kernel: *pde = 00000000
Sep 22 23:03:08 safari kernel: Oops: 0000 [#1]
Sep 22 23:03:08 safari kernel: SMP 
Sep 22 23:03:08 safari kernel: Modules linked in: xfs sch_hfsc cls_fw
	cls_route sch_ingress sch_red sch_tbf sch_teql sch_prio sch_gred cls_rsvp
	cls_rsvp6 cls_tcindex sch_cbq sch_dsmark ipt_ttl ipt_tos ipt_tcpmss ipt_sctp
	ipt_recent ipt_pkttype ipt_physdev ipt_mark ipt_mac ipt_iprange ipt_helper
	ipt_esp ipt_ecn ipt_dscp ipt_conntrack ipt_ah ipt_addrtype ipt_ULOG ipt_TOS
	ipt_TCPMSS ipt_SAME ipt_REDIRECT ipt_NOTRACK ipt_NETMAP ipt_MASQUERADE
	ipt_MARK ipt_DSCP ipt_CLASSIFY snd_seq_midi snd_seq_oss snd_seq_midi_event
	snd_seq lp parport_pc parport w83781d mga i2c_sensor i2c_piix4 tuner tvaudio
	msp3400 bttv video_buf i2c_algo_bit v4l2_common btcx_risc i2c_core videodev
	ohci_hcd loop ipt_connlimit ipt_length ipt_TARPIT ipt_ECN ipt_state
	ipt_multiport ipt_owner dm_mod cls_u32 sch_sfq sch_htb ipt_REJECT ip6t_LOG
	ipt_LOG ipt_limit ip6table_filter ip6_tables md5 ipv6 uhci_hcd snd_ens1371
	snd_rawmidi iptable_raw snd_seq_device iptable_mangle snd_pcm_oss iptable_nat
	snd_mixer_oss ip_conntrack snd_pcm snd_timer iptable_filter
Sep 22 23:03:08 safari kernel: ip_tables snd_page_alloc snd_ac97_codec snd
	soundcore gameport irlan irda crc_ccitt 8139too mii floppy sg scsi_mod
Sep 22 23:03:08 safari kernel: CPU:    0
Sep 22 23:03:08 safari kernel: EIP:    0060:[<c016e255>]    Not tainted VLI
Sep 22 23:03:08 safari kernel: EFLAGS: 00210202   (2.6.9-rc2-bk7) 
Sep 22 23:03:08 safari kernel: EIP is at link_path_walk+0x7c5/0xdd0
Sep 22 23:03:08 safari kernel: eax: 14000008   ebx: 00000000   ecx: cd52beb0   edx: ccd51ed0
Sep 22 23:03:08 safari kernel: esi: ccd51ed4   edi: ce71c084   ebp: ccd51ef0   esp: ccd51e98
Sep 22 23:03:08 safari kernel: ds: 007b   es: 007b   ss: 0068
Sep 22 23:03:08 safari kernel: Process sed (pid: 9260, threadinfo=ccd51000 task=cd32cbf0)
Sep 22 23:03:08 safari kernel: Stack: c68b500b c68b5000 cd52beb0 02e94c60 cf04a430 c526f6b4 00000001 c526f6b4 
Sep 22 23:03:08 safari kernel:        02e94c60 ce91b02c 00000101 ce71c084 ccd51f50 c12e3c80 cd52beb0 c0010da2 
Sep 22 23:03:08 safari kernel:        0000000b c68b5000 c526f6b4 ccd51000 ccd51f50 00000000 ccd51f08 c016eb31 
Sep 22 23:03:08 safari kernel: Call Trace:
Sep 22 23:03:08 safari kernel:  [<c010630a>] show_stack+0x7a/0x90
Sep 22 23:03:08 safari kernel:  [<c0106492>] show_registers+0x152/0x1d0
Sep 22 23:03:08 safari kernel:  [<c010668d>] die+0xed/0x180
Sep 22 23:03:08 safari kernel:  [<c011b4a7>] do_page_fault+0x427/0x5f9
Sep 22 23:03:08 safari kernel:  [<c038368b>] error_code+0x2f/0x38
Sep 22 23:03:08 safari kernel:  [<c016eb31>] path_lookup+0xa1/0x1b0
Sep 22 23:03:08 safari kernel:  [<c016f42a>] open_namei+0x8a/0x6a0
Sep 22 23:03:08 safari kernel:  [<c015f189>] filp_open+0x29/0x50
Sep 22 23:03:08 safari kernel:  [<c015f56c>] sys_open+0x3c/0xa0
Sep 22 23:03:08 safari kernel:  [<c0382c03>] syscall_call+0x7/0xb
Sep 22 23:03:08 safari kernel: Code: ff 8b 4d e0 31 c0 89 4d b0 8b 79 10 85 ff 89 7d d4 0f 95 c0 85 45 d0 0f 84 b0 03 00 00 8b 87 9c 00 00 00 85 c0 0f 84 a2 03 00 00 <8b> 58 28 85 db 0f 84 97 03 00 00 8b 45 dc 85 c0 74 0a f0 ff 40 
Sep 22 23:09:43 safari kernel:  <1>Unable to handle kernel paging request at virtual address 14000030
Sep 22 23:09:43 safari kernel:  printing eip:
Sep 22 23:09:43 safari kernel: c016e255
Sep 22 23:09:43 safari kernel: *pde = 00000000
Sep 22 23:09:43 safari kernel: Oops: 0000 [#2]
Sep 22 23:09:43 safari kernel: SMP 
Sep 22 23:09:43 safari kernel: Modules linked in: foo 
Sep 22 23:09:43 safari kernel: CPU:    0
Sep 22 23:09:43 safari kernel: EIP:    0060:[<c016e255>]    Not tainted VLI
Sep 22 23:09:43 safari kernel: EFLAGS: 00210202   (2.6.9-rc2-bk7) 
Sep 22 23:09:43 safari kernel: EIP is at link_path_walk+0x7c5/0xdd0
Sep 22 23:09:43 safari kernel: eax: 14000008   ebx: 00000000   ecx: cd52beb0   edx: ccd51eac
Sep 22 23:09:43 safari kernel: esi: ccd51eb0   edi: ce71c084   ebp: ccd51ecc   esp: ccd51e74
Sep 22 23:09:43 safari kernel: ds: 007b   es: 007b   ss: 0068
Sep 22 23:09:43 safari kernel: Process find (pid: 17341, threadinfo=ccd51000 task=c9099190)
Sep 22 23:09:43 safari kernel: Stack: c7cdb00b c7cdb000 cd52beb0 c12d9ac0 00200246 ccd51eb0 00200246 00200246 
Sep 22 23:09:43 safari kernel:        00000001 00000000 00000001 ce71c084 ccd51f04 c12e3c80 cd52beb0 c0010da2 
Sep 22 23:09:43 safari kernel:        0000000b c7cdb000 ccd51f68 ccd51000 ccd51f04 00000000 ccd51ee4 c016eb31 
Sep 22 23:09:43 safari kernel: Call Trace:
Sep 22 23:09:43 safari kernel:  [<c010630a>] show_stack+0x7a/0x90
Sep 22 23:09:43 safari kernel:  [<c0106492>] show_registers+0x152/0x1d0
Sep 22 23:09:43 safari kernel:  [<c010668d>] die+0xed/0x180
Sep 22 23:09:43 safari kernel:  [<c011b4a7>] do_page_fault+0x427/0x5f9
Sep 22 23:09:43 safari kernel:  [<c038368b>] error_code+0x2f/0x38
Sep 22 23:09:43 safari kernel:  [<c016eb31>] path_lookup+0xa1/0x1b0
Sep 22 23:09:43 safari kernel:  [<c016ed9d>] __user_walk+0x2d/0x70
Sep 22 23:09:43 safari kernel:  [<c01697f0>] vfs_stat+0x20/0x60
Sep 22 23:09:43 safari kernel:  [<c0169f04>] sys_stat64+0x14/0x30
Sep 22 23:09:43 safari kernel:  [<c0382c03>] syscall_call+0x7/0xb
Sep 22 23:09:43 safari kernel: Code: ff 8b 4d e0 31 c0 89 4d b0 8b 79 10 85 ff 89 7d d4 0f 95 c0 85 45 d0 0f 84 b0 03 00 00 8b 87 9c 00 00 00 85 c0 0f 84 a2 03 00 00 <8b> 58 28 85 db 0f 84 97 03 00 00 8b 45 dc 85 c0 74 0a f0 ff 40 
Sep 22 23:11:03 safari kernel:  <1>Unable to handle kernel paging request at virtual address 14000030
Sep 22 23:11:03 safari kernel:  printing eip:
Sep 22 23:11:03 safari kernel: c016e255
Sep 22 23:11:03 safari kernel: *pde = 00000000
Sep 22 23:11:03 safari kernel: Oops: 0000 [#3]
Sep 22 23:11:03 safari kernel: SMP 
Sep 22 23:11:03 safari kernel: Modules linked in: foo 
Sep 22 23:11:03 safari kernel: CPU:    0
Sep 22 23:11:03 safari kernel: EIP:    0060:[<c016e255>]    Not tainted VLI
Sep 22 23:11:03 safari kernel: EFLAGS: 00210202   (2.6.9-rc2-bk7) 
Sep 22 23:11:03 safari kernel: EIP is at link_path_walk+0x7c5/0xdd0
Sep 22 23:11:03 safari kernel: eax: 14000008   ebx: 00000000   ecx: cd52beb0   edx: c96e3eac
Sep 22 23:11:03 safari kernel: esi: c96e3eb0   edi: ce71c084   ebp: c96e3ecc   esp: c96e3e74
Sep 22 23:11:03 safari kernel: ds: 007b   es: 007b   ss: 0068
Sep 22 23:11:03 safari kernel: Process find (pid: 26698, threadinfo=c96e3000 task=c1ce1730)
Sep 22 23:11:03 safari kernel: Stack: c1fde00b c1fde000 cd52beb0 c12d9ac0 00200246 c96e3eb0 00200246 00200246 
Sep 22 23:11:03 safari kernel:        00000001 00000000 00000001 ce71c084 c96e3f04 c12e3c80 cd52beb0 c0010da2 
Sep 22 23:11:03 safari kernel:        0000000b c1fde000 c96e3f68 c96e3000 c96e3f04 00000000 c96e3ee4 c016eb31 
Sep 22 23:11:03 safari kernel: Call Trace:
Sep 22 23:11:03 safari kernel:  [<c010630a>] show_stack+0x7a/0x90
Sep 22 23:11:03 safari kernel:  [<c0106492>] show_registers+0x152/0x1d0
Sep 22 23:11:03 safari kernel:  [<c010668d>] die+0xed/0x180
Sep 22 23:11:03 safari kernel:  [<c011b4a7>] do_page_fault+0x427/0x5f9
Sep 22 23:11:03 safari kernel:  [<c038368b>] error_code+0x2f/0x38
Sep 22 23:11:03 safari kernel:  [<c016eb31>] path_lookup+0xa1/0x1b0
Sep 22 23:11:03 safari kernel:  [<c016ed9d>] __user_walk+0x2d/0x70
Sep 22 23:11:03 safari kernel:  [<c01697f0>] vfs_stat+0x20/0x60
Sep 22 23:11:03 safari kernel:  [<c0169f04>] sys_stat64+0x14/0x30
Sep 22 23:11:03 safari kernel:  [<c0382c03>] syscall_call+0x7/0xb
Sep 22 23:11:03 safari kernel: Code: ff 8b 4d e0 31 c0 89 4d b0 8b 79 10 85 ff 89 7d d4 0f 95 c0 85 45 d0 0f 84 b0 03 00 00 8b 87 9c 00 00 00 85 c0 0f 84 a2 03 00 00 <8b> 58 28 85 db 0f 84 97 03 00 00 8b 45 dc 85 c0 74 0a f0 ff 40 


PS. I have plenty of Oops logs for 2.6.8-rc2 -- if you want to see 'em,
just tell me how many you want. 

-- 

