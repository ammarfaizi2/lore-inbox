Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289312AbSA1SlB>; Mon, 28 Jan 2002 13:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289313AbSA1Sko>; Mon, 28 Jan 2002 13:40:44 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:42116 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289312AbSA1Skb>;
	Mon, 28 Jan 2002 13:40:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Don't use dbench for benchmarks
Date: Mon, 28 Jan 2002 19:45:29 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020128144319.67654.qmail@web9203.mail.yahoo.com>
In-Reply-To: <20020128144319.67654.qmail@web9203.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VGmX-0000BQ-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 28, 2002 03:43 pm, Alex Davis wrote:
> > Continuing that theme: please don't use dbench for benchmarks.  At all.
> > It's an unreliable indicator of anything in particular except perhaps
> > stability.  Please, use something else for your benchmarks.
>
> What do you suggest as an acceptable benchmark??? 

A benchmark that tests disk/file system create/read/write/delete throughput, 
as dbench is supposed to?  Though I haven't used it personally, others 
(Arjan) have suggested tiobench:

  http://tiobench.sourceforge.net/

Apparently it does not suffer from the kind of scheduling and caching 
variability that dbench does.  This needs to be verified.  Some multiple run 
benchmarks would do the trick, with results for the individual runs reported 
along the lines of what we have seen often with dbench.

Bonnie++ is another benchmark that is often suggested.  Again, I don't 
personally have much experience with it.

After that, I'm afraid we tend to enter the realm of commercial benchmarks, 
where the name of the game is to establish your own benchmark program as the 
standard so that you can charge big bucks for licensing your code (since your 
customers have two choices: either buy your code or don't publish their 
numbers, sweet deal).

Personally, I normally create my own benchmark tests, tailor-made to exercise 
the particular thing I'm working on at the moment.  Such quick hacks would 
not normally possess all the properties we'd like to see in benchmarks 
designed for widespread use and publication of results.

Anybody looking for a kernel-related project but not being quite ready to 
hack the kernel itself might well have a good think about what might 
constitute good benchmarks for various kernel subsystems, and code something 
up, or join up with others who are already interested in that subject, such 
as osdl or the tiobench project mentioned above.  This would be a valuable 
contribution.

-- 
Daniel
