Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318774AbSHWMLc>; Fri, 23 Aug 2002 08:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318775AbSHWMLb>; Fri, 23 Aug 2002 08:11:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:34689 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318774AbSHWMLa>; Fri, 23 Aug 2002 08:11:30 -0400
Date: Fri, 23 Aug 2002 08:17:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: sanket rathi <sanket@linuxmail.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: interrupt handler
In-Reply-To: <20020823115821.26511.qmail@linuxmail.org>
Message-ID: <Pine.LNX.3.95.1020823080728.21127A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2002, sanket rathi wrote:

> hi,
> Can i use spin lock in the interrupt handler for a singlre processor
> machine. because books says u can not use locks but spin lock is some
> thing diffrent 
> 
> thanks in advance
> 
> --Sanket
> ---------

Interrupts default to OFF within an interrupt handler. Given this,
why would you use a spin-lock within the ISR on a single-processor
machine?

To directly answer your question, YES, you can use a spin-lock
within an ISR even though it won't do anything except add code
on a single processor machine.

On multiple CPU machines, you can use the form of spin-lock that
does not save/restore interrupts within the ISR, and use the
save/restore versions, with the same lock variable, outside the
ISR.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

