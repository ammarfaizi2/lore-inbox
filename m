Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271519AbRHPIMo>; Thu, 16 Aug 2001 04:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271520AbRHPIMd>; Thu, 16 Aug 2001 04:12:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49544 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271519AbRHPIMV>;
	Thu, 16 Aug 2001 04:12:21 -0400
Date: Thu, 16 Aug 2001 01:12:13 -0700 (PDT)
Message-Id: <20010816.011213.102576998.davem@redhat.com>
To: groudier@free.fr
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010815205954.A1159-100000@gerard>
In-Reply-To: <20010815.032218.55508716.davem@redhat.com>
	<20010815205954.A1159-100000@gerard>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=big5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id SAA14930

   From: Gérard Roudier <groudier@free.fr>
   Date: Wed, 15 Aug 2001 21:20:17 +0200 (CEST)

   The current solution consists in tampering the dma_mask in the pci_dev
   structure prior to allocating DMAable memory. Not really clean...
   Some interface that would allow to provide some masks as argument would be
   cleaner, in my opinion. Btw, the pci_set_* interface does not seem cleaner
   to me than hacking the corresponding field in the pcidev structure directly.

pci_alloc_consistent will ONLY give you 32-bit DMA memory.

This will be true both before and after my changes.  Does the
IA64 gross hack behave differently?

Later,
David S. Miller
davem@redhat.com
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
