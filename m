Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSHXNjt>; Sat, 24 Aug 2002 09:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSHXNjs>; Sat, 24 Aug 2002 09:39:48 -0400
Received: from dsl-213-023-021-235.arcor-ip.net ([213.23.21.235]:25001 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316161AbSHXNjs>;
	Sat, 24 Aug 2002 09:39:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4 kernel series and the oom_killer and /proc/sys/vm/overcommit_memory
Date: Sat, 24 Aug 2002 15:42:18 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marc-Christian Petersen <m.c.p@gmx.net>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0208240045310.1857-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0208240045310.1857-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ibBD-0001XZ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 August 2002 05:46, Rik van Riel wrote:
> On Sat, 24 Aug 2002, Daniel Phillips wrote:
> > On Thursday 22 August 2002 19:32, Alan Cox wrote:
> > > 3 is a totally paranoid [overcommit policy] that will require everything in
> > > ram can be dumped to swap or paged back from backing store
> >
> > How do you handle the situation where you have a lot of shared memory in a
> > half-paged-out state, so that each shared page consumes both ram and swap?
> 
> That will work fine with 'totally paranoid' mode.  There is always
> enough swap space to hold _all_ pages, so everything will just
> continue to work.

Apparently, maximum available memory is limited to

  physical memory + (swap - physical memory) = just swap

in this case, and if swap is smaller than (the potentially swappable portion
of) physical memory you might as well just turn it off.

-- 
Daniel
