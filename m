Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288169AbSAMV7f>; Sun, 13 Jan 2002 16:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288166AbSAMV7Z>; Sun, 13 Jan 2002 16:59:25 -0500
Received: from dsl081-053-223.sfo1.dsl.speakeasy.net ([64.81.53.223]:22657
	"EHLO starship.berlin") by vger.kernel.org with ESMTP
	id <S288159AbSAMV7P>; Sun, 13 Jan 2002 16:59:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, rml@tech9.net (Robert Love)
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Sun, 13 Jan 2002 23:02:27 +0100
X-Mailer: KMail [version 1.3.2]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arjan@fenrus.demon.nl,
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <E16PUeP-00034K-00@the-village.bc.nu>
In-Reply-To: <E16PUeP-00034K-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Pshw-0000F6-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 12, 2002 09:21 pm, Alan Cox wrote:
> > > I didn't see anywhere you check disable_irq(). Even if you did it doesnt
> > > help when I mask the irq on the chip rather than using disable_irq() calls.
> > 
> > Well, if IRQs are disabled we won't have the timer... would not the
> > system panic anyhow if schedule() was called while in an interrupt
> > handler?
> 
> You completely misunderstand.
> 
> 	disable_irq(n)
> 
> I disable a single specific interrupt, I don't disable the timer interrupt.
> Your code doesn't seem to handle that. Its just one of the examples of where
> you really need priority handling, and thats a horrible dark and slippery
> slope

He just needs to disable preemption there, it's just a slight mod to 
disable/enable_irq.  You probably have a few more of those, though...

--
Daniel
