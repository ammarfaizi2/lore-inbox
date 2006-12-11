Return-Path: <linux-kernel-owner+w=401wt.eu-S937100AbWLKQmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937100AbWLKQmg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937193AbWLKQmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:42:36 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:62698 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937100AbWLKQmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:42:35 -0500
From: Oliver Bock <o.bock@fh-wolfenbuettel.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime: vanilla 2.6.19 with 2.6.19-rt11 patch doesn't boot
Date: Mon, 11 Dec 2006 17:42:30 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200612092001.01542.o.bock@fh-wolfenbuettel.de> <20061211134354.GB8219@elte.hu>
In-Reply-To: <20061211134354.GB8219@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612111742.30838.o.bock@fh-wolfenbuettel.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:dd33dd6c1d5f49fc970db4042b12446b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Thanks for your reply. I tried -rt12 and could successfully boot my system.
However, now I find the following during boot:

registering clocksource pit
 [<c0134a8f>] clocksource_register+0x2f/0x130
 [<c0252ef4>] sysdev_register+0xf4/0x100
 [<c03a0070>] init_pit_clocksource+0x60/0x70
 [<c01003bf>] init+0x8f/0x310
 [<c010311e>] ret_from_fork+0x6/0x1c
 [<c0100330>] init+0x0/0x310
 [<c0100330>] init+0x0/0x310
 [<c0103d53>] kernel_thread_helper+0x7/0x14
 =======================
registering clocksource tsc
 [<c0134a8f>] clocksource_register+0x2f/0x130
 [<c0124796>] __mod_timer+0x86/0xb0
 [<c03a032d>] init_tsc_clocksource+0x18d/0x1f0
 [<c01003bf>] init+0x8f/0x310
 [<c010311e>] ret_from_fork+0x6/0x1c
 [<c0100330>] init+0x0/0x310
 [<c0100330>] init+0x0/0x310
 [<c0103d53>] kernel_thread_helper+0x7/0x14
 =======================
registering clocksource jiffies
 [<c0134a8f>] clocksource_register+0x2f/0x130
 [<c01a635a>] sysfs_create_file+0x3a/0x50
 [<c03aaf7f>] init_jiffies_clocksource+0xf/0x20
 [<c01003bf>] init+0x8f/0x310
 [<c010311e>] ret_from_fork+0x6/0x1c
 [<c0100330>] init+0x0/0x310
 [<c0100330>] init+0x0/0x310
 [<c0103d53>] kernel_thread_helper+0x7/0x14
 =======================
[...]
registering clocksource acpi_pm
 [<c0134a8f>] clocksource_register+0x2f/0x130
 [<c03b707a>] init_acpi_pm_clocksource+0xba/0x130
 [<c0255ede>] class_create+0x4e/0x70
 [<c01003bf>] init+0x8f/0x310
 [<c010311e>] ret_from_fork+0x6/0x1c
 [<c0100330>] init+0x0/0x310
 [<c0100330>] init+0x0/0x310
 [<c0103d53>] kernel_thread_helper+0x7/0x14
 =======================


This is my .config regarding HPET:

CONFIG_HPET_TIMER=y
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y


Oliver


On Monday 11 December 2006 14:43, you wrote:
> * Oliver Bock <o.bock@fh-wolfenbuettel.de> wrote:
> > Hi Ingo,
> >
> > I tried to boot a vanilla 2.6.19 kernel with your 2.6.19-rt11 patch
> > but without success. However, the patch applied without a single error
> > and the vanilla kernel (without the patch) works fine so far. As my
> > screen just stays black and as there's no HD activity after selecting
> > the kernel in grub, I suppose that it might be related to the new
> > Areca RAID driver I use (compiled in because all my partitions reside
> > on a RAID volume) in conjunction with your patch...
>
> do you have HPET enabled in your .config by any chance?
>
> 	Ingo
