Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132692AbRC2J0R>; Thu, 29 Mar 2001 04:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132688AbRC2J0I>; Thu, 29 Mar 2001 04:26:08 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:25101 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S132686AbRC2JZ5>;
	Thu, 29 Mar 2001 04:25:57 -0500
Date: Thu, 29 Mar 2001 11:25:04 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: kernel apm code
To: John Fremlin <chief@bandits.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
   linux-laptop@vger.kernel.org, apm@linuxcare.com.au,
   apenwarr@worldvisions.ca, sfr@linuxcare.com.au
Message-id: <3AC2FF70.CA2317B6@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3AC0A679.DFA9F74B@uni-mb.si> <"m28zlr58w9.fsf"@boreas.yi.org>
 <3AC1C406.652D0207@uni-mb.si> <"m2bsqmlyrh.fsf"@boreas.yi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Fremlin wrote:
> 
> David Balazic <david.balazic@uni-mb.si> writes:
> 
> > John Fremlin wrote:
> > >
> > >  David Balazic <david.balazic@uni-mb.si> writes:
> 
> [...]
> 
> > > The maintainer hasn't the time to do it. He promised me he would in
> > > February, when I telephone, but hasn't bothered to do anything
> > > AFAICS. I hacked together the following patch for it a while ago,
> > > which updated APM_IOC_REJECT for slightly more recent kernels (be
> > > warned, I think I made some mistakes)
> >
> > It uses the same version number ( 1.15 ) as the "official" apm.c (
> > at linuxcare.com.au/apm ). I don't think that is a good idea.  Maybe
> > 1.14b ?
> 
> Well it's not going to go anywhere unless you want to look after it so
> there's not much point in worrying about that :-)

And the 2.4.2-ac26 apm.c has version 1.14 changes listed that are different
from the 1.14. changes listed in the patch from linuxcare.com.au/apm,
so it is not as big problem as I thought.

> [...]
> 
> > > I made a (IMHO) better version called pmpolicy, based on different
> > > principles. More information is available at
> > >
> > >         http://john.snoop.dk/programs/linux/offbutton/
> 
> > To implement off-button you only need the APM_IOC_REJECT ioctl and
> 
> The problem on my computer with my (re)implementation of
> APM_IOC_REJECT is that the screen goes into powersaving when the user
> suspend is received, then turns it back on when APM_IOC_REJECT is sent
> by apmd.

What is wrong with that ?
Suspend is requested -> suspend is executed
Suspend is canceled (rejected) -> suspend is canceled

Seems perfectly OK to me.


> Stephen said this was something wrong with my implementation
> (???).

User error ? :-)

> Anyway it is fixed in my pmpolicy patch, and I don't need no
> daemon so the code is a lot cleaner and simpler (no binary magic
> number interfaces).

But there should be no policy in the kernel ! ;-)

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
