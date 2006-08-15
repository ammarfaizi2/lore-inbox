Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965234AbWHOGvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbWHOGvA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 02:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbWHOGu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 02:50:59 -0400
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:4329
	"EHLO schlidder.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S965234AbWHOGu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 02:50:59 -0400
Message-ID: <44E16ECF.3060206@svs.Informatik.Uni-Oldenburg.de>
Date: Tue, 15 Aug 2006 08:50:55 +0200
From: Philipp Matthias Hahn <pmhahn@svs.Informatik.Uni-Oldenburg.de>
Organization: Carl von Ossietzky University Coldenburg
User-Agent: Debian Thunderbird 1.0.2 (X11/20060724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: openipmi-developer@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Soft lockup (and reboot): IPMI
References: <44E0A176.8070907@svs.Informatik.Uni-Oldenburg.de> <20060814210231.GB3637@lists.us.dell.com>
In-Reply-To: <20060814210231.GB3637@lists.us.dell.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:

> On Mon, Aug 14, 2006 at 06:14:46PM +0200, Philipp Matthias Hahn wrote:
> 
>>While playing with "openipmigui", the server just rebooted with the
>>following last message:
>>
>>BUG: soft lockup detected on CPU#0!
>><c0103416> show_trace+0xd/0xf
>><c01034e5> dump_stack+0x15/0x17
>><c01382b0> softlockup_tick+0x9d/0xae
>><c012190a> run_local_timers+0x12/0x14
>><c0121748> update_process_times+0x3c/0x61
>><c010e1d9> smp_apic_timer_interrupt+0x57/0x5f
>><c010307c> apic_timer_interrupt+0x1c/0x24
>><f8aa8783> ipmi_thread+0x43/0x71 [ipmi_si]
>><c0129e62> kthread+0x78/0xa0
>><c0100e31> kernel_thread_helper+0x5/0xb
>>
>>Any idea on what went wrong?
> 
> What kernel please?  If 2.6.17 or higher, this is new.  If < 2.6.17,
> this is most likely due to the udelay(1) call in ipmi_thread() which
> in 2.6.17 was replaced with a schedule().

Sorry for omitting that information, it's a plain 2.6.17.8 kernel.
model name      : Intel(R) Xeon(TM) CPU 2.66GHz

ipmi message handler version 39.0
IPMI Watchdog: driver initialized
ipmi device interface
IPMI System Interface driver.
ipmi_si: Trying SMBIOS-specified KCS state machine at I/O address 0xca2,
slave address 0x24, irq 0
ipmi: Found new BMC (man_id: 0x002880,  prod_id: 0x0000, dev_id: 0x00)
 IPMI KCS interface initialized

BYtE
Philipp
-- 
      Dipl.-Inform. Philipp.Hahn@informatik.uni-oldenburg.de
      Abteilung Systemsoftware und verteilte Systeme, Fk. II
Carl von Ossietzky Universitaet Oldenburg, 26111 Oldenburg, Germany
    http://www.svs.informatik.uni-oldenburg.de/contact/pmhahn/
      Telefon: +49 441 798-2866    Telefax: +49 441 798-2756
