Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTBETCy>; Wed, 5 Feb 2003 14:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbTBETCy>; Wed, 5 Feb 2003 14:02:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46606 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263321AbTBETCx>; Wed, 5 Feb 2003 14:02:53 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: gcc 2.95 vs 3.21 performance
Date: Wed, 5 Feb 2003 19:09:56 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b1rni4$3dr$1@penguin.transmeta.com>
References: <1044385759.1861.46.camel@localhost.localdomain.suse.lists.linux.kernel> <b1pbt8$2ll$1@penguin.transmeta.com.suse.lists.linux.kernel> <p73znpbpuq3.fsf@oldwotan.suse.de> <3E4045D1.4010704@rogers.com>
X-Trace: palladium.transmeta.com 1044472339 8004 127.0.0.1 (5 Feb 2003 19:12:19 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 5 Feb 2003 19:12:19 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3E4045D1.4010704@rogers.com>,
Jeff Muizelaar  <muizelaar@rogers.com> wrote:
>
>There is also tcc (http://fabrice.bellard.free.fr/tcc/)
>It claims to support gcc-like inline assembler, appears to be much 
>smaller and faster than gcc. Plus it is GPL so the liscense isn't a 
>problem either.
>Though, I am not really sure of the quality of code generated or of how 
>mature it is.

tcc is interesting.  The code generation is pretty simplistic (read:
trivially horrible for most things), but it sure is fast and small.  And
judging by the changelog, Fabrice is trying to compile the kernel with
it. 

For a lot of problems, small-and-fast is good.  Hell, some of the things
I'd personally find interesting don't have any code generation part at
all (static analysis of annotated source-code - stanford checker on the
cheap).  And development doesn't always need good code generation (right
now some people use "gcc -O0" for that, because anything else hurts too
much.  Now, the code from tcc will probably look more like "-O-1", but
at least you can test out things _quickly_). 

		Linus
