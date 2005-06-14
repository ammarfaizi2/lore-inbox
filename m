Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVFNXEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVFNXEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVFNXEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:04:15 -0400
Received: from mail.suse.de ([195.135.220.2]:51846 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261401AbVFNXEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:04:12 -0400
Date: Wed, 15 Jun 2005 01:04:11 +0200
From: Andi Kleen <ak@suse.de>
To: christoph <christoph@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
Message-ID: <20050614230411.GU11898@wotan.suse.de>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw> <20050608131839.GP23831@wotan.suse.de> <Pine.LNX.4.62.0506141551350.3676@ScMPusgw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506141551350.3676@ScMPusgw>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 03:54:24PM -0700, christoph wrote:
> On Wed, 8 Jun 2005, Andi Kleen wrote:
> 
> > However this means __cacheline_aligned_mostly_readonly doesnt make much
> > sense since there is no need for alignment in read only. How about
> > replacing it with a __mostly_readonly that doesnt align and remove
> > __cacheline_aligned_mostly_readonly? 
> 
> Hmm. No. The bigger cpu maps may benefit from cacheline alignment for 
> even for read access. 

Why? Can you please explain that. It doesn't make sense to me.

Any read only cache line should be freely shareable over all caches.

Thanks.

-Andi
