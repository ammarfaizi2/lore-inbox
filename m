Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVLKS2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVLKS2L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 13:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVLKS15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 13:27:57 -0500
Received: from ns1.suse.de ([195.135.220.2]:20445 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750787AbVLKS1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 13:27:42 -0500
Date: Sun, 11 Dec 2005 19:27:41 +0100
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Keith Mannthey <kmannth@gmail.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] x86_64 NUMA : Bug correction in populate_memnodemap()
Message-ID: <20051211182741.GT11190@wotan.suse.de>
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

It's already merged, no need to resubmit. P.S.: It would be easier
to merge if you didn't use attachments.

-Andi
