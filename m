Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272002AbRH2PgH>; Wed, 29 Aug 2001 11:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272003AbRH2Pf5>; Wed, 29 Aug 2001 11:35:57 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:33041 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272002AbRH2Pfi>; Wed, 29 Aug 2001 11:35:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Date: Wed, 29 Aug 2001 17:42:39 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Roman Zippel <zippel@linux-m68k.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108281812200.978-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108281812200.978-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010829153552Z16100-32383+2289@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 29, 2001 03:13 am, Linus Torvalds wrote:
> On Wed, 29 Aug 2001, Daniel Phillips wrote:
> >
> >     min(host->scsi.SCp.this_residual, (unsigned) DMAC_BUFFER_SIZE / 2);
> 
> Sure.
> 
> If you put the type information explicitly, you can get it right.
> 
> Which is, btw, _exactly_ why the min() function takes the type explicitly.

My point is that proper programming discipline would have prevented the 
problem from arising in the first place.  It would be far more appropriate 
for kernel programmers to exercise such discpline than to treat them like 
babies, breaking well-known syntax in the process.

It seems trivial to pick up all potential min/max problems with the Stanford 
Checker in the case some programmer has been too clueless to think about 
their code as they write it.  A simple policy statement for users of min/max 
would have avoided this entire mess.

Not that I you're going to back down, it just made me feel better to get this 
off my chest ;-)

--
Daniel
