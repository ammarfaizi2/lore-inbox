Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293092AbSCEAxo>; Mon, 4 Mar 2002 19:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293095AbSCEAxf>; Mon, 4 Mar 2002 19:53:35 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:10249 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S293092AbSCEAxY>; Mon, 4 Mar 2002 19:53:24 -0500
Date: Tue, 5 Mar 2002 00:53:18 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: preemptive kernel on UP
Message-ID: <20020305005318.A9508@flint.arm.linux.org.uk>
In-Reply-To: <1015287099.865.3.camel@phantasy> <20020305004325.C32309@flint.arm.linux.org.uk> <1015289494.865.40.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1015289494.865.40.camel@phantasy>; from rml@tech9.net on Mon, Mar 04, 2002 at 07:51:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 07:51:33PM -0500, Robert Love wrote:
> On Mon, 2002-03-04 at 19:43, Russell King wrote:
> 
> > > diff -urN linux-2.5.6-pre2/arch/alpha/kernel/entry.S linux/arch/alpha/kernel/entry.S
> > > --- linux-2.5.6-pre2/arch/alpha/kernel/entry.S	Fri Mar  1 17:21:14 2002
> > > +++ linux/arch/alpha/kernel/entry.S	Mon Mar  4 17:49:27 2002
> > > @@ -495,7 +495,7 @@
> > >  	ret	$31,($26),1
> > >  .end alpha_switch_to
> > >  
> > > -#ifdef CONFIG_SMP
> > > +#ifdef CONFIG_SMP || CONFIG_PREEMPT
> > 
> > Surely you really don't mean this?
> 
> Yes, why?  We need to call schedule_tail ...

It's a #ifdef, not a #if

Does this compiler message give you a better idea:

warning: extra tokens at end of #ifdef directive

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

