Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319579AbSIHI2P>; Sun, 8 Sep 2002 04:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319583AbSIHI2P>; Sun, 8 Sep 2002 04:28:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42644 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319579AbSIHI2P>;
	Sun, 8 Sep 2002 04:28:15 -0400
Date: Sun, 08 Sep 2002 01:25:26 -0700 (PDT)
Message-Id: <20020908.012526.48196975.davem@redhat.com>
To: wli@holomorphy.com
Cc: akpm@digeo.com, ciarrocchi@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020908082821.GK888@holomorphy.com>
References: <3D7B0177.6A35FE9B@digeo.com>
	<20020908.003700.07120871.davem@redhat.com>
	<20020908082821.GK888@holomorphy.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Lee Irwin III <wli@holomorphy.com>
   Date: Sun, 8 Sep 2002 01:28:21 -0700
   
   But if this were truly the issue, the allocation and deallocation
   overhead for pagetables should show up as additional pressure
   against zone->lock.

The big gain is not only that allocation/free is cheap, also
page table entries tend to hit in cpu cache for even freshly
allocated page tables.

I think that is the bit that would show up in the mmap lmbench
test.

