Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275122AbRJFNGu>; Sat, 6 Oct 2001 09:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275126AbRJFNGk>; Sat, 6 Oct 2001 09:06:40 -0400
Received: from hermes.toad.net ([162.33.130.251]:48297 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S275122AbRJFNG1>;
	Sat, 6 Oct 2001 09:06:27 -0400
Subject: Re: Question about rtc_lock
From: Thomas Hood <jdthood@mail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15pr4y-0001CV-00@the-village.bc.nu>
In-Reply-To: <E15pr4y-0001CV-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 06 Oct 2001 09:06:24 -0400
Message-Id: <1002373586.813.119.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-06 at 09:01, Alan Cox wrote:
> >                 spin_lock(&rtc_lock);
> >                 CMOS_WRITE(v, sbf_port);
> >                 spin_unlock(&rtc_lock);
> > 
> > Does this code run with irqs disabled, or should these
> > spinlocks be _irq ?
> 
> The CMOS isnt accessed from IRQ handlers

No, but what if the rtc interrupts while the lock is held in this
bit of code?

Thomas


