Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWEKS5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWEKS5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWEKS5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:57:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40883
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750707AbWEKS5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:57:46 -0400
Date: Thu, 11 May 2006 11:57:40 -0700 (PDT)
Message-Id: <20060511.115740.30658747.davem@davemloft.net>
To: akpm@osdl.org
Cc: stern@rowland.harvard.edu, sekharan@us.ibm.com, jes@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow raw_notifier callouts to unregister themselves
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060511112509.6c9db883.akpm@osdl.org>
References: <Pine.LNX.4.44L0.0605111353210.5834-100000@iolanthe.rowland.org>
	<20060511112509.6c9db883.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Thu, 11 May 2006 11:25:09 -0700

> Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Since raw_notifier chains don't benefit from any centralized locking
> > protections, they shouldn't suffer from the associated limitations.  
> > Under some circumstances it might make sense for a raw_notifier callout
> > routine to unregister itself from the notifier chain.  This patch (as678)
> > changes the notifier core to allow for such things.
> 
> ok...  Can you see any reason why 2.6.17 needs this?

If this patch makes raw notifiers behave more closely to the
way notifiers did before the notifier patch went into 2.6.17,
we should seriouly consider it.  We've had enough regressions
from that patch, and anything which minimizes any possible other
such regressions would be a plus.
