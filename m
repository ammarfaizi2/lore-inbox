Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269838AbRHIPS0>; Thu, 9 Aug 2001 11:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269835AbRHIPSQ>; Thu, 9 Aug 2001 11:18:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7685 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269834AbRHIPSK>; Thu, 9 Aug 2001 11:18:10 -0400
Subject: Re: Swapping for diskless nodes
To: dws@dirksteinberg.de (Dirk W. Steinberg)
Date: Thu, 9 Aug 2001 16:19:49 +0100 (BST)
Cc: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <no.id> from "Dirk W. Steinberg" at Aug 09, 2001 02:12:00 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UrbB-0007T9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the memory of a fast server could have much less latency that writing 
> that page out to a local old, slow IDE disk. Clusters could even have
> special high-bandwidth, low latency networks that could be used for
> remote paging.
> 
> In a perfect world, all nodes in a cluster would be able to dynamically 
> share a pool of "cluster swap" space, so any locally available swap that
> is not used could be utilized by other nodes in the cluster.

That I think is a 2.5 problem. One thing that has been talked about several
times now is removing all the swap special case crap from the mm and making
swap a file system. That removes special cases and means anyone can write
or use custom, or multiple swap filesystems, in theory including things like
swap over a shared GFS pool

But its not for 2.4, no way

Alan
