Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317743AbSIOEQE>; Sun, 15 Sep 2002 00:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317751AbSIOEQE>; Sun, 15 Sep 2002 00:16:04 -0400
Received: from dsl-213-023-043-058.arcor-ip.net ([213.23.43.58]:26016 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317743AbSIOEQD>;
	Sun, 15 Sep 2002 00:16:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.34-mm2
Date: Sun, 15 Sep 2002 06:23:51 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D803434.F2A58357@digeo.com> <E17qQMq-0001JV-00@starship> <3D8408A9.7B34483D@digeo.com>
In-Reply-To: <3D8408A9.7B34483D@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qQwq-0001qT-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 September 2002 06:12, Andrew Morton wrote:
> Daniel Phillips wrote:
> >  I heard you
> > mention, on the one hand, huge speedups on some load (dbench I think)
> > but your in-patch comments mention slowdown by 1.7X on kernel
> > compile.
> 
> You misread.  Relative times for running `make -j6 bzImage' with mem=512m:
> 
> Unloaded system:		                     1.0
> 2.5.34-mm4, while running 4 x `dbench 100'           1.7
> Any other kernel while running 4 x `dbench 100'      basically infinity

Oh good :-)

We can make the rescanning go away in time, with more lru lists, but
that sure looks like the low hanging fruit.

-- 
Daniel
