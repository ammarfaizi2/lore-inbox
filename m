Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbRHYJQN>; Sat, 25 Aug 2001 05:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbRHYJPx>; Sat, 25 Aug 2001 05:15:53 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:28946 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S267520AbRHYJPm> convert rfc822-to-8bit; Sat, 25 Aug 2001 05:15:42 -0400
Date: Sat, 25 Aug 2001 11:13:10 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Marc A. Lehmann" <pcg@goof.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <Pine.LNX.4.33L.0108250007140.5646-100000@imladris.rielhome.conectiva>
Message-ID: <20010825110340.W817-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Aug 2001, Rik van Riel wrote:

> On Sat, 25 Aug 2001, Marc A. Lehmann wrote:
> > On Fri, Aug 24, 2001 at 05:19:07PM -0300, Rik van Riel <riel@conectiva.com.br> wrote:
> > > Actually, no.  FIFO would be ok if you had ONE readahead
> > > stream going on, but when you have multiple readahead
> >
> > Do we all agree that read-ahead is actually the problem? ATM, I serve
> > ~800 files, read()ing them in turn. When I increase the number of
> > threads I have more reads at the same time in the kernel, but the
> > absolute number of read() requests decreases.
>
> 	[snip evidence beyond all doubt]

I am not so sure. :)

Btw, the new VM and elevator have been very long to stabilize. Such
erratic development process does not make softwares appear trustable to
me. I would also suspect some flaws in these parts, too.

> Earlier today some talking between VM developers resulted
> in us agreeing on trying to fix this problem by implementing
> dynamic window scaling for readahead, using heuristics not
> all that much different from TCP window scaling.

It is probably time to rewrite this old code. Good luck for that.

> This should make the system able to withstand a higher load
> than currently, while also allowing fast data streams to
> work with more efficiently than currently.

That's the wish. Just crossing finger for things to work a lot better than
the development of your new VM and elevator improvements. :-)

Regards,
  Gérard.

