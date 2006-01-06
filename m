Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWAFCfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWAFCfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWAFCfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:35:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50056 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932603AbWAFCfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:35:10 -0500
Date: Thu, 5 Jan 2006 21:34:57 -0500
From: Dave Jones <davej@redhat.com>
To: Benoit Boissinot <bboissin@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm1
Message-ID: <20060106023457.GA32105@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Benoit Boissinot <bboissin@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060105062249.4bc94697.akpm@osdl.org> <20060105173203.GA18970@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105173203.GA18970@ens-lyon.fr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 06:32:03PM +0100, Benoit Boissinot wrote:

 > in my logs and a oops but X still started:
 > 
 > [   48.080000] [drm] Initialized drm 1.0.1 20051102
 > [   48.120000] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
 > [   48.120000] [drm] Initialized radeon 1.21.0 20051229 on minor 0
 > [   48.124000] mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x2000000
 > [   48.124000] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
 > [   48.124000] Unable to handle kernel NULL pointer dereference at virtual address 00000010
 > [   48.124000]  printing eip:
 > [   48.124000] c02628e4
 > [   48.124000] *pde = 1f3de067
 > [   48.124000] *pte = 00000000
 > [   48.124000] Oops: 0000 [#1]
 > [   48.124000] last sysfs file: /devices/pci0000:00/0000:00:1e.0/0000:02:03.0/rf_kill
 > [   48.124000] Modules linked in: radeon drm ipt_multiport ipt_state ipt_limit ipt_REJECT iptable_filter iptable_nat ip_nat ip_tables ip_conntrack_irc ip_conntrack_ftp ip_conntrack nfnetlink snd_seq snd_seq_device snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc speedstep_centrino cpufreq_stats freq_table cpufreq_conservative cpufreq_ondemand cpufreq_performance cpufreq_powersave fan button thermal processor battery ac uhci_hcd ehci_hcd usbcore tg3 ipw2200 ieee80211 ieee80211_crypt psmouse ide_cd cdrom
 > [   48.124000] CPU:    0
 > [   48.124000] EIP:    0060:[<c02628e4>]    Not tainted VLI
 > [   48.124000] EFLAGS: 00013202   (2.6.15-mm1-casaverde) 
 > [   48.124000] EIP is at agp_collect_device_status+0x14/0xd0

My fault. Drop the agpgart-git patch from Andrews broken-out/ dir. ( patch -R)

		Dave

