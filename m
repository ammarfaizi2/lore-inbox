Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWCDR2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWCDR2r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWCDR2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:28:47 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:28588 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932236AbWCDR2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:28:46 -0500
Date: Sat, 4 Mar 2006 18:29:39 +0100
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm2
Message-ID: <20060304172939.GA3915@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060303045651.1f3b55ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc5-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 04:56:51AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/

I just got this one:

[ 1865.676000] BUG: unable to handle kernel NULL pointer dereference at virtual address 0000003c
[ 1865.676000]  printing eip:
[ 1865.676000] c01798f0
[ 1865.676000] *pde = 00000000
[ 1865.676000] Oops: 0000 [#1]
[ 1865.676000] PREEMPT 
[ 1865.676000] last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_max_freq
[ 1865.676000] Modules linked in: nfs nfsd lockd sunrpc ipt_MASQUERADE iptable_nat ip_nat xt_tcpudp xt_state ip_conntrack iptable_filter ip_tables x_tables reiser4 xfs exportfs sd_mod rtc sony_acpi tun psmouse sonypi speedstep_ich speedstep_lib freq_table evdev pcspkr cpufreq_ondemand cpufreq_powersave pcmcia usb_storage scsi_mod usbhid yenta_socket rsrc_nonstatic pcmcia_core e100 mii snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer i2c_i801 intel_agp uhci_hcd hw_random snd soundcore snd_page_alloc agpgart usbcore
[ 1865.676000] CPU:    0
[ 1865.676000] EIP:    0060:[<c01798f0>]    Not tainted VLI
[ 1865.676000] EFLAGS: 00010286   (2.6.16-rc5-mm2-1 #12) 
[ 1865.676000] EIP is at clear_inode+0x60/0xc0
[ 1865.676000] eax: 00000000   ebx: cb54e860   ecx: cb54e860   edx: 00000000
[ 1865.676000] esi: cb54e97c   edi: cb54e860   ebp: cff5ae6c   esp: cff5ae60
[ 1865.676000] ds: 007b   es: 007b   ss: 0068
[ 1865.676000] Process kswapd0 (pid: 128, threadinfo=cff5a000 task=cff57030)
[ 1865.676000] Stack: <0>cb54e860 cb54e860 cf4d3200 cff5ae88 c017a0ca cb54e860 00000002 c030851c 
[ 1865.676000]        cb54e860 cb4ee094 cff5ae9c c017902e cb54e860 c0448220 cff5a000 cff5aec0 
[ 1865.676000]        c0176ded cb54e860 cfc9d294 c04481f8 cff5a000 cb4ee094 cb4ee0a0 cff5a000 
[ 1865.676000] Call Trace:
[ 1865.676000]  <c01039a9> show_stack_log_lvl+0xc9/0x110   <c0103b8b> show_registers+0x19b/0x230
[ 1865.676000]  <c0103ebe> die+0x11e/0x270   <c0113337> do_page_fault+0x397/0x69c
[ 1865.676000]  <c0103293> error_code+0x4f/0x54   <c017a0ca> generic_drop_inode+0x14a/0x1a0
[ 1865.676000]  <c017902e> iput+0x6e/0x80   <c0176ded> dentry_iput+0x8d/0x120
[ 1865.676000]  <c01776c9> prune_dcache+0xb9/0x1b0   <c0177800> shrink_dcache_memory+0x40/0x50
[ 1865.676000]  <c0146a28> shrink_slab+0x188/0x220   <c01481aa> balance_pgdat+0x24a/0x420
[ 1865.676000]  <c014844a> kswapd+0xca/0x110   <c0101005> kernel_thread_helper+0x5/0x10
[ 1865.676000] Code: 32 c0 a8 20 74 08 0f 0b 01 01 6e 43 32 c0 8b 83 1c 01 00 00 8d b3 1c 01 00 00 a8 08 75 4d 8b 83 90 00 00 00 85 c0 74 0f 8b 40 20 <8b> 40 3c 85 c0 74 05 89 1c 24 ff d0 8b 83 f0 00 00 00 85 c0 74 
[ 1865.676000]  

I don't know how to reproduce it though...

-- 
mattia
:wq!
