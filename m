Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287952AbSAMDIi>; Sat, 12 Jan 2002 22:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSAMDI2>; Sat, 12 Jan 2002 22:08:28 -0500
Received: from zero.tech9.net ([209.61.188.187]:12561 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287952AbSAMDIT>;
	Sat, 12 Jan 2002 22:08:19 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: arjan@fenrus.demon.nl, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16PUeP-00034K-00@the-village.bc.nu>
In-Reply-To: <E16PUeP-00034K-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 12 Jan 2002 22:10:55 -0500
Message-Id: <1010891457.3561.18.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-12 at 15:21, Alan Cox wrote:

> You completely misunderstand.
> 
> 	disable_irq(n)
> 
> I disable a single specific interrupt, I don't disable the timer interrupt.
> Your code doesn't seem to handle that.

It can if we increment the preempt_count in disable_irq_nosync and
decrement it on enable_irq.

	Robert Love

