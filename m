Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262563AbRE3CCS>; Tue, 29 May 2001 22:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262564AbRE3CCI>; Tue, 29 May 2001 22:02:08 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:29422 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262563AbRE3CBz>;
	Tue, 29 May 2001 22:01:55 -0400
Date: Tue, 29 May 2001 19:01:52 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: jt@hpl.hp.com, Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, tori@unhappy.mine.nu,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net #9
Message-ID: <20010529190152.A14806@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <200105300048.CAA04583@green.mif.pg.gda.pl> <20010529180420.A14639@bougret.hpl.hp.com> <3B14493E.63F861E7@mandrakesoft.com> <20010529182506.A14727@bougret.hpl.hp.com> <3B145127.5B173DFF@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B145127.5B173DFF@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, May 29, 2001 at 09:47:19PM -0400
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 09:47:19PM -0400, Jeff Garzik wrote:
> Jean Tourrilhes wrote:
> > 
> > On Tue, May 29, 2001 at 09:13:34PM -0400, Jeff Garzik wrote:
> > >
> > > This is standard kernel cleanup that makes the resulting image smaller.
> > > These patches have been going into all areas of the kernel for quite
> > > some time.
> > 
> >         This doesn't make it right.
> > 
> >         Ok, while we are on the topic : could somebody explain me why
> > we can't get gcc to do that for us ? What is preventing adding a gcc
> > command line flag to do exactly that ? It's not like rocket science
> > (simple test) and would avoid to have tediously to go through all
> > source code, past, present and *future* to make those changes.
> >         Bah, maybe it's too straightforward...
> 
> This is ANSI C standard stuff.  If a static object with a scalar type is
> not explicitly initialized, it is initialized to zero by default.
> 
> Sure we can get gcc to recognize that case, but why use gcc to work
> around code that avoids an ANSI feature?

	Good standard don't mandate the implementation. And as
somebody doing some other language said, there is more than one way to
do it.
	ANSI C doesn't prohibit to initialise variable to zero
(AFAIK). ANSI C doesn't prevent the compiler to optimise for this
case. If I initialise the varaible 3 time to the same value in a row,
gcc will remove the other two.

	Let's put it another way... What's different between :
		for(i = 0; i < n; i++) xxx;
	And :
		i = 0; while(i++ < n) xxx;
	I would expect the compiler to produce code as efficient in
both cases, and leave the choice of coding style to the user.

	Jean
