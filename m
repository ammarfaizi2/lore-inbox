Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318007AbSHaUKZ>; Sat, 31 Aug 2002 16:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSHaUKZ>; Sat, 31 Aug 2002 16:10:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1552 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318007AbSHaUKY>;
	Sat, 31 Aug 2002 16:10:24 -0400
Message-ID: <3D712682.66E2D3B2@zip.com.au>
Date: Sat, 31 Aug 2002 13:26:42 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Include LRU in page count
References: <3D644C70.6D100EA5@zip.com.au> <E17kunE-0003IO-00@starship> <20020831161448.12564.qmail@thales.mathematik.uni-ulm.de> <E17lEDR-0004Qq-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> Manfred suggested an approach to de-racing this race using
> atomic_dec_and_lock, which needs to be compared to the current approach.

Could simplify things, but not all architectures have an optimised
version.  So ia64, mips, parisc and s390 would end up taking
the lru lock on every page_cache_release.
