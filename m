Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSGJILX>; Wed, 10 Jul 2002 04:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316896AbSGJILW>; Wed, 10 Jul 2002 04:11:22 -0400
Received: from [62.70.58.70] ([62.70.58.70]:7303 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316677AbSGJILW> convert rfc822-to-8bit;
	Wed, 10 Jul 2002 04:11:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [2.4 BUFFERING BUG] (was [BUG] 2.4 VM sucks. Again)
Date: Wed, 10 Jul 2002 10:14:05 +0200
User-Agent: KMail/1.4.1
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
References: <200205241004.g4OA4Ul28364@mail.pronto.tv> <200207100950.21084.roy@karlsbakk.net> <3D2BEAD9.6D7E62C1@zip.com.au>
In-Reply-To: <3D2BEAD9.6D7E62C1@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207101014.05059.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 July 2002 10:05, Andrew Morton wrote:
> Roy Sigurd Karlsbakk wrote:
> > hi
> >
> > I've been using the patch below from Andrew for some weeks now, sometimes
> > under quite heavy load, and find it quite stable.
>
> Wish we knew why.  I've tried many times to reproduce the problem
> which you're seeing.  With just two gigs of memory, buffer_heads
> really cannot explain anything.  It's weird.

well - firstly, I'm using _1_ gig of memory - highmem (= 900 megs something)
secondly - I have reproduced it on two different installations, although on 
the same hardware - standard PC with SiS MB and an extra promise controller, 
RAID-0 on 4 drives and chunksize 1MB. Given a 30-50 processes each reading a 
4gig file and sending it over HTTP, everything works fine _if_ and only _if_ 
the client reads at high speed. If, however, the client reads at normal 
streaming speed (4,3Mbps), buffers go bOOM.

> We discussed this in Ottawa - I guess Andrea will add the toss-the-buffers
> code on the read side (basically the filemap.c stuff).  That may
> be sufficient, but without an understanding of what is going on,
> it is hard to predict.

Is there _any_ more data I can give, or any more testing I can do, then I'll 
do my very best to help

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

