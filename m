Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965241AbVIVJDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbVIVJDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 05:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbVIVJDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 05:03:17 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56268 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965241AbVIVJDQ (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 05:03:16 -0400
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 2.6.14-rc1-git5] sched: disable preempt in idle tasks
Date: Thu, 22 Sep 2005 11:03:06 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, ncunningham@cyclades.com,
       shaohua.li@intel.com, vatsa@in.ibm.com, Linux-Kernel@vger.kernel.org,
       spyro@f2s.com
References: <43317F3E.9090207@yahoo.com.au> <20050921183138.52bcdf27.akpm@osdl.org> <43322445.6050003@yahoo.com.au>
In-Reply-To: <43322445.6050003@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509221103.07395.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 September 2005 05:25, Nick Piggin wrote:

>
> OK, thanks. That must be the preempt_disable() being called in
> start_secondary(). Maybe I should have listened to the comment.
>
> Can you try the following patch?

The reason it broke was that current doesn't work before cpu_init() -
and preempt_disable does just that.

-Andi
