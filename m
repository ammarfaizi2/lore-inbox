Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271578AbRHPQAW>; Thu, 16 Aug 2001 12:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271581AbRHPQAD>; Thu, 16 Aug 2001 12:00:03 -0400
Received: from mailhost.lineo.fr ([194.250.46.226]:1548 "EHLO
	mailhost.lineo.fr") by vger.kernel.org with ESMTP
	id <S271579AbRHPP76>; Thu, 16 Aug 2001 11:59:58 -0400
Date: Thu, 16 Aug 2001 18:00:10 +0200
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>
Subject: Re: How should nano_sleep be fixed (was: ptrace(), fork(), sleep(), exit(), SIGCHLD)
Message-ID: <20010816180010.A9235@pc8.lineo.fr>
In-Reply-To: <20010813093116Z270036-761+611@vger.kernel.org> <20010814092849.E13892@pc8.lineo.fr> <20010814201825Z270798-760+1687@vger.kernel.org> <3B7A9953.744977A5@mvista.com> <3B7AB93D.F8B5B455@mvista.com> <3B7B1B07.A9FB293B@mvista.com> <20010816121746.A5861@pc8.lineo.fr> <20010816112905.A30202@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: =?iso-8859-1?Q?=3C20010816112905=2EA30202?=
	=?iso-8859-1?B?QGZsaW50LmFybS5saW51eC5vcmcudWs+OyBmcm9tIHJta0Bhcm0ubGlu?=
	=?iso-8859-1?B?dXgub3JnLnVrIG9uIGpldSwgYW/7?= 16, 2001 at 12:29:05 +0200
X-Mailer: Balsa 1.2.pre1-cvs20010812
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le jeu, 16 aoû 2001 12:29:05, Russell King a écrit :
> On Thu, Aug 16, 2001 at 12:17:46PM +0200, christophe barbé wrote:
> > > asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec
> > > *rmtp)
> > > {
> > > 	struct timespec t;
> > > 	unsigned long expire;
> > > +	struct pt_regs * regs = (struct pt_regs *) &rqtp;
> 
> Note also that this is bogus as an architecture invariant.
> 
> On ARM, we have to pass a pt_regs pointer into any function that requires
> it.

I'm not sure to understand your point.

The first sentence tell me that the "struct pt_regs ..." line is x86
specific and this was the reason behind my proposition to not add a _signal
macro but a  _sys_nanosleep macro to include this too.

The second sentence seem's to indicate that this is a classic problem for
the ARM port. So if this is correct what is the best way to solve it ?

Christophe

> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM
> Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> 

-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com
