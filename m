Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265143AbTLRNvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 08:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbTLRNvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 08:51:54 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:1154
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265144AbTLRNvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 08:51:53 -0500
Date: Thu, 18 Dec 2003 08:51:06 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Miroslaw KLABA <totoro@totoro.be>
cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Double Interrupt with HT
In-Reply-To: <20031218131437.239e69e5.totoro@totoro.be>
Message-ID: <Pine.LNX.4.58.0312180849480.1710@montezuma.fsmlabs.com>
References: <20031215155843.210107b6.totoro@totoro.be>
 <1071603069.991.194.camel@cog.beaverton.ibm.com> <1071615336.3fdf8d6840208@ssl0.ovh.net>
 <1071618630.1013.11.camel@cog.beaverton.ibm.com> <1071630228.3fdfc794eb353@ssl0.ovh.net>
 <1071717730.1117.26.camel@cog.beaverton.ibm.com> <20031218131437.239e69e5.totoro@totoro.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003, Miroslaw KLABA wrote:

> > Does booting w/ "noapic" help?
> No, I still have the time that is going twice the speed.
> I included /proc/interrupts, dmesg and lspci. It's with the 2.4.23 kernel without the irq_balance patch.
> Hope this help.
>
> # cat /proc/interrupts
>            CPU0       CPU1
>   0:      71181      71121    IO-APIC-edge  timer
>   1:          2          2    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   4:         16         16    IO-APIC-edge  serial
>   8:          1          1    IO-APIC-edge  rtc
>  14:       3294       3295    IO-APIC-edge  ide0
>  23:       2334       2339   IO-APIC-level  eth0
> NMI:          0          0
> LOC:      71109      71108
> ERR:          0
> MIS:          0
>
> Kernel command line: auto BOOT_IMAGE=linux-bi ro root=301 BOOT_FILE=/boot/bzImage-2.4.23-bipiv noacpi

John meant 'noapic' not 'noacpi', you'll note that the interrupt
controller types after boot will be XT-PIC instead of say IO-APIC-edge
etc..
