Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266921AbRGTLeZ>; Fri, 20 Jul 2001 07:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266930AbRGTLeO>; Fri, 20 Jul 2001 07:34:14 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:53257 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266921AbRGTLeF>; Fri, 20 Jul 2001 07:34:05 -0400
Message-ID: <3B581670.548B3693@namesys.com>
Date: Fri, 20 Jul 2001 15:30:56 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Chris Mason <mason@suse.com>, Andi Kleen <ak@suse.de>,
        Craig Soules <soules@happyplace.pdl.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <177360000.995464676@tiny>
		<shsg0btnobs.fsf@charged.uio.no>
		<3B5720B2.A4D97ECF@namesys.com> <15191.61681.847920.761502@charged.uio.no>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Trond Myklebust wrote:
> 
> >>>>> " " == Hans Reiser <reiser@namesys.com> writes:
> 
>      > The current code does rely on hidden knowledge of the filesytem
>      > on the server, and refuses to operate with any FS that does not
>      > describe a position in a directory as an offset or hash that
>      > fits into 32 or 64 bits.
> 
> I'm not saying that ReiserFS is wrong to question the correctness of
> this. I'm just saying that NFSv2 and v3 are fixed protocols, and that
> it's too late to do anything about them. I read Chris mail as a
> suggestion of creating yet another NQNFS, and this would IMHO be a
> mistake. Better to concentrate on NFSv4 which is meant to be
> extendible.
> 
>      > But be calm, I am not planning on fixing this myself anytime in
>      > the next year, we have an ugly and hideous hack deployed in
>      > ReiserFS that works, for now I am just saying the folks who
>      > designed NFS did a bad job and resolutely continue doing a bad
>      > job, and if someone wanted to fix it, they could fix cookies to
>      > use filenames instead of byte offsets for those filesytems able
>      > to better use filenames than byte offsets to describe a
>      > position within a directory, and for those clients and servers
>      > who are both smart enough to understand filenames instead of
>      > cookies (able to understand the cookie monster protocol).
> 
> This is something which I believe you raised in the NFSv4 group, and
> which could indeed be a candidate for an NFSv4 extension. After all,
> this is in essence a recognition of the method most NFS clients
> implement for recovering from an EBADCOOKIE error. Why was the idea
> dropped?

Lack of desire to do anything, near as I could tell.

> 
> (Note: As I said, under Linux we're currently hampered when
> considering the above alternatives by the fact that glibc requires the
> ability to lseek() on directories. This is a bug that they could
> easily fix, and it affects not only your suggestion, but also all the
> other suggestions in which one implements non-permanent cookies)

I would be quite happy if you (or anyone) could fix it, sometime in the next 3 years.  

> 
> Cheers,
>    Trond
