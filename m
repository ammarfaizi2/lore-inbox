Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315860AbSEZIlo>; Sun, 26 May 2002 04:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315862AbSEZIln>; Sun, 26 May 2002 04:41:43 -0400
Received: from dsl-213-023-040-043.arcor-ip.net ([213.23.40.43]:22999 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315860AbSEZIln>;
	Sun, 26 May 2002 04:41:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Stephen C. Tweedie" <sct@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Thoughts on using fs/jbd from drivers/md
Date: Sun, 26 May 2002 10:41:22 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15587.18828.934431.941516@notabene.cse.unsw.edu.au> <20020516161749.D2410@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Btad-0003sq-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 May 2002 17:17, Stephen C. Tweedie wrote:
> Most applications are not all that bound by write latency.

But some are.  Transaction processing applications, where each transaction 
has to be safely on disk before it can be acknowledged, care about write 
latency a lot, since it translates more or less directly into throughput.

> They
> typically care more about read latency and/or write throughput, and
> any fancy games which try to minimise write latency at the expense of
> correctness feel wrong to me.

I doubt you'll have trouble convincing anyone that correctness is not 
negotiable.

-- 
Daniel
