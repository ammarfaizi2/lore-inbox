Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277057AbRJKX1Y>; Thu, 11 Oct 2001 19:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277064AbRJKX1O>; Thu, 11 Oct 2001 19:27:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11393 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277059AbRJKX06>;
	Thu, 11 Oct 2001 19:26:58 -0400
Date: Thu, 11 Oct 2001 16:27:09 -0700 (PDT)
Message-Id: <20011011.162709.39156842.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: chris@chrullrich.de, viro@math.psu.edu, torvalds@transmeta.com,
        v.sweeney@dexterus.com, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems in 2.4.11
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.96.1011011180912.5934I-100000@mandrakesoft.mandrakesoft.com>
In-Reply-To: <20011012010310.A1255@christian.chrullrich.de>
	<Pine.LNX.3.96.1011011180912.5934I-100000@mandrakesoft.mandrakesoft.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Thu, 11 Oct 2001 18:10:43 -0500 (CDT)

   > Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
   
   To tangent, do we really need a mount cache that big, even on a highmem
   machine?
   
Yes, in fact on machines with 16GB or so of ram we perform poorly due
to the 4MB size restriction from GFP() allocations.  Anton Blanchard
hit this on large PPC64 SMP machines already.

On a 16GB or 32GB ram machine, the hash chains go to 20 deep even on
simple benchmarks and all performance goes to the toilet.

Franks a lot,
David S. Miller
davem@redhat.com
