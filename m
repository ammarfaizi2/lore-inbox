Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWIJOXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWIJOXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 10:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWIJOXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 10:23:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:22195 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932194AbWIJOXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 10:23:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kqsgsJCGHn5M9ONFDkIOyBnVGAy94I5BlurZiGEuskTnxZtL5RQie9v+JAUvkblMRTIHgrjBPrtxgXdGC44oWdZoUdKGFbD0jIBffQLEQzpUP6zZ8bZx5SVDezKGzePe5h1Cur+0Pn0eoyVvHc2Hwcfvra2dIn1BgMMZx0z6Twc=
Message-ID: <a2ebde260609100723v553d3810o1651dc181e7db3bf@mail.gmail.com>
Date: Sun, 10 Sep 2006 22:23:05 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: Timer Selection
Cc: "Jeremy Fitzhardinge" <jeremy@goop.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200609101551.11521.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a2ebde260609100334v65bf5e4fx754e3b00576bfb9f@mail.gmail.com>
	 <200609101551.11521.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much.


2006/9/10, Andi Kleen <ak@suse.de>:
> On Sunday 10 September 2006 12:34, Dong Feng wrote:
> > In i386 architecture, there are five timers as candidates in the selection
> > of "cur_timer." I feel among the five only two types can be used as Kernel
> > base timer, HPET and PIT. Kernel base timer is the timer trigger
> > timer_interrupt() periodically. Namely, the timer installed on IRQ 0 in
> > i386 architecture.
> >
> > Is the above understanding correct? Particularly I want to confirm which
> > timers can be used as Kernel base timer.
>
> Only HPET and PIT can be interrupt 0 in the PC architecture
> (HPET only if the legacy option is available), but there is no reason
> the main timer handler cannot be driven from another interval timer (e.g.
> x86-64 offers the APIC timer as a option for this)
>
> -Andi
>
