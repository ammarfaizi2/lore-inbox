Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266278AbUBQQI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266288AbUBQQI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:08:26 -0500
Received: from mailbox7.ucsd.edu ([132.239.1.59]:1042 "EHLO mailbox7.ucsd.edu")
	by vger.kernel.org with ESMTP id S266278AbUBQQIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:08:23 -0500
From: Athanasios Leontaris <aleontar@ucsd.edu>
Subject: 2.6.2 Kernel Badness with 1.0-5336 NVIDIA driver
Date: Tue, 17 Feb 2004 08:08:21 -0800
User-Agent: KMail/1.6
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Message-Id: <200402170808.21530.aleontar@ucsd.edu>
X-MailScanner: PASSED (v1.2.8 40023 i1HG8Mrb068646 mailbox7.ucsd.edu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all,

Pls cc me as I am not subscribing.
I know that the kernel is tainted so pls don't flame ;)
The kernel is 2.6.2 from www.kernel.org and I use AGPGART for AGP (_not_
NvAGP). Fast Writes and SBA are enabled. FC1 is the distro. The mobo is Abit 
KG7 and the video card an FX5600.

X stopped responding out of the blue, at a KDE 3.2 desktop, and it could not
be killed either. The following messages were uncovered in
my /var/log/messages:

Feb 17 07:35:15 thunderbird kernel: Badness in pci_find_subsys at
drivers/pci/search.c:167
Feb 17 07:35:15 thunderbird kernel: Call Trace:
Feb 17 07:35:15 thunderbird kernel:  [<c01ec168>] pci_find_subsys+0xe8/0xf0
Feb 17 07:35:15 thunderbird kernel:  [<c01ec19f>] pci_find_device+0x2f/0x40
Feb 17 07:35:15 thunderbird kernel:  [<c01ebfa8>] pci_find_slot+0x28/0x50
Feb 17 07:35:15 thunderbird kernel:  [<e0e1222a>]
 os_pci_init_handle+0x39/0x68 [nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0ca685f>] _nv001243rm+0x1f/0x24
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0ded115>] _nv000816rm+0x2f5/0x384
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0d5592c>] _nv003801rm+0xd8/0x100
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0decc4f>] _nv000809rm+0x2f/0x34
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0d84b48>] _nv003606rm+0xe4/0x114
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0d846b8>] _nv003564rm+0x688/0x908
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0cbf267>] _nv004046rm+0x3a3/0x3b0
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0dc0b03>] _nv001476rm+0x1d3/0x45c
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0ca939a>] _nv000896rm+0x4a/0x64
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0caabb4>] rm_isr_bh+0xc/0x10 [nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0e0fab1>] nv_kern_isr_bh+0xf/0x13
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<c01208b6>] tasklet_action+0x46/0x70
Feb 17 07:35:15 thunderbird kernel:  [<c01206d0>] do_softirq+0x90/0xa0
Feb 17 07:35:15 thunderbird kernel:  [<c010b56d>] do_IRQ+0xfd/0x130
Feb 17 07:35:15 thunderbird kernel:  [<c01098b4>] common_interrupt+0x18/0x20
Feb 17 07:35:15 thunderbird kernel:
Feb 17 07:35:15 thunderbird kernel: Badness in pci_find_subsys at
drivers/pci/search.c:167
Feb 17 07:35:15 thunderbird kernel: Call Trace:
Feb 17 07:35:15 thunderbird kernel:  [<c01ec168>] pci_find_subsys+0xe8/0xf0
Feb 17 07:35:15 thunderbird kernel:  [<c01ec19f>] pci_find_device+0x2f/0x40
Feb 17 07:35:15 thunderbird kernel:  [<c01ebfa8>] pci_find_slot+0x28/0x50
Feb 17 07:35:15 thunderbird kernel:  [<e0e1222a>]
 os_pci_init_handle+0x39/0x68 [nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0ca685f>] _nv001243rm+0x1f/0x24
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0d57a5d>] _nv003797rm+0xa9/0x128
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0dc44a1>] _nv001490rm+0x55/0xe4
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0ded154>] _nv000816rm+0x334/0x384
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0d5592c>] _nv003801rm+0xd8/0x100
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0decc4f>] _nv000809rm+0x2f/0x34
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0d84b48>] _nv003606rm+0xe4/0x114
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0d846b8>] _nv003564rm+0x688/0x908
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0cbf267>] _nv004046rm+0x3a3/0x3b0
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0dc0b03>] _nv001476rm+0x1d3/0x45c
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0ca939a>] _nv000896rm+0x4a/0x64
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0caabb4>] rm_isr_bh+0xc/0x10 [nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<e0e0fab1>] nv_kern_isr_bh+0xf/0x13
[nvidia]
Feb 17 07:35:15 thunderbird kernel:  [<c01208b6>] tasklet_action+0x46/0x70
Feb 17 07:35:15 thunderbird kernel:  [<c01206d0>] do_softirq+0x90/0xa0
Feb 17 07:35:15 thunderbird kernel:  [<c010b56d>] do_IRQ+0xfd/0x130
Feb 17 07:35:15 thunderbird kernel:  [<c01098b4>] common_interrupt+0x18/0x20
Feb 17 07:35:15 thunderbird kernel:


Thanks,

Thanos
