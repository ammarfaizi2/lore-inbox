Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317832AbSGVWSu>; Mon, 22 Jul 2002 18:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317842AbSGVWSu>; Mon, 22 Jul 2002 18:18:50 -0400
Received: from holomorphy.com ([66.224.33.161]:52102 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317832AbSGVWSu>;
	Mon, 22 Jul 2002 18:18:50 -0400
Date: Mon, 22 Jul 2002 15:21:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Steven Cole <scole@lanl.gov>
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
Message-ID: <20020722222150.GF919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Steven Cole <elenstev@mesatop.com>,
	Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Steven Cole <scole@lanl.gov>
References: <Pine.LNX.4.44.0207210245080.6770-100000@loke.as.arizona.edu> <1027364068.12588.26.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027364068.12588.26.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 05:24, Craig Kulesa wrote:
>> This is an update for the 2.5 port of Ed Tomlinson's patch to move slab
>> pages onto the lru for page aging, atop 2.5.27 and the full rmap patch.  
>> It is aimed at being a fairer, self-tuning way to target and evict slab
>> pages.

On Mon, Jul 22, 2002 at 12:54:28PM -0600, Steven Cole wrote:
> While trying to boot 2.5.27-rmap-slablru, I got this early in the boot:
> Kernel panic: Failed to create pte-chain mempool!
> In idle task - not syncing

The pte_chain mempool was ridiculously huge and the use of mempool for
this at all was in error.


Cheers,
Bill
