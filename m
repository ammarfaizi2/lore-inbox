Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135559AbRDXMJb>; Tue, 24 Apr 2001 08:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135569AbRDXMJW>; Tue, 24 Apr 2001 08:09:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41739 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135559AbRDXMJH>; Tue, 24 Apr 2001 08:09:07 -0400
Subject: Re: [PATCH] Move __GFP_IO check in shrink_icache_memory to prune_icache()
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Tue, 24 Apr 2001 13:09:37 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (lkml),
        viro@math.psu.edu (Alexander Viro)
In-Reply-To: <Pine.LNX.4.21.0104232222030.1512-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Apr 23, 2001 10:27:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s1dU-0001v6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The following patch moves the __GFP_IO check down to prune_icache(),
> > allowing !__GFP_IO allocations to free clean unused inodes.
> 
> Forget about this. 
> 
> We may have to write quota information back to disk while freeing the
> inode and then we are fucked. 

Also you are looking at the none -ac quota code which is broken anyway 8)
The same problem seems to hold true with your patch and the current quota
code however.
