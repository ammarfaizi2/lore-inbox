Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWCHWrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWCHWrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWCHWrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:47:08 -0500
Received: from kanga.kvack.org ([66.96.29.28]:65191 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932513AbWCHWrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:47:06 -0500
Date: Wed, 8 Mar 2006 17:41:40 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, netdev@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add percpu_counter_mod_bh
Message-ID: <20060308224140.GC5410@kvack.org>
References: <20060308015808.GA9062@localhost.localdomain> <20060308015934.GB9062@localhost.localdomain> <20060307181301.4dd6aa96.akpm@osdl.org> <20060308202656.GA4493@localhost.localdomain> <20060308203642.GZ5410@kvack.org> <20060308210726.GD4493@localhost.localdomain> <20060308211733.GA5410@kvack.org> <20060308222528.GE4493@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308222528.GE4493@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 02:25:28PM -0800, Ravikiran G Thirumalai wrote:
> Then, for the batched percpu_counters, we could gain by using local_t only for 
> the UP case. But we will have to have a new local_long_t implementation 
> for that.  Do you think just one use case of local_long_t warrants for a new
> set of apis?

I think it may make more sense to simply convert local_t into a long, given 
that most of the users will be things like stats counters.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
