Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbVKIDVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbVKIDVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 22:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbVKIDVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 22:21:05 -0500
Received: from [217.7.64.195] ([217.7.64.195]:58510 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1030399AbVKIDVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 22:21:03 -0500
From: Ernst Herzberg <earny@net4u.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [stable] Re: Linux 2.6.14.1
Date: Wed, 9 Nov 2005 04:20:58 +0100
User-Agent: KMail/1.8.1
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org
References: <20051109010729.GA22439@kroah.com> <200511090323.00448.earny@net4u.de> <20051109024023.GC23537@kroah.com>
In-Reply-To: <20051109024023.GC23537@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511090420.58663.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 November 2005 03:40, Greg KH wrote:
[...]
> Sorry about that, that line was cut and pasted from an older email
> message and I forgot to update it.  The Changelog on kernel.org shows
> that the two entries are correct.

No prob, thx.

I want only be shure. I had one Oops on an older Kernel, 2.6.11, uptime 153 Days.

Oops:

Nov  4 02:51:13 moci kernel BUG at include/linux/dcache.h:293!
Nov  4 02:51:13 moci invalid operand: 0000 [#1]
Nov  4 02:51:13 moci PREEMPT SMP
Nov  4 02:51:13 moci Modules linked in: w83627hf eeprom i2c_isa i2c_i801 i2c_dev nfsd exportfs lockd sunrpc snd_pcm_oss snd_mixer_oss ipt_MARK ipt_MASQUERA
DE iptable_mangle iptable_nat ip_conntrack iptable_filter ip_tables ebt_log ebt_ip ebtable_filter ebtables i2c_sensor ohci_hcd ohci1394 ieee1394 snd_intel8
x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd auerswald usblp uhci_hcd usbcore
Nov  4 02:51:13 moci CPU:    1
Nov  4 02:51:13 moci EIP:    0060:[<c0185b19>]    Tainted: G   M  VLI
Nov  4 02:51:13 moci EFLAGS: 00010246   (2.6.11)
Nov  4 02:51:13 moci EIP is at sysfs_remove_dir+0xe9/0x100
Nov  4 02:51:13 moci eax: 00000000   ebx: f4f71e20   ecx: c0262220   edx: f4f71e20
Nov  4 02:51:13 moci esi: f6778240   edi: dc089e60   ebp: f6778240   esp: cab14ecc
Nov  4 02:51:13 moci ds: 007b   es: 007b   ss: 0068
Nov  4 02:51:13 moci Process brctl (pid: 29551, threadinfo=cab14000 task=eb561a80)
Nov  4 02:51:13 moci Stack: f60dd3b0 f4f71e20 f6778240 00000006 f6778240 c01dfc94 f4f71d80 c0354f41
Nov  4 02:51:13 moci c9ed9800 f4f71d80 c0355e8b c042a860 c9ed9800 00000006 f6202e20 c01263c8
Nov  4 02:51:13 moci c9ed9800 c9ed9800 d55dc828 c02f94c6 00000202 c02f33bb c9ed9a64 c9e14180
Nov  4 02:51:13 moci Call Trace:
Nov  4 02:51:13 moci [<c01dfc94>] kobject_del+0x14/0x20
Nov  4 02:51:13 moci [<c0354f41>] br_del_if+0x31/0x51
Nov  4 02:51:13 moci [<c0355e8b>] br_device_event+0xcb/0xf0
Nov  4 02:51:13 moci [<c01263c8>] notifier_call_chain+0x18/0x40
Nov  4 02:51:13 moci [<c02f94c6>] unregister_netdevice+0x136/0x250
Nov  4 02:51:13 moci [<c02f33bb>] skb_dequeue+0x4b/0x60
Nov  4 02:51:13 moci [<c02a0245>] tun_chr_close+0x75/0x80
Nov  4 02:51:13 moci [<c0153ff6>] __fput+0x106/0x120
Nov  4 02:51:13 moci [<c01527ff>] filp_close+0x4f/0x80
Nov  4 02:51:13 moci [<c011b4b1>] put_files_struct+0x61/0xb0
Nov  4 02:51:13 moci [<c011c101>] do_exit+0xd1/0x350
Nov  4 02:51:13 moci [<c01645be>] vfs_ioctl+0x5e/0x1d0
Nov  4 02:51:13 moci [<c0153fa9>] __fput+0xb9/0x120
Nov  4 02:51:13 moci [<c011c3f7>] do_group_exit+0x37/0xa0
Nov  4 02:51:13 moci [<c01026ff>] syscall_call+0x7/0xb
Nov  4 02:51:13 moci Code: 89 f2 e8 bb 84 fb ff eb 90 8b 46 14 89 04 24 8b 00 e8 6c 85 fb ff 8b 14 24 8b 42 04 e8 71 a2 05 00 8b 04 24 e8 59 85 fb ff eb d0
 <0f> 0b 25 01 4c 9b 37 c0 e9 26 ff ff ff 58 5b 5e 5f 5d c3 8d 74

Installed 2.6.14 now, running without problems.

Ok, this one was running > 150 days... only to make shure, that older Kernles
also affected. Or is this Bug different?

Thx, earny
