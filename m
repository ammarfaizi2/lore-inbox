Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316773AbSFKE2R>; Tue, 11 Jun 2002 00:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316774AbSFKE2Q>; Tue, 11 Jun 2002 00:28:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19905 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316773AbSFKE2P>;
	Tue, 11 Jun 2002 00:28:15 -0400
Date: Mon, 10 Jun 2002 21:24:08 -0700 (PDT)
Message-Id: <20020610.212408.08406500.davem@redhat.com>
To: roland@topspin.com
Cc: bhards@bigpond.net.au, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <52heka788s.fsf@topspin.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Dreier <roland@topspin.com>
   Date: 10 Jun 2002 21:24:35 -0700
   
   Something like the __dma_buffer macro I posted earlier makes it even
   simpler.  I'll make a patch that adds <asm/dma_buffer.h> so we have
   something concrete to discuss.

Why don't you just allocate the "struct something" from PCI pools?
If you don't have the pci_dev from that point, make some callback into
the host adapter driver so you can get at it.
