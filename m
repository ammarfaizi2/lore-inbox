Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287158AbRL2IRC>; Sat, 29 Dec 2001 03:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287155AbRL2IQw>; Sat, 29 Dec 2001 03:16:52 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:30987 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287154AbRL2IQu>; Sat, 29 Dec 2001 03:16:50 -0500
Message-ID: <3C2D7B2B.C1362850@zip.com.au>
Date: Sat, 29 Dec 2001 00:13:31 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Legacy Fishtank <garzik@havoc.gtf.org>
CC: Keith Owens <kaos@ocs.com.au>, Mike Castle <dalgoda@ix.netcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system
In-Reply-To: <20011229042139.GC14067@thune.mrc-home.com> <9467.1009601050@ocs3.intra.ocs.com.au>,
		<9467.1009601050@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sat, Dec 29, 2001 at 03:44:10PM +1100 <20011229024143.A11696@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Legacy Fishtank wrote:
> 
> On Sat, Dec 29, 2001 at 03:44:10PM +1100, Keith Owens wrote:
> > What Mr. Fishtank seems to overlook is that kbuild 2.5 is far more
> > flexible and accurate than 2.4, including features that lots of people
> > want, like separate source and object trees.
> 
> I don't see the masses, or, well, anybody on lkml, clamoring for this.

Clamour.

The current system has some significant problems.  Pet peeves:

- Failure to rebuild the right things after you've applied a patch
- Doesn't work when the same tree is accessed via different paths
  (make dep on local machine, build across nfs)
- Mysterious recompilation of things which you've already compiled.

> IIRC from the kernel summit SGI was the only entity clamoring for this.
> 
> > Now that the overall
> > kbuild design is correct, the core code can be rewritten for speed.
> > And that will be done a couple of weeks after kbuild 2.5 goes into the
> > kernel, then I expect kbuild 2.5 to be faster than kbuild 2.4 even on
> > full builds.
> 
> Ok... you want kbuild into 2.5 ASAP, only to submit a rewrite two weeks later?

An optimisation of one bit, Keith says.  I'd guess that his two-week
estimate is optimistic because he'll have a busy two weeks supporting
the patch once it goes in, but whatever.
 
> If so it makes even less sense to get kbuild into 2.5.x now.

Keith says it speeds up builds where only a small number of files
have changed.  For me, that's the common case.

I'd like to hear more from Keith on where this 100% actually occurs,
but if he says it's fixable in a (give him four) week timeframe,
I believe him.

As you know, I'd be more concerned about moves to drop support
for the older and much faster gcc versions.  If you're not using
egcs-1.1.2, you're already a very patient person.

>         Jeff

Fish.

-
