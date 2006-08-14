Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWHNP24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWHNP24 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWHNP24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:28:56 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:8969 "EHLO
	smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750873AbWHNP2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:28:55 -0400
Message-ID: <44E096B4.9090207@xs4all.nl>
Date: Mon, 14 Aug 2006 17:28:52 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Folkert van Heusden <folkert@vanheusden.com>
Subject: And another Oops / BUG? (2.6.17.7 on VIA Epia CL6000)
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since 2.6.17.x my kernel Oopses every few days. Bewlo is the log.
Every time my named is gone and needs killing and restarting.
Also upsd looses sync and gets upset.
ntpd readjusts after a while.
Notice the entropyd message. That never really happens.
I posted a few more of these in the previous weeks.
Does anybody know how I can find the more exact cause?
The kernel was compiled with
CONFIG_FRAME_POINTER=y
CONFIG_UNWIND_INFO=y.


Udo

Aug 14 04:25:04 epia upsd[1749]: Connection from 127.0.0.1
Aug 14 04:25:04 epia upsd[1749]: Client on 127.0.0.1 logged out
Aug 14 04:26:33 epia audio-entropyd: Lower treshold exceeded (998 bits)
Aug 14 04:26:35 epia kernel: BUG: unable to handle kernel paging request
at virtual address 553aed86
Aug 14 04:26:35 epia kernel:  printing eip:
Aug 14 04:26:35 epia kernel: 553aed86
Aug 14 04:26:35 epia kernel: *pde = 00000000
Aug 14 04:26:35 epia kernel: Oops: 0000 [#1]
Aug 14 04:26:35 epia kernel: PREEMPT
Aug 14 04:26:35 epia kernel: Modules linked in: nls_utf8 cifs sch_tbf
xt_string xt_MARK xt_length xt_tcpmss xt_mac xt_mark vt1211 hwmon_vid
i2c_isa ipv6 ipt_t
tl ipt_owner ip_nat_irc ip_conntrack_irc ipt_REDIRECT ipt_tos ip_nat_ftp
ip_conntrack_ftp ip_nat_h323 ip_conntrack_h323 ipt_MASQUERADE ipt_LOG
ipt_TCPMSS ipt_
REJECT xt_limit xt_state ipt_TARPIT iptable_filter ipt_TOS
iptable_mangle xt_NOTRACK iptable_raw binfmt_misc lp parport_pc parport
nvram ehci_hcd uhci_hcd snd
_via82xx snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_page_alloc snd_mpu40
1_uart snd_rawmidi snd_seq_device snd i2c_viapro
Aug 14 04:26:35 epia kernel: CPU:    0
Aug 14 04:26:35 epia kernel: EIP:
0060:[phys_startup_32+1428876678/-1073741824]    Not tainted VLI
Aug 14 04:26:35 epia kernel: EIP:    0060:[<553aed86>]    Not tainted VLI
Aug 14 04:26:35 epia kernel: EFLAGS: 00010296   (2.6.17.8 #12)
Aug 14 04:26:35 epia kernel: EIP is at 0x553aed86
Aug 14 04:26:35 epia kernel: eax: 00000000   ebx: 924eecff   ecx:
0000000d   edx: 00000001
Aug 14 04:26:35 epia kernel: esi: 7c9a0e80   edi: f9f925b8   ebp:
c0aa6dd9   esp: dd75ff28
Aug 14 04:26:35 epia kernel: ds: 007b   es: 007b   ss: 0068
Aug 14 04:26:35 epia kernel: Process named (pid: 1607,
threadinfo=dd75e000 task=dd6c7550)
Aug 14 04:26:35 epia kernel: Stack: 3519a876 6a8528d0 76ebebdb 97091f21
43561d76 4c991412 87b5d422 d474fa23
Aug 14 04:26:35 epia kernel:        65bbd53a 1d7b680d 9e8b4630 bd751892
ca43d47d 570bf949 88457507 7dca03e0
Aug 14 04:26:35 epia kernel:        5f1447af 5069423b 77e75221 687a9f0c
99c5e09f 7281fcf7 88ee8105 e31b1e8e
Aug 14 04:26:35 epia kernel: Call Trace:
Aug 14 04:26:35 epia pptp[1656]: anon log[decaps_gre:pptp_gre.c:407]:
buffering packet 4563834 (expecting 4563791, lost or reordered)
Aug 14 04:26:35 epia kernel:  <c0103675> show_stack_log_lvl+0x85/0x90
<c010380b> show_registers+0x14b/0x1c0
Aug 14 04:26:35 epia kernel:  <c01039e2> die+0x162/0x240  <c010f7d1>
do_page_fault+0x441/0x524
Aug 14 04:26:35 epia pptp[1656]: anon log[decaps_gre:pptp_gre.c:407]:
buffering packet 4563835 (expecting 4563791, lost or reordered)
Aug 14 04:26:35 epia kernel:  <c010308f> error_code+0x4f/0x60
Aug 14 04:26:35 epia pptp[1656]: anon log[decaps_gre:pptp_gre.c:407]:
buffering packet 4563836 (expecting 4563791, lost or reordered)
Aug 14 04:26:35 epia kernel: Code:  Bad EIP value.
Aug 14 04:26:35 epia pptp[1656]: anon log[decaps_gre:pptp_gre.c:407]:
buffering packet 4563837 (expecting 4563791, lost or reordered)
Aug 14 04:26:35 epia kernel: EIP:
[phys_startup_32+1428876678/-1073741824] 0x553aed86 SS:ESP 0068:dd75ff28
Aug 14 04:26:35 epia pptp[1656]: anon log[decaps_gre:pptp_gre.c:407]:
buffering packet 4563838 (expecting 4563791, lost or reordered)
Aug 14 04:26:35 epia kernel: EIP: [<553aed86>] 0x553aed86 SS:ESP
0068:dd75ff28
Aug 14 04:26:35 epia pptp[1656]: anon log[decaps_gre:pptp_gre.c:407]:
buffering packet 4563839 (expecting 4563791, lost or reordered)
Aug 14 04:26:35 epia pptp[1656]: anon log[decaps_gre:pptp_gre.c:407]:
buffering packet 4563840 (expecting 4563791, lost or reordered)
Aug 14 04:26:35 epia pptp[1656]: anon log[decaps_gre:pptp_gre.c:407]:
buffering packet 4563841 (expecting 4563791, lost or reordered)
Aug 14 04:26:35 epia pptp[1656]: anon log[decaps_gre:pptp_gre.c:407]:
buffering packet 4563842 (expecting 4563791, lost or reordered)
Aug 14 04:26:35 epia pptp[1656]: anon log[decaps_gre:pptp_gre.c:407]:
buffering packet 4563843 (expecting 4563791, lost or reordered)
Aug 14 04:26:35 epia pptp[1656]: anon log[decaps_gre:pptp_gre.c:407]:
buffering packet 4563844 (expecting 4563791, lost or reordered)
Aug 14 04:26:37 epia upsd[1749]: Data for UPS [myups] is stale - check
driver
Aug 14 04:26:39 epia upsd[1749]: UPS [myups] data is no longer stale


