Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317563AbSFIFdd>; Sun, 9 Jun 2002 01:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317564AbSFIFdc>; Sun, 9 Jun 2002 01:33:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39596 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317563AbSFIFd3>;
	Sun, 9 Jun 2002 01:33:29 -0400
Date: Sat, 08 Jun 2002 22:29:42 -0700 (PDT)
Message-Id: <20020608.222942.111546622.davem@redhat.com>
To: acahalan@cs.uml.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206090130.g591UVR434040@saturn.cs.uml.edu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
   Date: Sat, 8 Jun 2002 21:30:31 -0400 (EDT)
   
   On a non-SMP system, would it be OK to map all the memory
   without memory coherency enabled? You seem to be implying that
   one only needs to implement some mechanism in pci_map_single()
   to handle flushing cache lines (write back, then invalidate).
   
   This would be useful for Macs.
   
It's just avoiding flushing by effecting flushing the cache after
every load/store the cpu does, so of course it would work.

It would be slow as hell, but it would work.
