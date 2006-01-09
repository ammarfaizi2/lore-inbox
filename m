Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWAIR3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWAIR3H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWAIR3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:29:06 -0500
Received: from kenga.kmv.ru ([217.13.212.5]:46566 "EHLO kenga.kmv.ru")
	by vger.kernel.org with ESMTP id S1030207AbWAIR3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:29:04 -0500
Date: Mon, 9 Jan 2006 20:28:35 +0300
From: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, akpm@osdl.org,
       adilger@clusterfs.com, ext3-users@redhat.com
Subject: Re: 2.6.15-rc6 OOPS
Message-ID: <20060109172835.GB2724@kmv.ru>
References: <20051224200336.GF12561@kmv.ru> <20060102160939.GG17398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102160939.GG17398@stusta.de>
User-Agent: Mutt/1.5.9i
X-Data-Status: msg.XXYHtLWU:26498@kenga.kmv.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian Bunk!
 On Mon, Jan 02, 2006 at 05:09:39PM +0100, Adrian Bunk wrote next:

> On Sat, Dec 24, 2005 at 11:03:36PM +0300, Andrey J. Melnikoff (TEMHOTA) wrote:
> 
> > Please, CC me, i'm not subscribed.
> > 
> > Kernel 2.6.15-rc6 OOPS:
> > 
> > kernel: general protection fault: 0000 [#1]
> > kernel: SMP
> > kernel: Modules linked in: ipt_REDIRECT ipt_LOG ipt_TOS ipt_TCPMSS ipt_tos
> > ip_nat_ftp ipt_tcpmss iptable_nat ip_nat iptable_mangle iptable_filter
> > ipt_multiport ipt_mac ipt_state ipt_limit ipt_conntrack ip_conntrack_ftp 
> > ip_conntrack ip_tables af_packet ipv6 pcspkr floppy i2c_piix4 i2c_core 
> > ohci_hcd usbcore aic7xxx scsi_transport_spi psmouse ide_disk ide_cd 
> > cdrom genrtc
> > kernel: CPU:    0
> > kernel: EIP:    0060:[<c019d70f>]    Not tainted VLI
> > kernel: EFLAGS: 00010286   (2.6.15-rc6)
> > kernel: EIP is at ext3_find_entry+0x18f/0x3e0
> > kernel: eax: ffffffff   ebx: 00010001   ecx: 00000002   edx: 00000000
> > kernel: esi: 00000000   edi: ffffffff   ebp: 00000000   esp: f71b9d60
> > kernel: ds: 007b   es: 007b   ss: 0068
> > kernel: Process smbd (pid: 2999, threadinfo=f71b8000 task=f7aee530)
> > kernel: Stack: 00000000 f71b9db8 00000000 00000027 000005b4 ffffffff f71a62e8 00000000
> > kernel:        f71b9ea8 00001000 f71a636c 00000001 00000001 00010001 00000001 00000000
> > kernel:        00000000 00000000 f7caf400 f71b9df0 f71503d4 ffffffff 00000000 f7159c68
> > kernel: Call Trace:
> > kernel:  [<c025eb29>] memcpy_toiovec+0x29/0x50
> > kernel:  [<c019dbda>] ext3_lookup+0x3a/0xc0
> > kernel:  [<c0167c8e>] real_lookup+0xae/0xd0
> > kernel:  [<c0167f35>] do_lookup+0x85/0x90
> > kernel:  [<c016872f>] __link_path_walk+0x7ef/0xdd0
> > kernel:  [<c0168d5e>] link_path_walk+0x4e/0xd0
> > kernel:  [<c016907f>] path_lookup+0x9f/0x170
> > kernel:  [<c01693cf>] __user_walk+0x2f/0x60
> > kernel:  [<c0163b5d>] vfs_stat+0x1d/0x60
> > kernel:  [<c01641df>] sys_stat64+0xf/0x30
> > kernel:  [<c0121271>] sys_gettimeofday+0x21/0x60
> > kernel:  [<c0102e59>] syscall_call+0x7/0xb
> > kernel: Code: 07 7e 88 89 f6 8d bc 27 00 00 00 00 8b 5c 24 34 8b 44 9c 5c 43 89
> > 5c 24 34 85 c0 89 44 24 14 89 44 24 54 0f 84 b7 00 00 00 89 c7 <8b> 00 a8 04 75
> > 07 8b 47 0c 85 c0 75 11 8b 44 24 14 e8 fb e1 fb
> 
> 
> is this Oops in any way reproducible?
No. We replease server and this kernel work on new hardware. I think this is
memory/hardware/overheat problem.
 
> If yes, does it occur in earlier kernels like 2.6.14.x?

Sorry for noise and long delay.

-- 
 Best regards, TEMHOTA-RIPN aka MJA13-RIPE
 System Administrator. mailto:temnota@kmv.ru

