Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289047AbSA3KIr>; Wed, 30 Jan 2002 05:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289050AbSA3KIl>; Wed, 30 Jan 2002 05:08:41 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:22202 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289047AbSA3KIW>; Wed, 30 Jan 2002 05:08:22 -0500
Message-Id: <200201301007.g0UA7iNm002192@tigger.cs.uni-dortmund.de>
To: Josh MacDonald <jmacd@CS.Berkeley.EDU>
cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under high memory pressure 
In-Reply-To: Message from Josh MacDonald <jmacd@CS.Berkeley.EDU> 
   of "Tue, 29 Jan 2002 09:28:58 PST." <20020129092858.D8740@helen.CS.Berkeley.EDU> 
Date: Wed, 30 Jan 2002 11:07:44 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh MacDonald <jmacd@CS.Berkeley.EDU> said:

[...]

> We're not talking about actively referenced entries, we're talking about
> entries on the d_lru list with zero references.  Relocating those objects
> should not require any more locking than currently required to remove and
> re-insert the dcache entry.  Right?

If they are unreferenced, they can be dropped without much cost. The
problem is what to do if you have 40 pages, each 1/10 filled with data in
active use.
-- 
Horst von Brand			     http://counter.li.org # 22616
