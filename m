Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUH3OI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUH3OI7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbUH3OI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:08:59 -0400
Received: from the-village.bc.nu ([81.2.110.252]:42881 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266807AbUH3OIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:08:53 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <4132793C.4030703@cybsft.com>
References: <20040828194449.GA25732@elte.hu>
	 <200408282210.03568.pnambic@unu.nu> <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <1093762642.1348.3.camel@krustophenia.net> <20040829190655.GA8840@elte.hu>
	 <4132793C.4030703@cybsft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093871169.30069.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 30 Aug 2004 14:06:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-30 at 01:47, K.R. Foley wrote:
> Aug 29 09:32:50 daffy kernel: requesting new irq thread for IRQ1...
> Aug 29 09:32:50 daffy kernel: atkbd.c: Spurious ACK on isa0060/serio1. 
> Some program, like XFree86, might be trying access hardware directly.

This is a known bug in the ps/2 driver layer. The printk can be
triggered by multiple quite valid situations. I've suggested it be
removed several times. Also XFree86 is a trademark so it should be
XFree86(tm) ;)

The later ones are odd. It might be interesting to try turning off USB
legacy support in the BIOS, that may be causing real problems in your
case.

Alan

