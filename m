Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271038AbRHPORG>; Thu, 16 Aug 2001 10:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271316AbRHPOQ5>; Thu, 16 Aug 2001 10:16:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11513 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S271296AbRHPOQr> convert rfc822-to-8bit; Thu, 16 Aug 2001 10:16:47 -0400
Message-ID: <3B7BD5BB.F5FCE1DD@mvista.com>
Date: Thu, 16 Aug 2001 07:16:27 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: How should nano_sleep be fixed (was: ptrace(), fork(), sleep(), 
 exit(), SIGCHLD)
In-Reply-To: <20010813093116Z270036-761+611@vger.kernel.org> <20010814092849.E13892@pc8.lineo.fr> <20010814201825Z270798-760+1687@vger.kernel.org> <3B7A9953.744977A5@mvista.com> <3B7AB93D.F8B5B455@mvista.com> <3B7B1B07.A9FB293B@mvista.com> <20010816121746.A5861@pc8.lineo.fr> <20010816112905.A30202@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Thu, Aug 16, 2001 at 12:17:46PM +0200, christophe barbé wrote:
> > > asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec
> > > *rmtp)
> > > {
> > >     struct timespec t;
> > >     unsigned long expire;
> > > +   struct pt_regs * regs = (struct pt_regs *) &rqtp;
> 
> Note also that this is bogus as an architecture invariant.
> 
> On ARM, we have to pass a pt_regs pointer into any function that requires
> it.
> 
Does that mean that any function that requires pt_regs _must_ not be in
common code?  Isn't there a better solution than implementing these
functions over and over for each platform?

George
