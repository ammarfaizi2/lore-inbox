Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317342AbSHAVnz>; Thu, 1 Aug 2002 17:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSHAVnz>; Thu, 1 Aug 2002 17:43:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22798 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317342AbSHAVny>; Thu, 1 Aug 2002 17:43:54 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] solved APM bug with -rc5
Date: Thu, 1 Aug 2002 21:47:18 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aica96$1lt$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva> <20020801203520.GA244@pcw.home.local> <1028240183.15022.99.camel@irongate.swansea.linux.org.uk> <20020801210745.GA20387@alpha.home.local>
X-Trace: palladium.transmeta.com 1028238425 4612 127.0.0.1 (1 Aug 2002 21:47:05 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 1 Aug 2002 21:47:05 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020801210745.GA20387@alpha.home.local>,
Willy Tarreau  <willy@w.ods.org> wrote:
>On Thu, Aug 01, 2002 at 11:16:23PM +0100, Alan Cox wrote:
>> On Thu, 2002-08-01 at 21:35, Willy TARREAU wrote:
>> > +	while (cpu_number_map(smp_processor_id()) != 0) {
>> > +		schedule();
>> > +	}
> 
>> What guarantees that loop will ever exit ?
>
>none, as in the already existing other implementation. But at least, I'd
>prefer an infinite loop instead of some random code being executed without
>noticing it.
>
>Do you know a better way of doing that ?

It should set its CPU affinity to be cpu0. I don't know how well that
works in 2.4.x, though. Ask Ingo..

		Linus
