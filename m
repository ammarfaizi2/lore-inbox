Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292520AbSCOONL>; Fri, 15 Mar 2002 09:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292522AbSCOONC>; Fri, 15 Mar 2002 09:13:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30731 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292520AbSCOOMx>; Fri, 15 Mar 2002 09:12:53 -0500
Subject: Re: 2.4.18 Preempt Freezeups
To: ian@ianduggan.net (Ian Duggan)
Date: Fri, 15 Mar 2002 14:28:36 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rml@tech9.net (Robert Love),
        linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <3C91B30D.A887A033@ianduggan.net> from "Ian Duggan" at Mar 15, 2002 12:38:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lshA-0003lX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is required for preempt beyond "SMP safe" code? I thought the whole
> idea was to make the preemptions transparent to other code by utilizing
> the SMP critical regions?

SMP safe code
Actual source code when recompiling modules
Reviewing things like driver code use of disable_irq by hand
Reviewing driver code for situations where it requires a small timing delay
	and a large one is unacceptable
Checking anywhere you use the cpu id that you don't do somthing where it
	might change under you (eg per cpu variables)
