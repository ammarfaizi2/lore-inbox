Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266793AbSKLOnV>; Tue, 12 Nov 2002 09:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbSKLOnU>; Tue, 12 Nov 2002 09:43:20 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:50840 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S266793AbSKLOnU>; Tue, 12 Nov 2002 09:43:20 -0500
Date: Tue, 12 Nov 2002 12:49:50 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "David S. Miller" <davem@redhat.com>
cc: hugh@veritas.com, <akpm@digeo.com>, <dmccr@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] flush_cache_page while pte valid 
In-Reply-To: <20021111.225333.122204472.davem@redhat.com>
Message-ID: <Pine.LNX.4.44L.0211121248540.3817-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2002, David S. Miller wrote:
>    From: Hugh Dickins <hugh@veritas.com>
>    Date: Tue, 12 Nov 2002 06:53:04 +0000 (GMT)
>
>    Thanks for shedding light on that; but I'm still wondering if there
>    might be data loss if userspace modifies the page in the tiny window
>    between correctly positioned flush_cache_page and pte invalidation?
>
> The flush merely writes back the data, a copy-back operation, fully L2
> cache coherent.  All cpus will see correct data if an intermittant
> store occurs.

The CPUs will, but the harddisk might not.

We really need to get this right in the swapout path.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

