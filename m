Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316827AbSFJK2B>; Mon, 10 Jun 2002 06:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316828AbSFJK2A>; Mon, 10 Jun 2002 06:28:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30904 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316827AbSFJK17>;
	Mon, 10 Jun 2002 06:27:59 -0400
Date: Mon, 10 Jun 2002 03:24:01 -0700 (PDT)
Message-Id: <20020610.032401.21500297.davem@redhat.com>
To: oliver@neukum.name
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206101200.14109.oliver@neukum.name>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oliver Neukum <oliver@neukum.name>
   Date: Mon, 10 Jun 2002 12:00:14 +0200

   > You flush either before/after depending upon whether the cpu caches
   > are writeback in nature or not, and the cpu is not allowed to touch
   > those addresses while the device is doing the DMA.
   
   So we need some kind of cache_aligned macro in our USB data
   structures if they contain a buffer. Which macro would we have to use ?

For now use SMP_CACHE_BYTES I guess.
