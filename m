Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313089AbSECNo3>; Fri, 3 May 2002 09:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313120AbSECNo2>; Fri, 3 May 2002 09:44:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:28449 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S313089AbSECNo0>; Fri, 3 May 2002 09:44:26 -0400
Date: Fri, 3 May 2002 14:46:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
cc: Andrew Morton <akpm@zip.com.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        linux-mm@kvack.org
Subject: Re: [PATCH]Fix: Init page count for all pages during higher order
 allocs
In-Reply-To: <20020503175438.A1816@in.ibm.com>
Message-ID: <Pine.LNX.4.21.0205031438310.1408-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Suparna Bhattacharya wrote:
> 
> For example we have an option that tries to exclude non-kernel
> pages from the dump based on a simple heuristic of checking the
> PG_lru flag (actually exclude LRU pages and unreferenced pages). 

I hadn't thought of using PG_lru (last thought about it before
anonymous pages were put on the LRU in 2.4.14): good idea,
seems much more appealing than my extra flag for GFP_HIGHUSER.

Hugh

