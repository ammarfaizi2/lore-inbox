Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbTGIXwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268807AbTGIXuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:50:15 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:4871 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S268811AbTGIXse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:48:34 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: PROBLEM: ICH5 SATA controller not working in enhanced mode using
 SMP (2.4.21-ac4)
Date: Thu, 10 Jul 2003 00:03:12 +0000 (UTC)
Organization: Cistron Group
Message-ID: <beiag0$mmp$1@news.cistron.nl>
References: <5849.1057779997@www42.gmx.net> <3F0C9E3A.9080800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1057795392 23257 62.216.29.200 (10 Jul 2003 00:03:12 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F0C9E3A.9080800@pobox.com>,
Jeff Garzik  <jgarzik@pobox.com> wrote:
>h.t.d@gmx.de wrote:
>> When I am booting with kernel-2.4.21-ac4-smp the system hangs. Here are the 
>> last three lines of output: 
>[...]
>> When I am booting 2.4.21-ac4 in uniprocessor mode output looks like: 
>[...]
>> Conclusion: I think the problem is related to SMP and my chipset somehow, if
>
>
>It sounds like an SMP-related bug in my libata driver.  I very much 
>doubt it is a chipset problem.  I'll take a look this weekend, I have 
>the hardware to reproduce.

FWIW, on a P4/3GHz system with Intel SATA, 2.4.21-vanilla:

Linux version 2.4.21 (root@wormhole)
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
Total of 2 processors activated (11979.98 BogoMIPS).

(this is hyperthreading)

ICH5-SATA: IDE controller at PCI slot 00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y080L0, ATA DISK drive
blk: queue c0324f00, I/O limit 4095Mb (mask 0xffffffff)
hdc: Maxtor 6Y080M0, ATA DISK drive
hdd: Maxtor 6Y080M0, ATA DISK drive
blk: queue c0325374, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c03254c0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15

.. works fine. But it's now running 2.5.74-mm3 (also OK).

Mike.

