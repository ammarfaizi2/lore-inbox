Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293073AbSCEAvy>; Mon, 4 Mar 2002 19:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293084AbSCEAvo>; Mon, 4 Mar 2002 19:51:44 -0500
Received: from zero.tech9.net ([209.61.188.187]:56082 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293073AbSCEAv3>;
	Mon, 4 Mar 2002 19:51:29 -0500
Subject: Re: [PATCH] 2.5: preemptive kernel on UP
From: Robert Love <rml@tech9.net>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020305004325.C32309@flint.arm.linux.org.uk>
In-Reply-To: <1015287099.865.3.camel@phantasy> 
	<20020305004325.C32309@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 19:51:33 -0500
Message-Id: <1015289494.865.40.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-04 at 19:43, Russell King wrote:

> > diff -urN linux-2.5.6-pre2/arch/alpha/kernel/entry.S linux/arch/alpha/kernel/entry.S
> > --- linux-2.5.6-pre2/arch/alpha/kernel/entry.S	Fri Mar  1 17:21:14 2002
> > +++ linux/arch/alpha/kernel/entry.S	Mon Mar  4 17:49:27 2002
> > @@ -495,7 +495,7 @@
> >  	ret	$31,($26),1
> >  .end alpha_switch_to
> >  
> > -#ifdef CONFIG_SMP
> > +#ifdef CONFIG_SMP || CONFIG_PREEMPT
> 
> Surely you really don't mean this?

Yes, why?  We need to call schedule_tail ...

	Robert Love

