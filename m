Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbSJUJjn>; Mon, 21 Oct 2002 05:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSJUJjn>; Mon, 21 Oct 2002 05:39:43 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:22195 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261294AbSJUJjm>; Mon, 21 Oct 2002 05:39:42 -0400
Subject: Re: PROBLEM: 2.4.1[89]: System hangs after "spurious 8259A
	interrupt: IRQ7"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: support-kai@cats.ms
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DAC089F.13653.6B67D6FF@localhost>
References: <3DAC089F.13653.6B67D6FF@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 11:01:27 +0100
Message-Id: <1035194487.27318.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-15 at 11:22, Kai Henningsen wrote:
> 
> In fact, the system hangs so soon (typically before or during fsck) 
> that I have no usefull 2.4 boot messages to offer - they scroll away 
> and then the keyboard locks. (And I can't make too extensive tests on 
> this machine, unfortunately, as it's an important server.)

Spurious IRQ 7 occurs when something asserts and deasserts the IRQ line
before the IRQ logic has time to decide whom. There is one known
"happens but harmless" case in the IDE logic where we happen to set nIEN
just as an IDE device asserts an IRQ. The second case I know about is
building with local apic support on some VIA boards. Build a kernel
without apic support



