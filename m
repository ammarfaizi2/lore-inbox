Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbUKRWBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbUKRWBu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbUKRV7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:59:52 -0500
Received: from fsmlabs.com ([168.103.115.128]:10884 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262976AbUKRV6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:58:06 -0500
Date: Thu, 18 Nov 2004 14:57:53 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel thermal monitor for x86_64 (updated)
In-Reply-To: <20041118200143.GP17532@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0411181457260.7988@musoma.fsmlabs.com>
References: <Pine.LNX.4.61.0411180652330.7187@musoma.fsmlabs.com>
 <20041118163309.GK17532@wotan.suse.de> <Pine.LNX.4.61.0411181053410.4034@musoma.fsmlabs.com>
 <20041118200143.GP17532@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Andi Kleen wrote:

> Flooding the kmsg is as bad.
> 
> I think a better strategy is to just increase the minimum check interval
> to avoid this. And then treat printk and mce_log the same.
> 
> > 
> > > Also the next_check logic should already handle this I guess,
> > > becaumse I assume the temperature dropping won't take
> > > that long.  So I guess it would be best to drop that 
> > > and if it's still a problem use a longer next_check timeout
> > > of several seconds.
> > 
> > The temperature drop can take a while, i've observed 2-3 minutes if the 
> > processor is also loaded and the ambient temperature is low (20C). So you 
> > could lose 12 or so slots in the mce log due to the temperature ping 
> > ponging.
> 
> Ok then perhaps a extremly long check timeout of 5 minutes? 

Agreed, i'll have something tommorrow.

Thanks for the input,
	Zwane

