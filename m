Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWG1R6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWG1R6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWG1R6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:58:31 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:48143 "EHLO
	smtp-vbr12.xs4all.nl") by vger.kernel.org with ESMTP
	id S1030248AbWG1R6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:58:30 -0400
Message-ID: <44CA5043.2090603@xs4all.nl>
Date: Fri, 28 Jul 2006 19:58:27 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: another Oops / BUG? (2.6.17.7 on VIA Epia CL6000)
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Below is another oops/bug, similar to the one I posted on 2nd of july.
I noticed that after such a crash named does not work anymore and
requires killing and restarting.
Also upsd loses sync with the ups and gives repeated messages of
stale/lost communication and established communcation; ntpd appears to
be fine.
This does not appear to be a hardware problem, yet.

What can I do to find the cause?

Udo


PS: the 'code' below appears to be text?

Jul 28 18:21:53 epia kernel: BUG: unable to handle kernel NULL pointer
dereference at virtual address 00000001
Jul 28 18:21:53 epia kernel:  printing eip:
Jul 28 18:21:53 epia kernel: d4493187
Jul 28 18:21:53 epia kernel: *pde = 00000000
Jul 28 18:21:53 epia kernel: Oops: 0002 [#1]
Jul 28 18:21:53 epia kernel: PREEMPT
Jul 28 18:21:53 epia kernel: Modules linked in: nls_utf8 cifs sch_tbf
xt_string xt_MARK xt_length xt_tcpmss xt_mac xt_mark vt1211 hwmon_vid
i2c_isa ipv6 ipt_ttl ipt_owner ip_nat_irc ip_conntrack_irc ipt_REDIRECT
ipt_tos ip_nat_ftp ip_conntrack_ftp ip_nat_h323 ip_conntrack_h323
ipt_MASQUERADE ipt_LOG ipt_TCPMSS ipt_REJECT xt_limit xt_state
ipt_TARPIT iptable_filter ipt_TOS iptable_mangle xt_NOTRACK iptable_raw
binfmt_misc lp parport_pc parport nvram uhci_hcd ehci_hcd snd_via82xx
snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event
snd_seq i2c_viapro snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd
Jul 28 18:21:53 epia kernel: CPU:    0
Jul 28 18:21:53 epia kernel: EIP:    0060:[pg0+336277895/1069671424]
Not tainted VLI
Jul 28 18:21:53 epia kernel: EIP:    0060:[<d4493187>]    Not tainted VLI
Jul 28 18:21:53 epia kernel: EFLAGS: 00010296   (2.6.17.7 #10)
Jul 28 18:21:53 epia kernel: EIP is at 0xd4493187
Jul 28 18:21:53 epia kernel: eax: 00000000   ebx: d8a1c98e   ecx:
0000000d   edx: 00000001
Jul 28 18:21:54 epia kernel: esi: 90bc761d   edi: 9399b2de   ebp:
988609ef   esp: dd5d9f3c
Jul 28 18:21:54 epia kernel: ds: 007b   es: 007b   ss: 0068
Jul 28 18:21:54 epia kernel: Process named (pid: 1527,
threadinfo=dd5d8000 task=ddf76570)
Jul 28 18:21:54 epia kernel: Stack: d73bf8d9 4e787504 79edcaa3 c224bcd4
6a7c5ea3 4801b982 5190fb40 f4c92e68
Jul 28 18:21:54 epia kernel:        944f1481 275bf6c5 41798705 568d0cda
5464e03a 9ae863a2 849e9c0c d9a1c922
Jul 28 18:21:54 epia kernel:        f72eb186 04e9718b 44e559db bebe0c4a
36435890 0ac33ab2 2bab9517 d6bcdf63
Jul 28 18:21:54 epia kernel: Call Trace:
Jul 28 18:21:54 epia kernel: Code: 20 70 6f 72 74 20 35 38 31 31 33 20
73 73 68 32 0a 4a 75 6c 20 32 33 20 31 36 3a 35 35 3a 31 31 20 65 70 69
61 20 73 73 68 64 5b <31> 32 36 39 32 5d 3a 20 46 61 69 6c 65 64 20 70
61 73 73 77 6f
Jul 28 18:21:54 epia kernel: EIP: [pg0+336277895/1069671424] 0xd4493187
SS:ESP 0068:dd5d9f3c
Jul 28 18:21:54 epia kernel: EIP: [<d4493187>] 0xd4493187 SS:ESP
0068:dd5d9f3c
