Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbTCaS5a>; Mon, 31 Mar 2003 13:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261801AbTCaS5a>; Mon, 31 Mar 2003 13:57:30 -0500
Received: from holomorphy.com ([66.224.33.161]:36292 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261800AbTCaS53>;
	Mon, 31 Mar 2003 13:57:29 -0500
Date: Mon, 31 Mar 2003 11:08:03 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
Message-ID: <20030331190803.GS30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20030328040038.GO1350@holomorphy.com> <20030330231945.GH2318@x30.local> <20030331042729.GQ30140@holomorphy.com> <20030331183506.GC11026@x30.random> <20030331194117.A27859@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030331194117.A27859@infradead.org>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 08:35:06PM +0200, Andrea Arcangeli wrote:
>> About you not caring anymore about the mem_map array size, that still
>> matters on the embedded usage, infact rmap on the embedded usage is the
>> biggest waste there, normally they don't even have swap so if something
>> you should use the rmap provided for truncate, rather than wasting
>> memory in the mem_map array.

On Mon, Mar 31, 2003 at 07:41:17PM +0100, Christoph Hellwig wrote:
> We have CONFIG_SWAP for that in 2.5..

I think the rmap allocations currently depend on CONFIG_MMU; IMHO it
can be moved to CONFIG_SWAP if/when objrmap is merged since only
anonymous memory will need pte_chains then, and it can't be evicted.


-- wli
