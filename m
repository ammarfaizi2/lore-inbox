Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWGBLPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWGBLPm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 07:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWGBLPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 07:15:42 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:17167 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP id S932484AbWGBLPm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 07:15:42 -0400
Message-ID: <44A7AADB.8040106@xs4all.nl>
Date: Sun, 02 Jul 2006 13:15:39 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Folkert van Heusden <folkert@vanheusden.com>
Subject: Oops / BUG? (2.6.17.2 on VIA Epia CL6000)
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On my otherwise stable Via EPIA CL6000 I experienced an OOPS.
Hardware should be OK. I was unable to reproduce the event, so far.
In what part of the kernel did things go wrong?
What can I do to help fix the bug? (if it is indeed a bug)

Kind regards,
Udo

Jul  2 07:11:23 epia kernel: BUG: unable to handle kernel paging request
at virtual address 52786fdd
Jul  2 07:11:23 epia kernel:  printing eip:
Jul  2 07:11:23 epia kernel: 52786fdd
Jul  2 07:11:23 epia kernel: *pde = 00000000
Jul  2 07:11:23 epia kernel: Oops: 0000 [#1]
Jul  2 07:11:23 epia kernel: PREEMPT
Jul  2 07:11:23 epia kernel: Modules linked in: eeprom sch_tbf xt_string
xt_MARK xt_length xt_tcpmss xt_mac xt_mark vt1211 hwmon_vid i2c_isa
ipt_ttl ipt_owner ip_nat_irc ip_conntrack_irc ipt_REDIRECT ipt_tos
ip_nat_ftp ip_conntrack_ftp ip_nat_h323 ip_conntrack_h323 ipt_MASQUERADE
ipt_LOG ipt_TCPMSS ipt_REJECT xt_limit xt_state ipt_TARPIT
iptable_filter ipt_TOS iptable_mangle xt_NOTRACK iptable_raw binfmt_misc
lp parport_pc parport nvram ehci_hcd uhci_hcd snd_via82xx snd_ac97_codec
snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc
snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_viapro
Jul  2 07:11:23 epia kernel: CPU:    0
Jul  2 07:11:23 epia kernel: EIP:
0060:[phys_startup_32+1382576093/-1073741824]    Not tainted VLI
Jul  2 07:11:23 epia kernel: EIP:    0060:[<52786fdd>]    Not tainted VLI
Jul  2 07:11:23 epia kernel: EFLAGS: 00010296   (2.6.17.2 #3)
Jul  2 07:11:23 epia kernel: EIP is at 0x52786fdd
Jul  2 07:11:23 epia kernel: eax: 00000000   ebx: 11d3b28e   ecx:
0000000d   edx: 00000001
Jul  2 07:11:23 epia kernel: esi: 5d21e8b6   edi: 9faa859e   ebp:
ca33023d   esp: dd071f38
Jul  2 07:11:23 epia kernel: ds: 007b   es: 007b   ss: 0068
Jul  2 07:11:23 epia kernel: Process named (pid: 1431,
threadinfo=dd070000 task=ddf61a90)
Jul  2 07:11:23 epia kernel: Stack: 2dad9f88 1b77f396 5f57be35 0e045382
fb72cd9d 9ca3ed70 29739bee 90ca7336
Jul  2 07:11:23 epia kernel:        cdb39230 d727e3ff b41a68a9 d1962a09
b9b3a8a9 1109a681 a447b354 fb7969e6
Jul  2 07:11:23 epia kernel:        73a0d873 06446b61 1be5d2eb 16872e4f
c887aede 1fcb7034 7902b644 ac07b40b
Jul  2 07:11:23 epia kernel: Call Trace:
Jul  2 07:11:30 epia kernel: Code:  Bad EIP value.
Jul  2 07:11:30 epia kernel: EIP:
[phys_startup_32+1382576093/-1073741824] 0x52786fdd SS:ESP 0068:dd071f38
Jul  2 07:11:30 epia kernel: EIP: [<52786fdd>] 0x52786fdd SS:ESP
0068:dd071f38


