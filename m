Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132016AbRCYO5g>; Sun, 25 Mar 2001 09:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132015AbRCYO50>; Sun, 25 Mar 2001 09:57:26 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:14863 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S132012AbRCYO5T>; Sun, 25 Mar 2001 09:57:19 -0500
Date: Sun, 25 Mar 2001 16:56:35 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Jonathan Morton <chromi@cyberspace.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <l0313030fb6e15a6513ac@[192.168.239.101]>
Message-ID: <Pine.LNX.4.21.0103251638140.1162-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Jonathan Morton wrote:

> >The main point is letting malloc fail when the memory cannot be
> >guaranteed.
> 
> If I read various things correctly, malloc() is supposed to fail as you
> would expect if /proc/sys/vm/overcommit_memory is 0.  This is the case on
> my RH 6.2 box, dunno about yours.  I can write a simple test program which
> simply allocates tons of memory if you like...
> 
> ...and I did.  It filled up my physical and swap memory, and got killed by
> the OOM handler before malloc() failed, even though overcommit_memory was
> set to 0.
> 
> *****BAD!*****

Please search list archives, there are plenty of threads about
overcommitment.

Have a look at the sources, that part is easy to read and you'll
realize that /proc/sys/vm/overcommit_memory does not really enable
/ disable memory overcommitment: its closer to a sanity check to
disallow absurdly sized requests, IIRC.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

