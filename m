Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422924AbWJFUUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422924AbWJFUUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWJFUT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:19:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751080AbWJFUT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:19:57 -0400
Date: Fri, 6 Oct 2006 13:18:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot
 handle IRQ -1"
Message-Id: <20061006131858.d5925b70.akpm@osdl.org>
In-Reply-To: <20061006200223.GT2365@n6014avq19270.qlogic.org>
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	<m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	<20061006155021.GE14186@rhun.haifa.ibm.com>
	<20061006162054.GF14186@rhun.haifa.ibm.com>
	<20061006190039.GN2365@n6014avq19270.qlogic.org>
	<20061006124213.28afb767.akpm@osdl.org>
	<20061006200223.GT2365@n6014avq19270.qlogic.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006 13:02:23 -0700
Andrew Vasquez <andrew.vasquez@qlogic.com> wrote:

> Patch appears to work.

OK, thanks - if Andi can confirm that this:

> -void smp_apic_timer_interrupt(void)
> +void smp_apic_timer_interrupt(struct pt_regs *regs)

really reflects reality then we're good to go.
