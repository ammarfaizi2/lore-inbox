Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286326AbRL0QEW>; Thu, 27 Dec 2001 11:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286329AbRL0QEO>; Thu, 27 Dec 2001 11:04:14 -0500
Received: from c88s124h4.upc.chello.no ([62.179.175.88]:38807 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S286326AbRL0QEB>; Thu, 27 Dec 2001 11:04:01 -0500
Subject: Re: Again:syscall from modules
From: Terje Eggestad <terje.eggestad@scali.com>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Amber Palekar <amber_palekar@yahoo.com>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1009468465.15846.0.camel@eggis1>
In-Reply-To: <20011225131441.60811.qmail@web20306.mail.yahoo.com> 
	<1009468465.15846.0.camel@eggis1>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 27 Dec 2001 17:04:45 +0100
Message-Id: <1009469085.16227.0.camel@eggis1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guess I should add that most sys_* functions are wrappers.

On Thu, 2001-12-27 at 16:54, Terje Eggestad wrote:
> Yes, the sys_* funcs are declared asmlinkage int sys_*. 
> where the asmlinkage differ from platform to platform. 
> It's used to tell the compiler if a non standared calling 
> convertion is used, typically if params are passed by registers
> instead of stack. The asmlinkage define must be sett according to the
> syscall dispatcher (entry.S on ia32), and may be changed accordingly. 
> 
> In short, if you want to use sys_* you must understand the interaction
> between the sys_* funcs and the dispatcher on *every* platform, and
> the interaction may change without notice.
> 
> In short short, don't don't don't don't use the sys_* functions.
> 
> TJ
> 
> On Tue, 2001-12-25 at 14:14, Amber Palekar wrote:
> > 
> >  Hi,
> >  
> > > Just use sock_sendmsg() and sock_recvmsg() directly.
> > > They are both
> > > exported in netsyms.c.
> >   Is there any specific reason behind not exporting
> > sys_sendto and sys_recvfrom ??
> > 
> > > Cheers,
> > >   Trond
> > 
> > TIA
> > Amber
> > 
> > 
> > __________________________________________________
> > Do You Yahoo!?
> > Send your FREE holiday greetings online!
> > http://greetings.yahoo.com
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


