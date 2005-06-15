Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVFOK0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVFOK0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 06:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVFOK0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 06:26:48 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:55182 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261378AbVFOK0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 06:26:45 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: eidtmann@informatik.uni-bremen.de, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: lock
Date: Wed, 15 Jun 2005 13:26:09 +0300
User-Agent: KMail/1.5.4
References: <1118827835.5992.5.camel@lunar.localdomain>
In-Reply-To: <1118827835.5992.5.camel@lunar.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506151326.09276.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 June 2005 12:30, Jan wrote:

[snip]

> Jun 15 04:50:01 lunar kernel: ------------[ cut here ]------------
> Jun 15 04:50:01 lunar kernel: kernel BUG at mm/vmscan.c:563!
> Jun 15 04:50:01 lunar kernel: invalid operand: 0000 [#1]
> Jun 15 04:50:01 lunar kernel: PREEMPT SMP
> Jun 15 04:50:01 lunar kernel: Modules linked in: fglrx eepro100
                                                   ^^^^^
> emu10k1_gp gameport 3c59x intel_mch_agp agpgart snd_emu10k1 snd_rawmidi
> snd_ac97_codec snd_util_mem snd_hwdep

> Jun 15 04:50:01 lunar kernel: CPU:    0
> Jun 15 04:50:01 lunar kernel: EIP:    0060:[<c01432f0>]    Tainted: P
                                                             ^^^^^^^^
> VLI
> Jun 15 04:50:01 lunar kernel: EFLAGS: 00010046   (2.6.11.11)
> Jun 15 04:50:01 lunar kernel: EIP is at shrink_cache+0xb0/0x350
> Jun 15 04:50:01 lunar kernel: eax: 00000000   ebx: c04cbd00   ecx:
> c1711018   edx: c1711018
> Jun 15 04:50:01 lunar kernel: esi: 00000020   edi: c04cbf90   ebp:
> c1bfbeb4   esp: c1bfbe98
> Jun 15 04:50:01 lunar kernel: ds: 007b   es: 007b   ss: 0068
> Jun 15 04:50:01 lunar kernel: Process kswapd0 (pid: 209,
> threadinfo=c1bfa000 task=c1bb8a80)
> Jun 15 04:50:01 lunar kernel: Stack: c0114702 f7c30a80 c1bfbecc c1bfa000
> 0000001f c04cbf80 00000020 c1711038
> Jun 15 04:50:01 lunar kernel:        c172fbb8 00000000 00000001 00000202
> 00000001 00000296 00000000 00000000
> Jun 15 04:50:01 lunar kernel:        00000000 c1bfbef0 c011474d f7c30a80
> 0000000f 00000000 c19f6b80 c0262854
> Jun 15 04:50:01 lunar kernel: Call Trace:
> Jun 15 04:50:01 lunar kernel:  [<c0114702>] try_to_wake_up+0x262/0x290
> Jun 15 04:50:01 lunar kernel:  [<c011474d>] wake_up_process+0x1d/0x30
> Jun 15 04:50:01 lunar kernel:  [<c0262854>] pagebuf_daemon_wakeup
> +0x14/0x20
> Jun 15 04:50:01 lunar kernel:  [<c0142b08>] shrink_slab+0x88/0x190
> Jun 15 04:50:01 lunar kernel:  [<c0143b4a>] shrink_zone+0xba/0xf0
> Jun 15 04:50:01 lunar kernel:  [<c0144058>] balance_pgdat+0x2b8/0x3b0
> Jun 15 04:50:01 lunar kernel:  [<c014423d>] kswapd+0xed/0x110
> Jun 15 04:50:01 lunar kernel:  [<c012f8c0>] autoremove_wake_function
> +0x0/0x60
> Jun 15 04:50:01 lunar kernel:  [<c0102782>] ret_from_fork+0x6/0x14
> Jun 15 04:50:01 lunar kernel:  [<c012f8c0>] autoremove_wake_function
> +0x0/0x60
> Jun 15 04:50:01 lunar kernel:  [<c0144150>] kswapd+0x0/0x110
> Jun 15 04:50:01 lunar kernel:  [<c01009f5>] kernel_thread_helper
> +0x5/0x10
> Jun 15 04:50:01 lunar kernel: Code: 00 00 89 f6 8d bc 27 00 00 00 00 8b
> 8b 94 02 00 00 8b 41 04 39 f8 74 07 83 e8 18 8d 74 26 00 f0 0f ba 71 e8
> 05 19 c0 85 c0 75 08 <0f> 0b 33 02 33 fa 46 c0 8b 51 04 8b 01 89 50 04
> 89 02 c7 41 04
> Jun 15 04:50:01 lunar kernel:  <6>note: kswapd0[209] exited with
> preempt_count 1

http://www.catb.org/~esr/faqs/smart-questions.html
--
vda

