Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWJFUPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWJFUPu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWJFUPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:15:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61888 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932575AbWJFUPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:15:49 -0400
Date: Fri, 6 Oct 2006 13:14:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot
 handle IRQ -1"
In-Reply-To: <20061006124213.28afb767.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610061313380.3952@g5.osdl.org>
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
 <m11wpl328i.fsf@ebiederm.dsl.xmission.com> <20061006155021.GE14186@rhun.haifa.ibm.com>
 <20061006162054.GF14186@rhun.haifa.ibm.com> <20061006190039.GN2365@n6014avq19270.qlogic.org>
 <20061006124213.28afb767.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Oct 2006, Andrew Morton wrote:
> 
> From my reading of `macro apicinterrupt' in arch/x86_64/kernel/entry.S,
> smp_apic_timer_interrupt() actually _does_ get passed the pt_reg*, only it
> doesn't declare it.  I think - Andi would need to confirm.

Yeah, I think you're right.

Anybody want to test Andrew's patch?

		Linus
