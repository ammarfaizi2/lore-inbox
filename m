Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbVK3TU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbVK3TU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 14:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbVK3TU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 14:20:59 -0500
Received: from pm-mx5.mgn.net ([195.46.220.209]:49060 "EHLO pm-mx5.mx.noos.fr")
	by vger.kernel.org with ESMTP id S1751552AbVK3TU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 14:20:58 -0500
Date: Wed, 30 Nov 2005 20:20:50 +0100
From: Damien Wyart <damien.wyart@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: BUG in kernel checked out 24 hours ago
Message-ID: <20051130192050.GA13596@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Please find the log from a BUG I encountered this evening while running
a kernel I had checkouted from git and compiled arond 6pm UTC yesterday.
The computer froze and I could reboot it with Sysrq.

Any comments welcome, notably about if this has been corrected since or
not (I am not insider enough to be sure). I am currently compileing
a freshly checkouted kernel to see if it runs better.


Thanks in advance,

-- 
Damien Wyart

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kern.log"

Nov 30 19:14:57 brouette kernel: ------------[ cut here ]------------
Nov 30 19:14:57 brouette kernel: kernel BUG at mm/rmap.c:486!
Nov 30 19:14:57 brouette kernel: invalid operand: 0000 [#1]
Nov 30 19:14:57 brouette kernel: SMP 
Nov 30 19:14:57 brouette kernel: Modules linked in: nvidia nls_iso8859_1 nls_cp437 vfat fat xfs jfs snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_ac97_bus snd_page_alloc snd_util_mem snd_hwdep parport_pc parport snd pcspkr soundcore ehci_hcd uhci_hcd usbcore
Nov 30 19:14:57 brouette kernel: CPU:    1
Nov 30 19:14:57 brouette kernel: EIP:    0060:[page_remove_rmap+55/65]    Tainted: P      VLI
Nov 30 19:14:57 brouette kernel: EFLAGS: 00210286   (2.6.15-rc3-git-29112005dw) 
Nov 30 19:14:57 brouette kernel: EIP is at page_remove_rmap+0x37/0x41
Nov 30 19:14:57 brouette kernel: eax: ffffffff   ebx: de5dcab4   ecx: c10d3780   edx: c10d3780
Nov 30 19:14:57 brouette kernel: esi: b66ad000   edi: c10d3780   ebp: 00000020   esp: dcb0fda0
Nov 30 19:14:57 brouette kernel: ds: 007b   es: 007b   ss: 0068
Nov 30 19:14:57 brouette kernel: Process flurry (pid: 21277, threadinfo=dcb0e000 task=e305ba50)
Nov 30 19:14:57 brouette kernel: Stack: b66ad000 de5dcab4 c014a0c4 c10d3780 b66ad000 069bc067 f7ac3900 ffffffff 
Nov 30 19:14:57 brouette kernel:        00000000 f7ac3940 e4e50b64 b66b1000 dcb0fe38 e4e50b64 c014a283 c180d900 
Nov 30 19:14:57 brouette kernel:        dea558b4 e4e50b64 b66ad000 b66b1000 dcb0fe38 00000000 e4e50b64 b66b0fff 
Nov 30 19:14:57 brouette kernel: Call Trace:
Nov 30 19:14:57 brouette kernel:  [zap_pte_range+549/760] zap_pte_range+0x225/0x2f8
Nov 30 19:14:57 brouette kernel:  [unmap_page_range+236/280] unmap_page_range+0xec/0x118
Nov 30 19:14:57 brouette kernel:  [unmap_vmas+200/518] unmap_vmas+0xc8/0x206
Nov 30 19:14:57 brouette kernel:  [exit_mmap+143/287] exit_mmap+0x8f/0x11f
Nov 30 19:14:57 brouette kernel:  [mmput+41/132] mmput+0x29/0x84
Nov 30 19:14:57 brouette kernel:  [do_exit+248/1001] do_exit+0xf8/0x3e9
Nov 30 19:14:57 brouette kernel:  [do_group_exit+48/150] do_group_exit+0x30/0x96
Nov 30 19:14:57 brouette kernel:  [get_signal_to_deliver+530/799] get_signal_to_deliver+0x212/0x31f
Nov 30 19:14:57 brouette kernel:  [do_signal+83/255] do_signal+0x53/0xff
Nov 30 19:14:57 brouette kernel:  [schedule+1279/3301] schedule+0x4ff/0xce5
Nov 30 19:14:57 brouette kernel:  [sys_sched_yield+93/124] sys_sched_yield+0x5d/0x7c
Nov 30 19:14:57 brouette kernel:  [do_notify_resume+40/58] do_notify_resume+0x28/0x3a
Nov 30 19:14:57 brouette kernel:  [work_notifysig+19/25] work_notifysig+0x13/0x19
Nov 30 19:14:57 brouette kernel: Code: 0f 98 c0 84 c0 75 04 83 c4 08 c3 8b 42 08 83 c0 01 78 18 c7 44 24 04 ff ff ff ff c7 04 24 10 00 00 00 e8 87 f8 fe ff 83 c4 08 c3 <0f> 0b e6 01 a8 f4 36 c0 eb de 55 57 56 53 83 ec 1c 8b 6c 24 30 
Nov 30 19:14:57 brouette kernel:  <1>Fixing recursive fault but reboot is needed!
Nov 30 19:14:57 brouette kernel: scheduling while atomic: flurry/0x00000001/21277
Nov 30 19:14:57 brouette kernel:  [schedule+2205/3301] schedule+0x89d/0xce5
Nov 30 19:14:57 brouette kernel:  [__do_softirq+114/221] __do_softirq+0x72/0xdd
Nov 30 19:14:57 brouette kernel:  [do_exit+884/1001] do_exit+0x374/0x3e9
Nov 30 19:14:57 brouette kernel:  [do_divide_error+0/189] do_divide_error+0x0/0xbd
Nov 30 19:14:57 brouette kernel:  [do_invalid_op+0/189] do_invalid_op+0x0/0xbd
Nov 30 19:14:57 brouette kernel:  [do_invalid_op+180/189] do_invalid_op+0xb4/0xbd
Nov 30 19:14:57 brouette kernel:  [page_remove_rmap+55/65] page_remove_rmap+0x37/0x41
Nov 30 19:14:57 brouette kernel:  [bad_range+54/68] bad_range+0x36/0x44
Nov 30 19:14:57 brouette kernel:  [free_pages_bulk+590/653] free_pages_bulk+0x24e/0x28d
Nov 30 19:14:57 brouette kernel:  [error_code+79/84] error_code+0x4f/0x54
Nov 30 19:14:57 brouette kernel:  [page_remove_rmap+55/65] page_remove_rmap+0x37/0x41
Nov 30 19:14:57 brouette kernel:  [zap_pte_range+549/760] zap_pte_range+0x225/0x2f8
Nov 30 19:14:57 brouette kernel:  [unmap_page_range+236/280] unmap_page_range+0xec/0x118
Nov 30 19:14:57 brouette kernel:  [unmap_vmas+200/518] unmap_vmas+0xc8/0x206
Nov 30 19:14:57 brouette kernel:  [exit_mmap+143/287] exit_mmap+0x8f/0x11f
Nov 30 19:14:57 brouette kernel:  [mmput+41/132] mmput+0x29/0x84
Nov 30 19:14:57 brouette kernel:  [do_exit+248/1001] do_exit+0xf8/0x3e9
Nov 30 19:14:57 brouette kernel:  [do_group_exit+48/150] do_group_exit+0x30/0x96
Nov 30 19:14:57 brouette kernel:  [get_signal_to_deliver+530/799] get_signal_to_deliver+0x212/0x31f
Nov 30 19:14:57 brouette kernel:  [do_signal+83/255] do_signal+0x53/0xff
Nov 30 19:14:57 brouette kernel:  [schedule+1279/3301] schedule+0x4ff/0xce5
Nov 30 19:14:57 brouette kernel:  [sys_sched_yield+93/124] sys_sched_yield+0x5d/0x7c
Nov 30 19:14:57 brouette kernel:  [do_notify_resume+40/58] do_notify_resume+0x28/0x3a
Nov 30 19:14:57 brouette kernel:  [work_notifysig+19/25] work_notifysig+0x13/0x19

--pWyiEgJYm5f9v55/--
