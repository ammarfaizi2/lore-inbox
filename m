Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317978AbSHBDUL>; Thu, 1 Aug 2002 23:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSHBDUK>; Thu, 1 Aug 2002 23:20:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34833 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317978AbSHBDUK>; Thu, 1 Aug 2002 23:20:10 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: large page patch
Date: Fri, 2 Aug 2002 03:23:39 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aictvr$1dd$1@penguin.transmeta.com>
References: <3D49D45A.D68CCFB4@zip.com.au> <20020801.174301.123634127.davem@redhat.com> <3D49DFD0.FE0DBC1D@zip.com.au> <20020801.181944.09310618.davem@redhat.com>
X-Trace: palladium.transmeta.com 1028258603 13304 127.0.0.1 (2 Aug 2002 03:23:23 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 2 Aug 2002 03:23:23 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020801.181944.09310618.davem@redhat.com>,
David S. Miller <davem@redhat.com> wrote:
>   From: Andrew Morton <akpm@zip.com.au>
>   Date: Thu, 01 Aug 2002 18:26:40 -0700
>
>   "David S. Miller" wrote:
>   > This is probably done to increase the likelyhood that 4MB page orders
>   > are available.  If we collapse 4MB pages deeper, they are less likely
>   > to be broken up because smaller orders would be selected first.
>   
>   This is leakage from ia64, which supports up to 256k pages.
>
>Ummm, 4MB > 256K and even with a 4K PAGE_SIZE MAX_ORDER coalesces
>up to 4MB already :-)

That should be 256_M_ pages (13 bits of page size + 15 bits of MAX_ORDER
gives you 256MB max).

		Linus
