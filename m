Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbUDDSYu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 14:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbUDDSYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 14:24:50 -0400
Received: from web40504.mail.yahoo.com ([66.218.78.121]:39604 "HELO
	web40504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262532AbUDDSYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 14:24:48 -0400
Message-ID: <20040404182438.79937.qmail@web40504.mail.yahoo.com>
Date: Sun, 4 Apr 2004 11:24:38 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3ad1s0yq7.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Andi. That can be the case. Bad thing is that
stack size is hardcoded all over the kernel.

I wonder how it is possible to access task struct
having current stack pointer. %esp points at the
middle of the stack (when we are in the kernel) when
interrupt occures.

Serge.

--- Andi Kleen <ak@muc.de> wrote:
> Sergiy Lozovsky <serge_lozovsky@yahoo.com> writes:
> 
> > This function doesn't work in the kernel (system
> hungs
> > instantly when my function is called). Does
> antbody
> > have any idea what the reason can be? Some special
> > alignment? Special memory segment? In what
> direction
> > should I look?
> 
> The kernel puts some data about the current task at
> the bottom
> of the stack and accesses that by referencing the
> stack pointer
> in "current". This is even used by interrupts.
> 
> -Andi
> 


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
