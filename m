Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbUC3GD4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 01:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbUC3GD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 01:03:56 -0500
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:39597 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S263240AbUC3GDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 01:03:52 -0500
Message-ID: <40690DC3.2060302@cornell.edu>
Date: Tue, 30 Mar 2004 01:03:47 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20040214 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.5-rc3
References: <Pine.LNX.4.58.0403292129200.1096@ppc970.osdl.org> <40690B84.7060203@cornell.edu>
In-Reply-To: <40690B84.7060203@cornell.edu>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> My binary-only proprietary unfree Nvidia driver is broken (and works on 
> 2.6.4). What are some interesting changeset numbers to try to locate the 
> exact cause?

Just in case this is helpful:

Mar 29 17:23:15 cobra kernel: Badness in pci_find_subsys at 
drivers/pci/search.c:167
Mar 29 17:23:15 cobra kernel: Call Trace:
Mar 29 17:23:15 cobra kernel:  [pci_find_subsys+232/240] 
pci_find_subsys+0xe8/0xf0
Mar 29 17:23:15 cobra kernel:  [pci_find_device+47/64] 
pci_find_device+0x2f/0x40
Mar 29 17:23:15 cobra kernel:  [pci_find_slot+40/80] pci_find_slot+0x28/0x50
Mar 29 17:23:15 cobra kernel: 
[__crc_pci_bus_find_capability+922468/2689568] 
os_pci_init_handle+0x39/0x68 [nvidia]
Mar 29 17:23:15 cobra kernel:  [__crc_send_sig+2251290/2818195] 
_nv001243rm+0x1f/0x24 [nvidia]
Mar 29 17:23:15 cobra kernel: 
[__crc_pci_bus_find_capability+158597/2689568] _nv003797rm+0xa9/0x128 
[nvidia]
Mar 29 17:23:15 cobra kernel: 
[__crc_pci_bus_find_capability+603593/2689568] _nv001490rm+0x55/0xe4 
[nvidia]
Mar 29 17:23:15 cobra kernel: 
[__crc_pci_bus_find_capability+770684/2689568] _nv000816rm+0x334/0x384 
[nvidia]
Mar 29 17:23:15 cobra kernel: 
[__crc_pci_bus_find_capability+150100/2689568] _nv003801rm+0xd8/0x100 
[nvidia]
Mar 29 17:23:15 cobra kernel: 
[__crc_pci_bus_find_capability+769399/2689568] _nv000809rm+0x2f/0x34 
[nvidia]
Mar 29 17:23:15 cobra kernel: 
[__crc_pci_bus_find_capability+153720/2689568] _nv003816rm+0xf0/0x104 
[nvidia]
Mar 29 17:23:15 cobra kernel: 
[__crc_pci_bus_find_capability+157167/2689568] _nv000013rm+0x77/0x84 
[nvidia]
Mar 29 17:23:15 cobra kernel: 
[__crc_pci_bus_find_capability+155539/2689568] _nv003780rm+0x1df/0x2c8 
[nvidia]
Mar 29 17:23:15 cobra kernel: 
[__crc_pci_bus_find_capability+155039/2689568] _nv000012rm+0x43/0x58 
[nvidia]
Mar 29 17:23:15 cobra kernel: 
[__crc_pci_bus_find_capability+154972/2689568] _nv000012rm+0x0/0x58 [nvidia]
Mar 29 17:23:15 cobra kernel:  [__crc_send_sig+2201687/2818195] 
_nv001219rm+0xa8/0x124 [nvidia]
Mar 29 17:23:15 cobra kernel: 
[__crc_pci_bus_find_capability+912349/2689568] nv_kern_rc_timer+0x0/0x37 
[nvidia]
Mar 29 17:23:15 cobra kernel:  [__crc_send_sig+2269297/2818195] 
rm_run_rc_callback+0x36/0x4c [nvidia]
Mar 29 17:23:15 cobra kernel: 
[__crc_pci_bus_find_capability+912368/2689568] 
nv_kern_rc_timer+0x13/0x37 [nvidia]
Mar 29 17:23:15 cobra kernel:  [__crc_sleep_on+1875873/3746342] 
rh_report_status+0x0/0x140 [usbcore]
Mar 29 17:23:15 cobra kernel:  [run_timer_softirq+203/432] 
run_timer_softirq+0xcb/0x1b0
Mar 29 17:23:15 cobra kernel:  [do_softirq+144/160] do_softirq+0x90/0xa0
Mar 29 17:23:15 cobra kernel:  [do_IRQ+253/304] do_IRQ+0xfd/0x130
Mar 29 17:23:15 cobra kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20

