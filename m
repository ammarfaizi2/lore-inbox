Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317593AbSHBBaq>; Thu, 1 Aug 2002 21:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317605AbSHBBaq>; Thu, 1 Aug 2002 21:30:46 -0400
Received: from fmr05.intel.com ([134.134.136.6]:42747 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S317593AbSHBBap>; Thu, 1 Aug 2002 21:30:45 -0400
Message-ID: <25282B06EFB8D31198BF00508B66D4FA03EA56B3@fmsmsx114.fm.intel.com>
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "'David S. Miller'" <davem@redhat.com>, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Seth, Rohit" <rohit.seth@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: RE: large page patch
Date: Thu, 1 Aug 2002 18:34:04 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is typo in Andrew's mail.  It is not 256K, but it is 256MB.

-----Original Message-----
From: David S. Miller [mailto:davem@redhat.com]
Sent: Thursday, August 01, 2002 6:20 PM
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
rohit.seth@intel.com; sunil.saxena@intel.com; asit.k.mallick@intel.com
Subject: Re: large page patch


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
