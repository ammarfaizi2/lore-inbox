Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265418AbSJXLeb>; Thu, 24 Oct 2002 07:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265419AbSJXLeb>; Thu, 24 Oct 2002 07:34:31 -0400
Received: from tomts12.bellnexxia.net ([209.226.175.56]:62127 "EHLO
	tomts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S265418AbSJXLea>; Thu, 24 Oct 2002 07:34:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
Date: Thu, 24 Oct 2002 07:35:48 -0400
User-Agent: KMail/1.4.3
Cc: Rik van Riel <riel@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
References: <3DB4C87E.7CF128F3@digeo.com> <2622146086.1035233637@[10.10.2.3]>
In-Reply-To: <2622146086.1035233637@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210240735.48973.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just experienced this problem on UP with 513M memory.  About 400m was 
locked in dentries.  The system was very unresponsive - suspect it was
spending gobs of time scaning unfreeable dentries.  This was with -mm3
up about 24 hours.

The inode caches looked sane.  Just the dentries were out of wack.

Ed

