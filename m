Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316774AbSFKEm6>; Tue, 11 Jun 2002 00:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSFKEm5>; Tue, 11 Jun 2002 00:42:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29377 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316774AbSFKEm5>;
	Tue, 11 Jun 2002 00:42:57 -0400
Date: Mon, 10 Jun 2002 21:38:51 -0700 (PDT)
Message-Id: <20020610.213851.129507691.davem@redhat.com>
To: roland@topspin.com
Cc: wjhun@ayrnetworks.com, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <52d6uy77k0.fsf@topspin.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Dreier <roland@topspin.com>
   Date: 10 Jun 2002 21:39:27 -0700

       David> How about allocating struct something using pci_pool?
   
   The problem is the driver can't safely touch field1 or field2 near the
   DMA (it might pull the cache line back in too soon, or dirty the cache
   line and have it written back on top of DMA'ed data)

Oh duh, I see, then go to making the thing a pointer to the
dma area.
