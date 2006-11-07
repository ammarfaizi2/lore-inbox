Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754117AbWKGIco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbWKGIco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 03:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754119AbWKGIco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 03:32:44 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:9917 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1754118AbWKGIcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 03:32:43 -0500
Date: Tue, 7 Nov 2006 11:32:30 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: zhou drangon <drangon.mail@gmail.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061107083229.GA2864@2ka.mipt.ru>
References: <20061101160551.GA2598@elf.ucw.cz> <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz> <20061101185745.GA12440@2ka.mipt.ru> <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com> <aaf959cb0611011829k36deda6ahe61bcb9bf8e612e1@mail.gmail.com> <aaf959cb0611011830j1ca3e469tc4a6af3a2a010fa@mail.gmail.com> <4549A261.9010007@cosmosbay.com> <20061102080122.GA1302@2ka.mipt.ru> <454FA671.7000204@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <454FA671.7000204@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 07 Nov 2006 11:32:32 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 10:17:37PM +0100, Eric Dumazet (dada1@cosmosbay.com) wrote:
> AF_INET
> # ./epoll_bench -n 2000 -i
> 2000 handles setup
> 69210 evts/sec 2.97224 samples per call
> 59436 evts/sec 12876 ctxt/sec 5.48675 samples per call
> 60722 evts/sec 12093 ctxt/sec 8.03185 samples per call
> 60583 evts/sec 14582 ctxt/sec 10.5644 samples per call
> 58192 evts/sec 12066 ctxt/sec 12.999 samples per call
> 54291 evts/sec 10613 ctxt/sec 15.2398 samples per call
> 47978 evts/sec 10942 ctxt/sec 17.2222 samples per call
> 59009 evts/sec 13692 ctxt/sec 19.6426 samples per call
> 58248 evts/sec 15099 ctxt/sec 22.0306 samples per call
> 58708 evts/sec 15118 ctxt/sec 24.4497 samples per call
> 58613 evts/sec 14608 ctxt/sec 26.816 samples per call
> 58490 evts/sec 13593 ctxt/sec 29.1708 samples per call
> 59108 evts/sec 15078 ctxt/sec 31.5557 samples per call
> 59636 evts/sec 15053 ctxt/sec 33.9292 samples per call
> 59355 evts/sec 15531 ctxt/sec 36.2914 samples per call
> Avg: 58771 evts/sec
> 
> The last sample shows that epoll overhead is very small indeed, since 
> disabling it doesnt boost AF_INET perf at all.
> AF_INET + no epoll
> # ./epoll_bench -n 2000 -i -f
> 2000 handles setup
> 79939 evts/sec
> 78468 evts/sec 9989 ctxt/sec
> 73153 evts/sec 10207 ctxt/sec
> 73668 evts/sec 10163 ctxt/sec
> 73667 evts/sec 20084 ctxt/sec
> 74106 evts/sec 10068 ctxt/sec
> 73442 evts/sec 10119 ctxt/sec
> 74220 evts/sec 10122 ctxt/sec
> 74367 evts/sec 10097 ctxt/sec
> 64402 evts/sec 47873 ctxt/sec
> 53555 evts/sec 58733 ctxt/sec
> 46000 evts/sec 48984 ctxt/sec
> 67052 evts/sec 21006 ctxt/sec
> 68460 evts/sec 12344 ctxt/sec
> 67629 evts/sec 10655 ctxt/sec
> Avg: 69475 evts/sec

Without epoll number of events/sec is about 18% more - 58k vs 69k.

-- 
	Evgeniy Polyakov
