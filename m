Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSFMJn3>; Thu, 13 Jun 2002 05:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSFMJn2>; Thu, 13 Jun 2002 05:43:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38107 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314546AbSFMJnX>;
	Thu, 13 Jun 2002 05:43:23 -0400
Date: Thu, 13 Jun 2002 02:38:56 -0700 (PDT)
Message-Id: <20020613.023856.87216149.davem@redhat.com>
To: david-b@pacbell.net
Cc: roland@topspin.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D0829ED.1020809@pacbell.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Brownell <david-b@pacbell.net>
   Date: Wed, 12 Jun 2002 22:13:17 -0700

   David S. Miller wrote:
   > We have two problems we want to solve, the DMA alignment stuff and
   > using consistent memory for these small buffers.  Therefore moving to
   > consistent memory (by whatever mechanism the USB desires to implement
   > this) is the way to go.
   
   Right, the alignment stuff is a correctness issue, the consistent
   memory issue is a performance concern.  I like to think that 2.5
   will have a lot less correctness issues in the USB stack, so it
   can start to pay more attention to performance concerns.

I want to reemphasize that by going to consistent memory we solve
both problems, in particular the alignment stuff becomes a non-issue.
