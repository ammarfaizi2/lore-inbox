Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264122AbUDOQiV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 12:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264319AbUDOQiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 12:38:21 -0400
Received: from colin2.muc.de ([193.149.48.15]:28690 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264122AbUDOQiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 12:38:19 -0400
Date: 15 Apr 2004 18:38:18 +0200
Date: Thu, 15 Apr 2004 18:38:18 +0200
From: Andi Kleen <ak@muc.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@muc.de>, Terence Ripperda <tripperda@nvidia.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PAT support
Message-ID: <20040415163818.GA54491@colin2.muc.de>
References: <1KifY-uA-7@gated-at.bofh.it> <m3n05gu4o2.fsf@averell.firstfloor.org> <m1fzb56fu2.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1fzb56fu2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This would also be extremely useful on machines with large amounts
> of memory, for write-back mappings.  With large amounts but odd sized
> entries it becomes extremely tricky to map all of the memory using
> mtrrs.

Yes agreed. I already had vendors complaining about this.
But for this it will need some more work - the MTRRs need to be fully
converted to PAT and then disabled (because MTRRs have 
higher priority than PAT). Doing so is a lot more risky than 
what Terrence's patch does currently though.  But longer term
we will need it.

Also it will still need to handle overlapping ranges. I suppose
it will need some simple rules like: converting from UC to WC is 
always ok.

-Andi
