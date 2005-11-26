Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932710AbVKZBYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbVKZBYL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 20:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932711AbVKZBYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 20:24:11 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:2550 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932710AbVKZBYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 20:24:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=ZYNQpNoX2bqT5rY7PGCdc/xsFODdlQYFyE7BCIZa0zS4aPWunOTLzdnHa0gahif1Qo9aAQ8XUy8+ALJHvMKOz9niZTi3ULy3wEFf2DSZb62r4Eanr6PdtTEa2FsTZWVO506g9TwTIOuqz42sHTSS59B1vxgz0zbMPQc9iO8CFF4=
Message-ID: <00e101c5f228$1249d790$0301010a@home321>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel bug
Date: Fri, 25 Nov 2005 23:23:51 -0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
From: Vympel <vympel.br@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I receive this error and must reboot my server,

Nov 23 15:35:09 mail kernel: ------------[ cut here ]------------

Nov 23 15:35:09 mail kernel: kernel BUG at mm/rmap.c:487!

Nov 23 15:35:09 mail kernel: invalid operand: 0000 [#1]

Nov 23 15:35:09 mail kernel: Modules linked in: snd_cmipci gameport 
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss 
snd_mixer_oss snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep 
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore loop ipt_MASQUERADE 
iptable_nat ip_nat ipt_state ip_conntrack nfnetlink iptable_filter ip_tables 
dm_mod hw_random i2c_i801 i2c_core fealnx ne2k_pci 8390 8139too mii floppy 
ext3 jbd aic7xxx scsi_transport_spi sd_mod scsi_mod

Nov 23 15:35:09 mail kernel: CPU: 0

Nov 23 15:35:09 mail kernel: EIP: 0060:[<c014f97b>] Not tainted VLI

Nov 23 15:35:09 mail kernel: EFLAGS: 00010286 (2.6.14-1.1637_FC4)

Nov 23 15:35:09 mail kernel: EIP is at page_remove_rmap+0x37/0x41

Nov 23 15:35:09 mail kernel: eax: ffffffff ebx: c60e11b0 ecx: 04ff1025 edx: 
c109fe20

Nov 23 15:35:09 mail kernel: esi: c109fe20 edi: 0806c000 ebp: c03f7a7c esp: 
cc480de8

Nov 23 15:35:09 mail kernel: ds: 007b es: 007b ss: 0068

Nov 23 15:35:09 mail kernel: Process pipe (pid: 18858, threadinfo=cc480000 
task=c956c030)

Nov 23 15:35:09 mail kernel: Stack: c0149137 00000000 0807a000 c03f7a7c 
c9ac0080 0807a000 0807a000 08079fff

Nov 23 15:35:09 mail kernel: c01492ca 0807a000 00000000 c03f7a7c 00033000 
0807a000 c5c5e17c 0807a000

Nov 23 15:35:09 mail kernel: c0149401 0807a000 00000000 cc480000 c9194ba0 
cc480e78 002dc000 00000000



After some minutes server crash again with following error:



Nov 23 16:33:20 mail kernel: Backtrace:

Nov 23 16:33:20 mail kernel: [<c013f38d>] bad_page+0x8c/0xc3

Nov 23 16:33:20 mail kernel: [<c013fbf7>] free_hot_cold_page+0x47/0xca

Nov 23 16:33:20 mail kernel: [<c01403a5>] __pagevec_free+0x1f/0x2e

Nov 23 16:33:20 mail kernel: [<c0145123>] __pagevec_release_nonlru+0x29/0x8a

Nov 23 16:33:20 mail kernel: [<c01460fd>] shrink_list+0x207/0x47b

Nov 23 16:33:20 mail kernel: [<c014651e>] shrink_cache+0xe7/0x29a

Nov 23 16:33:20 mail kernel: [<c0146b41>] shrink_zone+0x88/0xd6

Nov 23 16:33:20 mail kernel: [<c0146f95>] balance_pgdat+0x20d/0x3e7

Nov 23 16:33:20 mail kernel: [<c014723a>] kswapd+0xcb/0x109

Nov 23 16:33:20 mail kernel: [<c012db56>] autoremove_wake_function+0x0/0x37

Nov 23 16:33:20 mail kernel: [<c014716f>] kswapd+0x0/0x109

Nov 23 16:33:20 mail kernel: [<c0101301>] kernel_thread_helper+0x5/0xb

Nov 23 16:33:20 mail kernel: Trying to fix it up, but a reboot is needed



Best Regards

