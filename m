Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271155AbRHOLsX>; Wed, 15 Aug 2001 07:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271154AbRHOLsN>; Wed, 15 Aug 2001 07:48:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30080 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271155AbRHOLr5>;
	Wed, 15 Aug 2001 07:47:57 -0400
Date: Wed, 15 Aug 2001 04:47:57 -0700 (PDT)
Message-Id: <20010815.044757.112624116.davem@redhat.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010815131335.H545@suse.de>
In-Reply-To: <20010815112621.F545@suse.de>
	<20010815.032218.55508716.davem@redhat.com>
	<20010815131335.H545@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Wed, 15 Aug 2001 13:13:35 +0200

   Looks fine to me, exactly the interface I've used/wanted. But you want
   to add the extra page/offset to the existing scatterlist, and not scrap
   that one completely?

The idea is that address/alt_address disappear sometime in 2.5.
Something like this right?

BTW, on x86 we can ifdef the dma64_address to u32 or u64 based
upon CONFIG_HIGHMEM if we wish.

Later,
David S. Miller
davem@redhat.com
