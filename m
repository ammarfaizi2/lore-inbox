Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUBQQz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266332AbUBQQzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:55:38 -0500
Received: from lpbproductions.com ([68.98.208.147]:50060 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S266326AbUBQQx0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:53:26 -0500
From: "Matt H." <lkml@lpbproductions.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2 Kernel Badness with 1.0-5336 NVIDIA driver
Date: Tue, 17 Feb 2004 09:56:24 -0700
User-Agent: KMail/1.5.94
References: <200402170808.21530.aleontar@ucsd.edu>
In-Reply-To: <200402170808.21530.aleontar@ucsd.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Message-Id: <200402170956.24207.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More then likely this is Nvidia's fault. You'll have to take it up with them 
and not the ppl here at the lkml.


Matt H.

On Tuesday 17 February 2004 9:08 am, Athanasios Leontaris wrote:
> Hi to all,
>
> Pls cc me as I am not subscribing.
> I know that the kernel is tainted so pls don't flame ;)
> The kernel is 2.6.2 from www.kernel.org and I use AGPGART for AGP (_not_
> NvAGP). Fast Writes and SBA are enabled. FC1 is the distro. The mobo is
> Abit KG7 and the video card an FX5600.
>
> X stopped responding out of the blue, at a KDE 3.2 desktop, and it could
> not be killed either. The following messages were uncovered in
> my /var/log/messages:
>
> Feb 17 07:35:15 thunderbird kernel: Badness in pci_find_subsys at
> drivers/pci/search.c:167
> Feb 17 07:35:15 thunderbird kernel: Call Trace:
> Feb 17 07:35:15 thunderbird kernel:  [<c01ec168>] pci_find_subsys+0xe8/0xf0
> Feb 17 07:35:15 thunderbird kernel:  [<c01ec19f>] pci_find_device+0x2f/0x40
> Feb 17 07:35:15 thunderbird kernel:  [<c01ebfa8>] pci_find_slot+0x28/0x50
> Feb 17 07:35:15 thunderbird kernel:  [<e0e1222a>]
>  os_pci_init_handle+0x39/0x68 [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0ca685f>] _nv001243rm+0x1f/0x24
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0ded115>] _nv000816rm+0x2f5/0x384
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0d5592c>] _nv003801rm+0xd8/0x100
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0decc4f>] _nv000809rm+0x2f/0x34
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0d84b48>] _nv003606rm+0xe4/0x114
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0d846b8>] _nv003564rm+0x688/0x908
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0cbf267>] _nv004046rm+0x3a3/0x3b0
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0dc0b03>] _nv001476rm+0x1d3/0x45c
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0ca939a>] _nv000896rm+0x4a/0x64
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0caabb4>] rm_isr_bh+0xc/0x10
> [nvidia] Feb 17 07:35:15 thunderbird kernel:  [<e0e0fab1>]
> nv_kern_isr_bh+0xf/0x13 [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<c01208b6>] tasklet_action+0x46/0x70
> Feb 17 07:35:15 thunderbird kernel:  [<c01206d0>] do_softirq+0x90/0xa0
> Feb 17 07:35:15 thunderbird kernel:  [<c010b56d>] do_IRQ+0xfd/0x130
> Feb 17 07:35:15 thunderbird kernel:  [<c01098b4>]
> common_interrupt+0x18/0x20 Feb 17 07:35:15 thunderbird kernel:
> Feb 17 07:35:15 thunderbird kernel: Badness in pci_find_subsys at
> drivers/pci/search.c:167
> Feb 17 07:35:15 thunderbird kernel: Call Trace:
> Feb 17 07:35:15 thunderbird kernel:  [<c01ec168>] pci_find_subsys+0xe8/0xf0
> Feb 17 07:35:15 thunderbird kernel:  [<c01ec19f>] pci_find_device+0x2f/0x40
> Feb 17 07:35:15 thunderbird kernel:  [<c01ebfa8>] pci_find_slot+0x28/0x50
> Feb 17 07:35:15 thunderbird kernel:  [<e0e1222a>]
>  os_pci_init_handle+0x39/0x68 [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0ca685f>] _nv001243rm+0x1f/0x24
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0d57a5d>] _nv003797rm+0xa9/0x128
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0dc44a1>] _nv001490rm+0x55/0xe4
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0ded154>] _nv000816rm+0x334/0x384
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0d5592c>] _nv003801rm+0xd8/0x100
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0decc4f>] _nv000809rm+0x2f/0x34
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0d84b48>] _nv003606rm+0xe4/0x114
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0d846b8>] _nv003564rm+0x688/0x908
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0cbf267>] _nv004046rm+0x3a3/0x3b0
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0dc0b03>] _nv001476rm+0x1d3/0x45c
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0ca939a>] _nv000896rm+0x4a/0x64
> [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<e0caabb4>] rm_isr_bh+0xc/0x10
> [nvidia] Feb 17 07:35:15 thunderbird kernel:  [<e0e0fab1>]
> nv_kern_isr_bh+0xf/0x13 [nvidia]
> Feb 17 07:35:15 thunderbird kernel:  [<c01208b6>] tasklet_action+0x46/0x70
> Feb 17 07:35:15 thunderbird kernel:  [<c01206d0>] do_softirq+0x90/0xa0
> Feb 17 07:35:15 thunderbird kernel:  [<c010b56d>] do_IRQ+0xfd/0x130
> Feb 17 07:35:15 thunderbird kernel:  [<c01098b4>]
> common_interrupt+0x18/0x20 Feb 17 07:35:15 thunderbird kernel:
>
>
> Thanks,
>
> Thanos
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
