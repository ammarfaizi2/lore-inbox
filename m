Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317618AbSFMOU7>; Thu, 13 Jun 2002 10:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317620AbSFMOU6>; Thu, 13 Jun 2002 10:20:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39570 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317618AbSFMOU5>;
	Thu, 13 Jun 2002 10:20:57 -0400
Date: Thu, 13 Jun 2002 16:18:36 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, <dent@cosy.sbg.ac.at>,
        <adilger@clusterfs.com>, <da-x@gmx.net>, <patch@luckynet.dynu.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup 
In-Reply-To: <E17INWO-0005RJ-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206131614420.2982-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jun 2002, Rusty Russell wrote:

> > But i think it would be useful to introduce some sort of '_t convention',
> > where _t always means a complex (or potentially complex - opaque) type. It
> > makes code so much more compact and readable, and it does not hide
> > anything - _t *always* means a complex type in the way i use it.
> 
> OTOH, I've thought of adding a kerrno_t which is an int, and only useful
> for documentation purposes (meaning: I return 0 or -errno). This
> conflicts with your _t definition 8(

well, good rules have exceptions, and kerrno_t is not purely equivalent to
int, it's rather a restricted range of integers. This makes it more
eligible for the _t usage than counter_t for example.

	Ingo

