Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262600AbREVJsg>; Tue, 22 May 2001 05:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbREVJsP>; Tue, 22 May 2001 05:48:15 -0400
Received: from atlante.atlas-iap.es ([194.224.1.3]:29454 "EHLO
	atlante.atlas-iap.es") by vger.kernel.org with ESMTP
	id <S262600AbREVJsH>; Tue, 22 May 2001 05:48:07 -0400
From: "Ricardo Galli" <gallir@uib.es>
To: "Hans Reiser" <reiser@namesys.com>, <linux-kernel@vger.kernel.org>,
        <timothy@monkey.org>,
        "Guillem Cantallops Ramis" <guillem@cantallops.net>,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>,
        <reiserfs-dev@namesys.com>
Subject: RE: [reiserfs-dev] Re: New XFS, ReiserFS and Ext2 benchmarks
Date: Tue, 22 May 2001 11:48:39 +0200
Message-ID: <LOEGIBFACGNBNCDJMJMOAEAGCJAA.gallir@uib.es>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <3B09FF25.979EF793@namesys.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My apologies, I meant that the make is probably compiler bound (I said CPU
> bound) not FS bound.

We undertood ;-)

> > cp -ar, and I would like Yura to try to reproduce the cp -ar as
> >  it seems too
> > good to be true.
> We find that one must use cp and similar utilities (not

The cp -a figures are somehow interesting, I had to repeat it for evey file
system because the cache has to be populated before copying, to avoid the
influence of the file system where the kernel is copied from. I did it by
doing several cps before mesurements.

Despite my "efforts", variances were much higher en XFS than in ReiserFS and
Ext2. The ReiserFS individual times were closer to the average than the
other.

Why? have no idea, I didn't do any analysis of the samples because I am not
an expert in Statistics.


> compilers) to become FS
> bound when using a Linux FS (unlike the older Unixes for which
> compiles were
> considered excellent benchmarks).

I was equally suprised, not only due to the wall-clock time but also to the
CPU. So, I think the cache is the major player when compiling a kernel that
was _just_ copied from another file system (still in buffer/cache).

> > Thanks for investing the time into this Ricardo.

It's just for fun....

--ricardo

