Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271597AbTGQW2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271601AbTGQW2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:28:46 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:53185 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S271597AbTGQW2n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:28:43 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 17 Jul 2003 15:36:19 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: asm (lidt) question
In-Reply-To: <20030717152819.66cfdbaf.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.55.0307171535020.4845@bigblue.dev.mcafeelabs.com>
References: <20030717152819.66cfdbaf.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003, Randy.Dunlap wrote:

>
> In arch/i386/kernel, inline asm for loading IDT (lidt) is used a few
> times, but with slightly different constraints and output/input
> definitions.  Are these OK, equivalent, or what?
>
> [rddunlap@dragon kernel]$ findc lidt
> ./cpu/common.c:484: __asm__ __volatile__("lidt %0": "=m" (idt_descr));
> ./traps.c:783:	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
>
> vs.
>
> ./reboot.c:186:	__asm__ __volatile__ ("lidt %0" : : "m" (real_mode_idt));
> ./reboot.c:261:	__asm__ __volatile__("lidt %0": :"m" (no_idt));
> ./suspend.c:95:	asm volatile ("lidt %0" :: "m" (saved_context.idt_limit));

I'd have said no looking at the syntax (input/output), but they indeed
generate the same code (just checked).



- Davide

