Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272695AbRITV0j>; Thu, 20 Sep 2001 17:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274657AbRITV03>; Thu, 20 Sep 2001 17:26:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57736 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272695AbRITV0U>;
	Thu, 20 Sep 2001 17:26:20 -0400
Date: Thu, 20 Sep 2001 14:26:38 -0700 (PDT)
Message-Id: <20010920.142638.68040129.davem@redhat.com>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: flush_tlb_all in vmalloc_area_pages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010907165612.T11329@athlon.random>
In-Reply-To: <20010907165612.T11329@athlon.random>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Fri, 7 Sep 2001 16:56:12 +0200
   
   For the flush_cache_all for the virtually indexed caches should be the
   same issue in theory (at least the kmap logic only needs to flush the
   caches before the unmapping [not before the mapping] too)
   
   Am I missing something, Dave?

Anything that creates or takes away vmalloc() mappings needs to flush
the data cache if it is virtuall indexed.

I am always uncomfortable when I see people suggesting to remove
flushes from kernel virtual mapping setup/teardown.

Later,
David S. Miller
davem@redhat.com
