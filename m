Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSHGFPq>; Wed, 7 Aug 2002 01:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317037AbSHGFPq>; Wed, 7 Aug 2002 01:15:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:50351 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317035AbSHGFPq>;
	Wed, 7 Aug 2002 01:15:46 -0400
Date: Tue, 06 Aug 2002 22:16:04 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>,
       William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org, riel@surriel.com
Subject: Re: fix CONFIG_HIGHPTE
Message-ID: <1296174189.1028672155@[10.10.2.3]>
In-Reply-To: <3D506D43.890EA215@zip.com.au>
References: <3D506D43.890EA215@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And we'll need that, to reduce load on KM_PTECHAIN.  Because
> there's no point in pte_highmem without also having pte_chain_highmem,
> yes?

I'm not sure I agree that there's no point. If we shove half the 
overhead into highmem (well, maybe 1/3 depending if on your PTE size), 
we can fit a workload double the size. Not to be sniffed at. 50% of 
the benefit at 5% of the cost.

No, it doesn't completely solve the problem, but it's another hammer
to give it a good sturdy whack over the head with. 

M.

