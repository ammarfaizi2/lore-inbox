Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136186AbREGPWp>; Mon, 7 May 2001 11:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136196AbREGPWf>; Mon, 7 May 2001 11:22:35 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:42155 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S136186AbREGPWT>; Mon, 7 May 2001 11:22:19 -0400
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Re: [PATCH] Thread core dumps for 2.4.4
Message-ID: <3AF6BD98.59F714DF@i.am>
Date: Mon, 7 May 2001 15:22:00 GMT
To: Szabolcs Szakacsits <szaka@f-secure.com>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.30.0105061833220.16238-100000@fs131-224.f-secure.com>
Mime-Version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1-RTL3.0 i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szabolcs Szakacsits wrote:
> 
> On Thu, 3 May 2001, Don Dugger wrote:
> 
> > The attached patch allows core dumps from thread processes in the 2.4.4
> > kernel.  This patch is the same as the last one I sent out except it fixes
> > the same bug that `kernel/fork.c' had with duplicate info in the `mm'
> > structure, plus this patch has had more extensive testing.
> 
> AFAIK Linux can't dump the threads to the same file as others but doing
> it to different files looks a bit scary. How the system behaves when you
> dump a heavy threaded app with a decent VM [i.e just think about a
> bloatware instead of malicious code]? How will the developer know which
> thread caused the fault? I've found dumping just the faulting thread is
> enough about 100% of the cases especially because [on SMP] others can
> run on and the dump is much more close to "garbage" then usuful info
> from a debug point of view.


Well I strongly dissagre with you - I need to know about all thread -
when I'm
developing my application and it crashes then sometimes thread which
has crashed is undetectable because of completely broken stack (C++
destructors)
 - but because I could inspect other threads I know which thread caused
segfault
(also I know in which state other thread have been - locked in mutex or
similar)

So if you think core dumps are garbage - use ulimit and you want ever
see them.
But for me I need all threads - and I like the behaviour of -ac kernel.

bye

kabi@i.am

