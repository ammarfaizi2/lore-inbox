Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272020AbRH2RUI>; Wed, 29 Aug 2001 13:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272021AbRH2RT7>; Wed, 29 Aug 2001 13:19:59 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:53485 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S272020AbRH2RTl>; Wed, 29 Aug 2001 13:19:41 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Date: Wed, 29 Aug 2001 09:02:07 -0700 (PDT)
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010829153552Z16100-32383+2289@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0108290858410.19372-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

one question that I thought of in context with the other e-mails in this
thread.

when you write a signed/unsigned comparison is it defined in any standard
which type the compiler should generate or is it somethign that could be
different in different compilers (and versions)

(also when comparing different size items same question)

if there are cases that are not defined in a standard and could vary by
compiler/version then we definantly need to have the current version with
the type argument.

David Lang


 On Wed, 29 Aug 2001,
Daniel Phillips wrote:

> Date: Wed, 29 Aug 2001 17:42:39 +0200
> From: Daniel Phillips <phillips@bonn-fries.net>
> To: Linus Torvalds <torvalds@transmeta.com>
> Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
> Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
>
> On August 29, 2001 03:13 am, Linus Torvalds wrote:
> > On Wed, 29 Aug 2001, Daniel Phillips wrote:
> > >
> > >     min(host->scsi.SCp.this_residual, (unsigned) DMAC_BUFFER_SIZE / 2);
> >
> > Sure.
> >
> > If you put the type information explicitly, you can get it right.
> >
> > Which is, btw, _exactly_ why the min() function takes the type explicitly.
>
> My point is that proper programming discipline would have prevented the
> problem from arising in the first place.  It would be far more appropriate
> for kernel programmers to exercise such discpline than to treat them like
> babies, breaking well-known syntax in the process.
>
> It seems trivial to pick up all potential min/max problems with the Stanford
> Checker in the case some programmer has been too clueless to think about
> their code as they write it.  A simple policy statement for users of min/max
> would have avoided this entire mess.
>
> Not that I you're going to back down, it just made me feel better to get this
> off my chest ;-)
>
> --
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
