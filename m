Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272717AbRIPToN>; Sun, 16 Sep 2001 15:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272723AbRIPToD>; Sun, 16 Sep 2001 15:44:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48133 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272717AbRIPTnz>; Sun, 16 Sep 2001 15:43:55 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: broken VM in 2.4.10-pre9
Date: Sun, 16 Sep 2001 19:43:25 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9o2vct$889$1@penguin.transmeta.com>
In-Reply-To: <1000653836.2440.0.camel@gromit.house> <Pine.LNX.4.33L.0109161330000.9536-100000@imladris.rielhome.conectiva>
X-Trace: palladium.transmeta.com 1000669453 4793 127.0.0.1 (16 Sep 2001 19:44:13 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 16 Sep 2001 19:44:13 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33L.0109161330000.9536-100000@imladris.rielhome.conectiva>,
Rik van Riel  <riel@conectiva.com.br> wrote:
>On 16 Sep 2001, Michael Rothwell wrote:
>
>> Is there a way to tell the VM to prune its cache? Or a way to limit
>> the amount of cache it uses?
>
>Not yet, I'll make a quick hack for this when I get back next
>week. It's pretty obvious now that the 2.4 kernel cannot get
>enough information to select the right pages to evict from
>memory.

Don't be stupid.

The desribed behaviour has nothing to do with limiting the cache or
anything else "cannot get enough information", except for the fact that
the kernel obviously cannot know what will happen in the future.

The kernel _correctly_ swapped out tons of pages that weren't touched in
a long long time. That's what you want to happen - the fact that they
then all became active on logout is sad.

The fact that the "use-once" logic didn't kick in is the problem. It's
hard to tell _why_ it didn't kick in, possibly because the MP3 player
read small chunks of the pages (touching them multiple times). 

THAT is worth looking into. But blathering about "reverse mappings will
help this" is just incredibly stupid. You seem to think that they are a
panacea for all problems, ranging from MP3 playback to world peace and
re-building the WTC.

		Linus
