Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUIVKYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUIVKYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 06:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUIVKYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 06:24:13 -0400
Received: from dialpool2-222.dial.tijd.com ([62.112.11.222]:7296 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S263818AbUIVKYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 06:24:09 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.8.9-rc2] OOPS: kernel BUG at fs/xfs/support/debug.c:106!
Date: Wed, 22 Sep 2004 12:24:13 +0200
User-Agent: KMail/1.7
References: <200409221207.04200.lkml@kcore.org>
In-Reply-To: <200409221207.04200.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409221224.14047.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And this one followed after reboot, and starting everything again. System froze, but sysrq still worked.

Sep 22 12:11:20 precious kernel: Unable to handle kernel paging request at virtual address 00200204
Sep 22 12:11:20 precious kernel:  printing eip:
Sep 22 12:11:20 precious kernel: c013d8ed
Sep 22 12:11:20 precious kernel: *pde = 00000000
Sep 22 12:11:20 precious kernel: Oops: 0000 [#1]
Sep 22 12:11:20 precious kernel: PREEMPT 
Sep 22 12:11:20 precious kernel: Modules linked in: isofs sd_mod ide_cd cdrom ppp_deflate zlib_deflate zlib_inflate bsd_comp ppp_async ppp_generic slhc rfcomm l2cap bluetooth nsc_ircc irda crc_ccitt thermal fan button processor ac battery ohci1394 ieee1394 yenta_socket pcmcia_core b44 mii snd_intel8x0m 8250_pci 8250 serial_core snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ehci_hcd usbhid uhci_hcd usbcore ipt_state iptable_nat iptable_filter ip_tables nls_iso8859_1 nls_cp850 vfat fat ip_conntrack_irc ip_conntrack pcspkr psmouse sg scsi_mod cpufreq_powersave cpufreq_userspace speedstep_centrino freq_table
Sep 22 12:11:20 precious kernel: CPU:    0
Sep 22 12:11:20 precious kernel: EIP:    0060:[free_block+77/224]    Not tainted
Sep 22 12:11:20 precious kernel: EFLAGS: 00010012   (2.6.9-rc2) 
Sep 22 12:11:20 precious kernel: EIP is at free_block+0x4d/0xe0
Sep 22 12:11:20 precious kernel: eax: 00117140   ebx: 00200200   ecx: c8b8a580   edx: c1000000
Sep 22 12:11:20 precious kernel: esi: dff6f480   edi: 00000001   ebp: dff6f48c   esp: dff29edc
Sep 22 12:11:20 precious kernel: ds: 007b   es: 007b   ss: 0068
Sep 22 12:11:20 precious kernel: Process events/0 (pid: 3, threadinfo=dff28000 task=c14f1020)
Sep 22 12:11:20 precious kernel: Stack: dff6ff80 cea2e000 dff6f49c c14da010 c14da000 00000005 dff6f480 c013e0aa 
Sep 22 12:11:20 precious kernel:        dff6f480 c14da010 00000005 dff6fa9c dff6f480 dff28000 00000002 c013e172 
Sep 22 12:11:20 precious kernel:        dff6f480 c14da000 00000000 dff6fa9c dff28000 dff6f4f0 c14f1170 c0456180 
Sep 22 12:11:20 precious kernel: Call Trace:
Sep 22 12:11:20 precious kernel:  [drain_array_locked+122/192] drain_array_locked+0x7a/0xc0
Sep 22 12:11:20 precious kernel:  [cache_reap+130/464] cache_reap+0x82/0x1d0
Sep 22 12:11:20 precious kernel:  [worker_thread+473/672] worker_thread+0x1d9/0x2a0
Sep 22 12:11:20 precious kernel:  [cache_reap+0/464] cache_reap+0x0/0x1d0
Sep 22 12:11:20 precious kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Sep 22 12:11:20 precious kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Sep 22 12:11:20 precious kernel:  [worker_thread+0/672] worker_thread+0x0/0x2a0
Sep 22 12:11:20 precious kernel:  [kthread+170/176] kthread+0xaa/0xb0
Sep 22 12:11:20 precious kernel:  [kthread+0/176] kthread+0x0/0xb0
Sep 22 12:11:20 precious kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
Sep 22 12:11:20 precious kernel: Code: 89 44 24 08 8d 76 00 8d bc 27 00 00 00 00 8b 44 24 24 8b 15 b0 62 45 c0 8b 0c b8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 02 1c <8b> 53 04 8b 03 89 50 04 89 02 8b 43 0c 31 d2 c7 03 00 01 10 00 
Sep 22 12:11:20 precious kernel:  <6>note: events/0[3] exited with preempt_count 1

