Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313293AbSDOVV2>; Mon, 15 Apr 2002 17:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313297AbSDOVV1>; Mon, 15 Apr 2002 17:21:27 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:5604 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313293AbSDOVVZ>;
	Mon, 15 Apr 2002 17:21:25 -0400
Date: Mon, 15 Apr 2002 15:19:53 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
Message-ID: <1774420000.1018909193@flay>
In-Reply-To: <Pine.LNX.4.44L.0204151755491.16531-100000@duckman.distro.conectiva>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Because code that doesn't care about pgdats shouldn't have to
> learn about them, IMHO.  I used to have the doubly nested for
> loop in -rmap, but William Irwin came up with a way to make
> it a singly nested loop for code that only cares about zones.

Can't you just have the simple single and double loops in mmzone.h,
seperated by a #ifdef CONFIG_DISCONTIGMEM?

I like the general abstraction idea of where you're going though.
Is there a for_each_node already? Can't see one:

#define for_each_node(nid) \
	for (nid = 0; nid < numnodes; nid++)

would allow us to change the assumption that nodes are numbered
contiguously, starting from 0, more easily later on ... ?

M.

