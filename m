Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313947AbSEMPM6>; Mon, 13 May 2002 11:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314057AbSEMPM6>; Mon, 13 May 2002 11:12:58 -0400
Received: from bitmover.com ([192.132.92.2]:13490 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313947AbSEMPM4>;
	Mon, 13 May 2002 11:12:56 -0400
Date: Mon, 13 May 2002 08:12:56 -0700
From: Larry McVoy <lm@bitmover.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
        "Dave Gilbert (Home)" <gilbertd@treblig.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513081256.B20864@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tomas Szepe <szepe@pinerecords.com>,
	Russell King <rmk@arm.linux.org.uk>,
	"Dave Gilbert (Home)" <gilbertd@treblig.org>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20020512145802Z313578-22651+30503@vger.kernel.org> <Pine.LNX.4.44L.0205122146310.32261-100000@imladris.surriel.com> <20020513115800.GC4258@louise.pinerecords.com> <3CDFB41A.6070701@treblig.org> <20020513140158.B6024@flint.arm.linux.org.uk> <20020513132734.GA5134@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In case you don't know, there is piles of information available from
BK about the changes made, you can make the reposrting be as verbose 
or as terse as you want.  You can also restrict output to a particular
user or expression.

Examples:

	bk changes 	# gets you the default output, time sorted changesets
	bk changes -v	# same thing but includes file comments as well

BK reporting is keyed off of somehing called "dspecs" (for data
specification).  They are a lot like a primitive printf format.
The default dspec for changes is

	":DPN:@:I:, :Dy:-:Dm:-:Dd: :T::TZ:, :P:$if(:HT:){@:HT:}\n$each(:C:){  (:C:)\n}$each(:TAG:){  TAG: (:TAG:)\n}\n"

You can use dspecs to dig out anything you want, see "bk help prs" to get
the list of fields available.  A field is like :P: which is replaced with
the name of the person who made the checkin.

If you want to restrict output to a particular programmer, you can do stuff

	-d'$if(:P:=torvalds){:P:@nospam.com}'

I suspect that once you figure out how you want things to look, we can make
dspecs which do it, and if not, we'll fix the reporting engine.

Just as an FYI, bkweb is really little more than some gigantic dspecs.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
