Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSGQSYH>; Wed, 17 Jul 2002 14:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSGQSXE>; Wed, 17 Jul 2002 14:23:04 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:39869 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316465AbSGQSW4>;
	Wed, 17 Jul 2002 14:22:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Robert Love <rml@tech9.net>
Subject: Re: [patch 1/13] minimal rmap
Date: Wed, 17 Jul 2002 20:26:39 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <3D3500AA.131CE2EB@zip.com.au> <E17Ut3V-0004OY-00@starship> <1026929477.1085.19.camel@sinai>
In-Reply-To: <1026929477.1085.19.camel@sinai>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17UtVY-0004On-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 20:11, Robert Love wrote:
> On Wed, 2002-07-17 at 10:57, Daniel Phillips wrote:
> > On Wednesday 17 July 2002 07:29, Andrew Morton wrote:
> > > 11: The nightly updatedb run is still evicting everything.
> > 
> > That is not a problem with rmap per se, it's a result of not properly 
> > handling streaming IO.  I don't think you want to get bogged down in this 
> > detail at the moment, it will only distract from the real issues.  My 
> > recommendation is to just pretend for the time being that this is correct 
> > behaviour.
> 
> A good argument for an O_STREAM... various semantics we can modify for
> it.

It can be fixed in kernel too, it's just that the effort would be poorly
spent at this point.  This is in roughly the same category as process-level
paging policy: yes, if it's implemented properly the VM appears to work
better and users will post nice things on lkml about it, but it's a red
herring.  Such adjustments are better left for later in the cycle, when
the smoke has cleared from the basic merge, and benchmarks should focus
narrowly on behaviour that is actually affected by the change in scanning
strategy.

-- 
Daniel
