Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbSJYLXN>; Fri, 25 Oct 2002 07:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261367AbSJYLXN>; Fri, 25 Oct 2002 07:23:13 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:42120 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S261366AbSJYLXL>;
	Fri, 25 Oct 2002 07:23:11 -0400
Date: Fri, 25 Oct 2002 13:29:23 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [linux@hazard.jcu.cz: Re: [miniPATCH][RFC] Compilation fixes in the 2.5.44]
Message-ID: <20021025112923.GB1073@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo l-k,

I resend my answer to l-k too...

Jan Marek

--YiEDa0DAkWCtVeE4
Content-Type: message/rfc822
Content-Disposition: inline

Date: Fri, 25 Oct 2002 12:15:19 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: Andrey Panin <pazke@orbita1.ru>
Subject: Re: [miniPATCH][RFC] Compilation fixes in the 2.5.44
Message-ID: <20021025101518.GA1073@hazard.jcu.cz>
References: <20021025062809.GA7522@hazard.jcu.cz> <200210250651.g9P6pnp14035@Port.imtp.ilyichevsk.odessa.ua> <20021025080157.GA311@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025080157.GA311@pazke.ipt>
User-Agent: Mutt/1.4i

Hallo l-k,

On Fri, Oct 25, 2002 at 12:01:57PM +0400, Andrey Panin wrote:
> On Fri, Oct 25, 2002 at 09:44:21AM -0200, Denis Vlasenko wrote:
> > On 25 October 2002 04:28, Jan Marek wrote:
> > > Hallo l-k,
> > >
> > > I'm beginner in the kernel hacking (or fixing ;-))).
> > >
> > > I have small patch, which is fixing some compilation errors (I'm
> > > using gcc-2.95.4-17 from Debian sid).
> > >
> > > The first chunk fixed this warning:
> > >
> > > arch/i386/kernel/irq.c: In function `do_IRQ':
> > > arch/i386/kernel/irq.c:331: warning: unused variable `esp'
> > >
> > > I move declaration of variable esp to the #ifdef blok, where it is
> > > using...
> > 
> > 
> >         unsigned int status;
> > -       long esp;
> >  
> >         irq_enter();
> >  
> >  #ifdef CONFIG_DEBUG_STACKOVERFLOW
> >         /* Debugging check for stack overflow: is there less than 1KB free? */
> > +       long esp;
> > 
> > Most C compilers don't allow you to mix declarations and code.
> > This is allowed only in new C standards. But GCC 3 seems to cope,
> > so it's probably fine for new kernels.
> 
> This fragment must be fixed, look at Documentation/Changes:

gcc-2.95.4-17 on my Debian works fine on that and without any
messages... You can try it, if you have other version of compiler...

> 
> "The recommended compiler for the kernel is gcc 2.95.x (x >= 3)"
> 
> Best regards.
>  
> -- 
> Andrey Panin            | Embedded systems software developer
> pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

--YiEDa0DAkWCtVeE4--
