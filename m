Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318202AbSIBBfA>; Sun, 1 Sep 2002 21:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318203AbSIBBfA>; Sun, 1 Sep 2002 21:35:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63505 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318202AbSIBBe7>;
	Sun, 1 Sep 2002 21:34:59 -0400
Message-ID: <3D72C3F8.A0E50BCB@zip.com.au>
Date: Sun, 01 Sep 2002 18:50:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Include LRU in page count
References: <3D644C70.6D100EA5@zip.com.au> <E17leDK-0004dA-00@starship> <3D72AE2C.F1806BDD@zip.com.au> <E17lf6Y-0004dV-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ...
> If lru_cache_add is costly then we can kill both the lock contention and the
> cacheline pingponging by feeding the new pages into a local list, then
> grafting the whole list onto the inactive list when we start to scan.

2.5.33 does this.
