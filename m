Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287368AbSALTYJ>; Sat, 12 Jan 2002 14:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287359AbSALTYB>; Sat, 12 Jan 2002 14:24:01 -0500
Received: from zero.tech9.net ([209.61.188.187]:39952 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287342AbSALTXr>;
	Sat, 12 Jan 2002 14:23:47 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: arjan@fenrus.demon.nl, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16PTIR-0002sL-00@the-village.bc.nu>
In-Reply-To: <E16PTIR-0002sL-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 12 Jan 2002 14:26:27 -0500
Message-Id: <1010863588.2007.34.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-12 at 13:54, Alan Cox wrote:
> Another example is in the network drivers. The 8390 core for one example
> carefully disables an IRQ on the card so that it can avoid spinlocking on 
> uniprocessor boxes.
> 
> So with pre-empt this happens
> 
> 	driver magic
> 	disable_irq(dev->irq)
> PRE-EMPT:
> 	[large periods of time running other code]
> PRE-EMPT:
> 	We get back and we've missed 300 packets, the serial port sharing
> 	the IRQ has dropped our internet connection completely.

We don't preempt while IRQ are disabled.

	Robert Love

