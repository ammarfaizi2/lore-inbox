Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285073AbSBITOG>; Sat, 9 Feb 2002 14:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSBITN5>; Sat, 9 Feb 2002 14:13:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24584 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284933AbSBITNo>; Sat, 9 Feb 2002 14:13:44 -0500
Date: Sat, 9 Feb 2002 12:59:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stelian Pop <stelian.pop@fr.alcove.com>
cc: <linux-kernel@vger.kernel.org>, Andreas Dilger <adilger@turbolabs.com>
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
In-Reply-To: <20020209181213.GA32401@come.alcove-fr>
Message-ID: <Pine.LNX.4.33.0202091241080.1196-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Feb 2002, Stelian Pop wrote:
>
> So, what is supposed to be the definitive, public bk repository,
> to pull from in order to have the latest changes ? (the one which will
> go on bk.kernel.org eventually)

Right now the "definitive" bk repository is on master.kernel.org, which
can only be accessed by people who have accounts there.

I also push it to my private version on bkbits.net, and it is supposed to
be automatically then pushed onwards to the public one that is at
http://linux.bkbits.net:8080/linux-2.5, but the infrastructure for that
isn't yet working.

NOTE! If you're working on something that doesn't absolutely need the
stuff in -pre5, you can (and should) just take the pre3 tree, and work
there. When I pull stuff from people I don't require that they be
up-to-date with me - one of the advantages of bk is that it's really easy
to merge stuff.

We'll get the official tree out in a more timely manner, one of the issues
is actually just the scalability of pushing to lots of developers for the
first time.

So if you're interested in BK: get one of the "older" trees now (eg the
2.5.4-pre3 one that is public). Because that will make it a lot easier and
a lot faster to just "bk pull" once the more modern trees come on-line if
you have at least a base for it.

Oh - final comment: try to pull over a fast line, and don't bog down
bkbits.net more than necessary. For example, if you are behind a modem or
a slow DSL line and you want to clone the repository and you have an
account with faster speeds, I'd suggest you _first_ clone it to that other
account, and then later clone it from there over the slow line.

(After that you can re-parent your slow one and make all further "bk
pull"s directly - getting a few days or weeks of work with a "pull" is not
too costly, but when doing the whole clone it is better to get in and get
out faster to avoid clogging up the server with lots of bkd's that are
just waiting..)

			Linus

