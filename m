Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317287AbSHBB2O>; Thu, 1 Aug 2002 21:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSHBB2O>; Thu, 1 Aug 2002 21:28:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21151 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317287AbSHBB2N>;
	Thu, 1 Aug 2002 21:28:13 -0400
Date: Thu, 01 Aug 2002 18:19:44 -0700 (PDT)
Message-Id: <20020801.181944.09310618.davem@redhat.com>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rohit.seth@intel.com,
       sunil.saxena@intel.com, asit.k.mallick@intel.com
Subject: Re: large page patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D49DFD0.FE0DBC1D@zip.com.au>
References: <3D49D45A.D68CCFB4@zip.com.au>
	<20020801.174301.123634127.davem@redhat.com>
	<3D49DFD0.FE0DBC1D@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Thu, 01 Aug 2002 18:26:40 -0700

   "David S. Miller" wrote:
   > This is probably done to increase the likelyhood that 4MB page orders
   > are available.  If we collapse 4MB pages deeper, they are less likely
   > to be broken up because smaller orders would be selected first.
   
   This is leakage from ia64, which supports up to 256k pages.

Ummm, 4MB > 256K and even with a 4K PAGE_SIZE MAX_ORDER coalesces
up to 4MB already :-)
   
   Apparently a page-table based representation could not be used by PPC.
   
The page-table is just an abstraction, there is no reason dummy
"large" ptes could not be used which are just ignored by the HW TLB
reload code.
