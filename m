Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbVLGRqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbVLGRqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbVLGRqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:46:43 -0500
Received: from ns2.suse.de ([195.135.220.15]:59307 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751441AbVLGRqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:46:42 -0500
Date: Wed, 7 Dec 2005 18:46:41 +0100
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Keith Mannthey <kmannth@gmail.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] x86_64 NUMA : Bug correction in populate_memnodemap()
Message-ID: <20051207174640.GA11190@wotan.suse.de>
References: <a762e240512062124i517a9c35xd1ec681428418341@mail.gmail.com> <43970136.4010006@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43970136.4010006@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 04:35:18PM +0100, Eric Dumazet wrote:
> As reported by Keith Mannthey, there are problems in populate_memnodemap()
> 
> The bug was that the compute_hash_shift() was returning 31, with incorrect 
> initialization of memnodemap[]
> 
> To correct the bug, we must use (1UL << shift) instead of (1 << shift) to 
> avoid an integer overflow, and we must check that shift < 64 to avoid an 
> infinite loop.

Thanks looks good.

I guess we'll need that for 2.6.15.

-Andi
