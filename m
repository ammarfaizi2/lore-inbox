Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWHFNd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWHFNd4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 09:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWHFNd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 09:33:56 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:44972 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750715AbWHFNdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 09:33:55 -0400
Date: Sun, 6 Aug 2006 15:33:06 +0200
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2
Message-ID: <20060806133306.GB4009@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc1-mm2-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 03:08:09AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/

there's something more, I had a load of the following while playing with
UML, full dmesg and config are
http://oioio.altervista.org/linux/config-2.6.18-rc3-mm2-1
http://oioio.altervista.org/linux/dmesg-2.6.18-rc3-mm2-1

[  781.988000] ------------[ cut here ]------------
[  781.988000] kernel BUG at mm/vmscan.c:383!
[  781.988000] invalid opcode: 0000 [#1]
[  781.988000] 4K_STACKS PREEMPT 
[  781.988000] last sysfs file: /devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice_load
[  781.988000] Modules linked in: ipv6 nfsd exportfs lockd sunrpc ipt_MASQUERADE iptable_nat ip_nat xt_tcpudp xt_state ip_conntrack iptable_filter ip_tables x_tables jfs aes dm_crypt dm_mod rtc sony_acpi tun psmouse sonypi speedstep_ich speedstep_lib freq_table cpufreq_conservative cpufreq_ondemand cpufreq_powersave sd_mod usb_storage scsi_mod usbhid pcmcia snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer intel_agp agpgart i2c_i801 uhci_hcd usbcore evdev e100 mii yenta_socket rsrc_nonstatic pcmcia_core snd soundcore snd_page_alloc pcspkr
[  781.988000] CPU:    0
[  781.988000] EIP:    0060:[<c014c4d8>]    Not tainted VLI
[  781.988000] EFLAGS: 00210203   (2.6.18-rc3-mm2-1 #1) 
[  781.988000] EIP is at remove_mapping+0xe8/0x120
[  781.988000] eax: c0374120   ebx: c11e2a80   ecx: c0374120   edx: 000000d0
[  781.988000] esi: c0374120   edi: cfea0f78   ebp: cfea0e04   esp: cfea0df8
[  781.988000] ds: 007b   es: 007b   ss: 0068
[  781.988000] Process kswapd0 (pid: 134, ti=cfea0000 task=cfe9e030 task.ti=cfea0000)
[  781.988000] Stack: c11e2a80 c11e2a80 c0374120 cfea0f14 c014cbab c0374120 c11e2a80 cfea0f78 
[  781.988000]        c0373d60 c0373e2c 00000020 00000020 00000000 00000020 00000000 00000000 
[  781.988000]        c0374120 00000001 00000000 c101a860 c0373c20 00000000 00000001 c0463168 
[  781.988000] Call Trace:
[  781.988000]  [<c014cbab>] shrink_inactive_list+0x69b/0x920
[  781.988000]  [<c014cec2>] shrink_zone+0x92/0xe0
[  781.988000]  [<c014d1f1>] kswapd+0x2e1/0x430
[  781.988000]  [<c012ee26>] kthread+0xe6/0xf0
[  781.988000]  [<c0101005>] kernel_thread_helper+0x5/0x10
[  781.988000] DWARF2 unwinder stuck at kernel_thread_helper+0x5/0x10
[  781.988000] Leftover inexact backtrace:
[  781.988000]  [<c0103a06>] show_stack_log_lvl+0xb6/0x100
[  781.988000]  [<c0103c2f>] show_registers+0x1df/0x290
[  781.988000]  [<c01041aa>] die+0x13a/0x310
[  781.988000]  [<c01047dd>] do_trap+0x9d/0x100
[  781.988000]  [<c0104c41>] do_invalid_op+0xa1/0xb0
[  781.988000]  [<c031a4a9>] error_code+0x39/0x40
[  781.988000]  [<c014cbab>] shrink_inactive_list+0x69b/0x920
[  781.988000]  [<c014cec2>] shrink_zone+0x92/0xe0
[  781.988000]  [<c014d1f1>] kswapd+0x2e1/0x430
[  781.988000]  [<c012ee26>] kthread+0xe6/0xf0
[  781.988000]  [<c0101005>] kernel_thread_helper+0x5/0x10
[  781.988000] Code: 89 e0 25 00 f0 ff ff ff 48 14 8b 40 08 31 d2 a8 08 74 bc e8 6b be 1c 00 31 d2 eb b3 8d b4 26 00 00 00 00 8b 53 0c e9 51 ff ff ff <0f> 0b 7f 01 4e 66 33 c0 e9 2c ff ff ff 0f 0b 7e 01 4e 66 33 c0 
[  781.988000] EIP: [<c014c4d8>] remove_mapping+0xe8/0x120 SS:ESP 0068:cfea0df8
[  781.988000]  <0>------------[ cut here ]------------
[  782.292000] kernel BUG at mm/vmscan.c:383!
...
[  782.292000]  <0>------------[ cut here ]------------
[  782.564000] kernel BUG at mm/vmscan.c:383!
...
[  809.588000] ------------[ cut here ]------------
[  809.588000] kernel BUG at mm/vmscan.c:383!
...
[  809.588000]  <0>------------[ cut here ]------------
[  811.748000] kernel BUG at mm/vmscan.c:383!
...
[  811.748000]  <0>------------[ cut here ]------------
[  814.128000] kernel BUG at mm/vmscan.c:383!
...
[  814.128000]  <0>------------[ cut here ]------------
[  815.272000] kernel BUG at mm/vmscan.c:383!
...
[  815.272000]  <0>------------[ cut here ]------------
[  816.116000] kernel BUG at mm/vmscan.c:383!
...
[  816.856000]  <0>------------[ cut here ]------------
[  817.120000] kernel BUG at mm/vmscan.c:383!

-- 
mattia
:wq!
