Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272590AbRHaCe7>; Thu, 30 Aug 2001 22:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272591AbRHaCet>; Thu, 30 Aug 2001 22:34:49 -0400
Received: from Xenon.Stanford.EDU ([171.64.66.201]:452 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S272590AbRHaCeg>; Thu, 30 Aug 2001 22:34:36 -0400
Date: Thu, 30 Aug 2001 19:34:49 -0700
From: Andy Chou <acc@CS.Stanford.EDU>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <20010830193449.A18366@Xenon.Stanford.EDU>
Reply-To: acc@CS.Stanford.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.1.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about:

#define AssertNow(x) switch(1) { case (x): case 0: }

as in:

AssertNow(sizeof(typeof(x)) == sizeof(typeof(y)));

I'm not sure if gcc optimizes this away, but it would be easy for someone
to find out.

I didn't invent this.

-Andy


> And I was hoping that somebody could produce some gcc magic
> replacement for BUG() that means "don't compile me". Perhaps
> a bit of illegal assembler code with a line reference in?
> Surely gcc must have something like __builtin_wont_compile()?
> It just needs to be a leaf of the RTL that evokes a compile error.

