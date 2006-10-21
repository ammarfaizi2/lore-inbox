Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423378AbWJUTiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423378AbWJUTiM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 15:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423380AbWJUTiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 15:38:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53638
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1423378AbWJUTiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 15:38:11 -0400
Date: Sat, 21 Oct 2006 12:38:14 -0700 (PDT)
Message-Id: <20061021.123814.106436476.davem@davemloft.net>
To: preining@logic.at
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: tg3 kernel bug in 2.6.18-mm3 and 2.6.19-rc2-mm2
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061021132239.GA29288@gamma.logic.tuwien.ac.at>
References: <20061021132239.GA29288@gamma.logic.tuwien.ac.at>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Norbert Preining <preining@logic.at>
Date: Sat, 21 Oct 2006 15:22:39 +0200

>  [<c010469d>] dump_stack+0x12/0x14
>  [<c0141cb3>] softlockup_tick+0xaa/0xc1
>  [<c0129bad>] update_process_times+0x3b/0x5e
>  [<c01362a1>] handle_update_profile+0x14/0x1e
>  [<c0115956>] smp_apic_timer_interrupt+0x49/0x5b
>  [<c0103998>] apic_timer_interrupt+0x28/0x30
> DWARF2 unwinder stuck at apic_timer_interrupt+0x28/0x30
> Leftover inexact backtrace:
>  [<c01d03af>] delay_tsc+0xb/0x13
>  [<c01d03e0>] __delay+0x6/0x7

It's OOPS'ing by softlockup'ing in udelay() and then we get a corrupt
backtrace.

