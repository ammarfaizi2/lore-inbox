Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270705AbRHSTKb>; Sun, 19 Aug 2001 15:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270708AbRHSTKW>; Sun, 19 Aug 2001 15:10:22 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:10245 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S270705AbRHSTKN>; Sun, 19 Aug 2001 15:10:13 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200108190825.KAA00983@kufel.dom>
Subject: Re: Swap size for a machine with 2GB of memory
To: kufel!thyrsus.com!esr@green.mif.pg.gda.pl
Date: Sun, 19 Aug 2001 10:25:36 +0200 (CEST)
Cc: kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl (Linux Kernel
	List),
        kufel!lanm-pc.com!gars@green.mif.pg.gda.pl
In-Reply-To: <20010819024233.A26916@thyrsus.com> from "Eric S. Raymond" at sie 19, 2001 02:42:33 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The Red Hat installation manual claims that the size of the swap partition
> should be twice the size of physical memory, but no more than 128MB.

This manual is outdated. 

1. You hahe 2GB limit for a single swap file/partition now. And you can use
   many of them.
2. it sjould be <= 2* RAM, i.e. 0 <= SWAP <= 2*RAM. More is inefficient.
3. except kernels 2.4.x, where x <= 7-ac8, where you should have SWAP=0 or
   SWAP > RAM. 2.4.7-ac9 & 2.4.8 have already this problem fixed.

> The screaming hotrod machine Gary Sandine and I built around the Tyan S2464
> has 2GB of physical memory.  Should I believe the above formula?  If not,
> is there a more correct one for calculating needed swap on machines with
> very large memory?

Correct and universal formula for swap size is as always:
   SWAP = MAX_RAM_you_ever_need - physical_RAM_you_have

However in 2.4 more eficient (and in 2.40-7 obligatory) is:
   SWAP = MAX_RAM_you_ever_need > physical_RAM_you_have
          ? MAX_RAM_you_ever_need
;)

Andrzej
