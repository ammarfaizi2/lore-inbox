Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317214AbSEXRoQ>; Fri, 24 May 2002 13:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317221AbSEXRoP>; Fri, 24 May 2002 13:44:15 -0400
Received: from imladris.infradead.org ([194.205.184.45]:11274 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317214AbSEXRoN>; Fri, 24 May 2002 13:44:13 -0400
Date: Fri, 24 May 2002 18:44:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@tech9.net>
Cc: Marcus Meissner <mm@ns.caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: Compiling 2.2.19 with -O3 flag
Message-ID: <20020524184402.A24780@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@tech9.net>, Marcus Meissner <mm@ns.caldera.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205241645.g4OGjbE30934@ns.caldera.de> <1022259244.2638.243.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 09:54:04AM -0700, Robert Love wrote:
> On Fri, 2002-05-24 at 09:45, Marcus Meissner wrote:
> 
> > > Heh, now that is interesting.
> > 
> > Not really, -Os implies -O2, cf gcc/toplev.c:
> 
> Well, according to Alan -Os outperforms -O2.  So either the code is
> smaller _and_ faster - and that is surely interesting - or the code is
> _not_ smaller and -Os is a misnomer.  Seems interesting to me.

-Os implies -O2 + additional size-reducing features:

[hch@sb hch]$ grep -r optimize_size /work/people/hch/gcc/gcc | wc -l
    250
[hch@sb hch]$

A bunch of matches are in ChangeLog and most are target-specific,
but I guess you got the point..

