Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135823AbRECRpc>; Thu, 3 May 2001 13:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135826AbRECRpW>; Thu, 3 May 2001 13:45:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4104 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135823AbRECRpK>; Thu, 3 May 2001 13:45:10 -0400
Subject: Re: [kbuild-devel] Why recovering from broken configs is too hard
To: esr@thyrsus.com
Date: Thu, 3 May 2001 18:48:10 +0100 (BST)
Cc: kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503125921.A347@thyrsus.com> from "Eric S. Raymond" at May 03, 2001 12:59:21 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vND4-0005u6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (For those of you haven't caught up with this, *missing symbols do not
> make a configuration invalid*.  Only inconsistencies between explicitly
> set symbols can do that.)

If they make it invalid the tools should fix it.

> > (ii) Start with a invalid config.  CML2 makes best effort at correcting
> >      it.
> > 
> >      (a) Interactive mode (menuconfig, xconfig) - tell the user to fix
> >          it.
> 
> The problem with this is that in order to support it I have to throw away the
> configurator's central invariant -- which is that every change that does not
> lead to a valid configuration is rejected (with an explanation).  

If you get a conflict, turn the second feature in config file order off/on
as appropriate then tell the user you did it. Then continue to verify. If
you accidentally turn off the whole scsi layer well the user has been told it
happens and its still no worse than having no tool. While if it fixes it up
happily the user is pleased and it saved a lot of time. Also remember many
kernel builders are not gurus.

CML2 already poses a huge barrier to such people because its different to the
stuff in the book and the stuff their friend showed them. Thats a barrier
worth climbing because its a better tool for such people in the longer run.
But please don't add spikes on the top of said wall

> I'm not going to do that.  It's not worth it to handle a case this marginal.

In which case CML2 appears to be inferior to our current tools. It depends on
python2 which nobody ships by default yet. It doesn't handle this case.
Why should we be using it ;)

> There's the problem.  You don't know which variable(s) are dependent.
> That's not a well-defined notion here.  Consider the case that stimulated
> this whole argument:

Actually I think the problem is different. You are trying to solve a 
mathematical graph theory problem elegantly. Make oldconfig solves a real
world problem by a mixture of brutality and heuristics. 

Alan
PS: your .sig length checker still seems broken

