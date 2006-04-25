Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWDYBmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWDYBmu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 21:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWDYBmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 21:42:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:35979 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750749AbWDYBmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 21:42:49 -0400
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: akpm@osdl.org, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, Valerie.Clement@bull.net,
       kurosawa@valinux.co.jp
In-Reply-To: <20060424.141846.31056103.taka@valinux.co.jp>
References: <1145670536.15389.132.camel@linuxchandra>
	 <20060421191340.0b218c81.akpm@osdl.org>
	 <1145683725.21231.15.camel@linuxchandra>
	 <20060424.141846.31056103.taka@valinux.co.jp>
Content-Type: text/plain
Organization: IBM
Date: Mon, 24 Apr 2006 18:42:46 -0700
Message-Id: <1145929366.1400.96.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 14:18 +0900, Hirokazu Takahashi wrote:
> Hi Chandra, 
<snip>
> > Yes, it is effective, and the reclamation is O(1) too. It has couple of
> > problems by design, (1) doesn't handle shared pages and (2) doesn't
> > provide support for both min_shares and max_shares.
> 
> I'm not sure all of them have to be managed under ckrm_core and rcfs
> in kernel.
> 
> These functions you mentioned can be implemented in user space
> to minimize the overhead in usual VM operations because it isn't
> expected quick response to resize it. It is a bit different from
> that of CPU resource.

Agree, that is where the additional complexity arise from.

If the user can achieve the same results with user space solution that
would be good too. 

Thanks

chandra

> You don't need to invent everything. I think you can reuse what
> NUMA team is doing instead. This approach may not fit in your rcfs,
> though.
> 
> > > This requirement is basically a glorified RLIMIT_RSS manager, isn't it? 
> > > Just that it covers a group of mm's and not just the one mm?
> > 
> > Yes, that is the core object of ckrm, associate resources to a group of
> > tasks.
> 
> Thanks,
> Hirokazu Takahahsi.
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


