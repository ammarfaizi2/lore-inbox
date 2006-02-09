Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbWBIJAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbWBIJAQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWBIJAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:00:15 -0500
Received: from mail.gmx.de ([213.165.64.21]:42467 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965223AbWBIJAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:00:14 -0500
X-Authenticated: #14349625
Subject: Re: [k2.6.16-rc1-mm5] kernel BUG at include/linux/mm.h:302!
From: MIke Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060209004609.2120928a.akpm@osdl.org>
References: <1139473463.8028.13.camel@homer>
	 <20060209004609.2120928a.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 10:05:04 +0100
Message-Id: <1139475904.8418.10.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 00:46 -0800, Andrew Morton wrote:
> MIke Galbraith <efault@gmx.de> wrote:
> >
> >
> >  kernel BUG at include/linux/mm.h:302!
> >  invalid opcode: 0000 [#1]
> >  PREEMPT SMP 
> >  last sysfs file: /devices/pci0000:00/0000:00:1e.0/0000:02:09.0/subsystem_device
> >  Modules linked in: xt_pkttype ipt_LOG xt_limit snd_pcm_oss snd_mixer_oss button battery snd_seq snd_seq_device ac edd ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack ip_tables ip6table_filter ip6_tables x_tables tda9887 at76c651 prism54 saa7134 ohci1394 ieee1394 bt878 ir_kbd_i2c snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc i2c_i801 tuner bttv video_buf firmware_class btcx_risc ir_common tveeprom nls_iso8859_1 nls_cp437 nls_utf8 sd_mod fan thermal processor
> >  CPU:    0
> >  EIP:    0060:[<c01461cb>]    Not tainted VLI
> >  EFLAGS: 00210246   (2.6.16-rc1-mm5 #1) 
> >  EIP is at release_pages+0x165/0x196
> >  eax: 00000000   ebx: c16f3220   ecx: 00000000   edx: 00000008
> >  esi: c18077d0   edi: c18077b4   ebp: 00000000   esp: f6644e74
> >  ds: 007b   es: 007b   ss: 0068
> >  Process knotify (pid: 7482, threadinfo=f6644000 task=f658b030)
> >  Stack: <0>00000008 00000008 00000001 00000000 00000000 c161e920 c161e940 c161e960 
> >         c161e980 c161e9a0 c057f600 f6644edc 00000001 00000002 f6644ed4 c01446de 
> >         c161e9a0 c18077d0 00000008 c16f32e0 c18077d0 00000008 00000008 c01521b5 
> >  Call Trace:
> >   <c01446de> __pagevec_free+0x1f/0x2e   <c01521b5> free_pages_and_swap_cache+0x74/0xb6
> >   <c014afd4> unmap_vmas+0x5da/0x642   <c014de7d> unmap_region+0xa7/0x131
> >   <c014e5cd> do_munmap+0x139/0x1cc   <c014e6a0> sys_munmap+0x40/0x59
> 
> Doesn't happen here (but it never does).
> 
> Is it always knotify, always dying in the same manner?
> 

Yes, tentatively.  I haven't rebooted many times, but every time I have,
It's been knotify.

	-Mike

