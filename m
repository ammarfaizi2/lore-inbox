Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSEIWr1>; Thu, 9 May 2002 18:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315172AbSEIWr0>; Thu, 9 May 2002 18:47:26 -0400
Received: from c17997.eburwd3.vic.optusnet.com.au ([210.49.198.98]:54269 "HELO
	satisfactory.karma") by vger.kernel.org with SMTP
	id <S315162AbSEIWrT>; Thu, 9 May 2002 18:47:19 -0400
Date: Fri, 10 May 2002 08:47:11 +1000
From: Andrew Clausen <clausen@gnu.org>
To: "Steve Pratt" <slpratt@us.ibm.com>
Cc: "Kevin M Corry" <corryk@us.ibm.com>, evms-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Evms-announce] [ANNOUNCE] EVMS Release 1.0.1
Message-ID: <20020509224711.GA1157@gnu.org>
In-Reply-To: <OFDE4879C8.491FA45A-ON85256BB4.004CD1A5@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Accept-Language: en,pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 09:37:56AM -0500, Steve Pratt wrote:
> >Notice you have no error handling, etc. now?
> 
> Do you mean message handling or error reporting.  Forking JFS mkfs gives me
> just as many return codes as libparted (pass/fail)

Parted gives you a lot more than pass/fail.  (Have you read doc/API?
There's a section of PedException)

> and other than possibly
> some messages, this is all EVMS requires.

Why?  EVMS's messaging system allows interactive error handling.
Why not use it?

> >Also, while I'm at it: you didn't like my idea for interfacing
> >the parted exception system with evms properly?  I even wrote the code
> >for you (without testing it)... I didn't see a reply to my mail...
> >you(s) didn't like it?
> 
> Not that we didn't like it, just have way to many things to do.

Ah, ok.

> >BTW: what do you think of how libparted interfaces with libreiserfs?
> >There has been a lot of work, and it has all been merged properly now.
> >I think EVMS should do something similar.  Have a look in
> >libparted/fs_reiserfs.
> 
> I saw mention that you had done this.  Do you actually allow options to be
> passed to the reiserfs utils, or is it still limited to defaults.

Still just defaults... I plan to do an evms-like parameters interface
soonish.  Anyway, implementing it shouldn't present any special problems.
It is orthogonal to the way libparted and libreiserfs interface themselves.

> Last
> time I looked the APIs in libparted didn't provide for this.  Without this
> support the whole thing is rather uninteresting to us.

Well, libparted is quite limited and immature, I agree.  But it has
ideas that EVMS doesn't have (and vice versa), so it's useful
("interesting") for us to be looking at each other's code.

I think the way libparted and libreiserfs work together should be
interesting to you... it only enables full reiserfs support when
libreiserfs is installed.  I don't think it's the Final Solution TM...
I think we have a problem of how to handle multiple implementions
of the same thing.  (Which can be useful: for example, reconstructive
vs incremental file system resizers, etc.)  Anyway, I'd like you to
tell me how crap the current libparted <-> libreiserfs thing is,
so I can make it better ;)

Andrew
