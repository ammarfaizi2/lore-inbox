Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289312AbSA3PmQ>; Wed, 30 Jan 2002 10:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289314AbSA3PmH>; Wed, 30 Jan 2002 10:42:07 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:1427 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289312AbSA3Plz>;
	Wed, 30 Jan 2002 10:41:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rasmus Andersen <rasmus@jaquet.dk>
Subject: Re: Wanted: Volunteer to code a Patchbot
Date: Wed, 30 Jan 2002 16:46:05 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Roman Zippel <zippel@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
        killeri@iki.fi
In-Reply-To: <Pine.LNX.4.33.0201301306190.7674-100000@serv> <20020130161105.E9765@jaquet.dk> <20020130162851.H9765@jaquet.dk>
In-Reply-To: <20020130162851.H9765@jaquet.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Vww1-0000FS-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 04:28 pm, Rasmus Andersen wrote:
> On Wed, Jan 30, 2002 at 04:11:05PM +0100, Rasmus Andersen wrote:
> > If I understand correctly, the bot would, in its basic incarnation,
> > accept patches (at patchbot@somewhere), stamp them with an uid,
> > and forward them to various places, e.g., lists, maintainers etc
> > and let the sumbitter know the patch uid. A mailing list archive
> > would then be the patch store. Basic filtering could be done by
> > the bot to reject non-patches etc.
> 
> Somehow, I totally forgot the security disclaimer for some of
> the points. Obviously, mindlessly patching a makefile and
> executing it would be a Bad Idea. If no satisfying solution
> to this can be found, this (execute/compile) step could be 
> foregone.
> 
> Thanks to Tommy Faasen for raising this point.

I'd say, don't try to run it, just see if it applies cleanly.

Speaking of security, we can't expect Matti to take care of blocking spam
on the patch lists the way he does on lkml, so that is going to have to
be handled, or the system will fall apart.  Well, spammers are not going
to be bright enough to send correctly formed patches that apply without
rejects I hope, so maybe that is a non-problem.

The patchbot will have to understand the concept of a patch set, a
series of patches that apply in a particular order.  If it can handle
that it probably doesn't need a general way of handling inter-patch
relationships, at least to start.

-- 
Daniel
