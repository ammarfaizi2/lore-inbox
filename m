Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274678AbRITW3V>; Thu, 20 Sep 2001 18:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274679AbRITW3L>; Thu, 20 Sep 2001 18:29:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38537 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274678AbRITW25>;
	Thu, 20 Sep 2001 18:28:57 -0400
Date: Thu, 20 Sep 2001 15:29:19 -0700 (PDT)
Message-Id: <20010920.152919.35356833.davem@redhat.com>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: flush_tlb_all in vmalloc_area_pages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010921002547.G729@athlon.random>
In-Reply-To: <20010907165612.T11329@athlon.random>
	<20010920.142638.68040129.davem@redhat.com>
	<20010921002547.G729@athlon.random>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Fri, 21 Sep 2001 00:25:47 +0200

   The only question I'd like to get a answer is "what is actually the
   data that can be virtually indexed) in the vmalloc range at the time we
   run vmalloc?" Where does it cames from?
   
>From the the direct PAGE_OFFSET mappings.

   Furthmore I recall on sparc you cannot flush the cache if you don't have
   a mapping in place,

This is only true of Hypersparc sparc32 chips for page based flushes,
not whole flushes.

   If anybody is using at boot time the vmalloc range for whatever purpuse
   it should be its own business to flush the cache before dropping the
   mappings from there.
   
That isn't the problem, it's dirty cache lines left over from the
usual access addresses for physical memory (ie. via PAGE_OFFSET linear
mappings).

Please, I would heavily suggest leaving this area until 2.5.x there
are already a traumatic amount of changes going on in 2.4.x

Later,
David S. Miller
davem@redhat.com

   
