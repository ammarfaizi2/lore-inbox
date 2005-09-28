Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965268AbVI1IhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965268AbVI1IhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 04:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965267AbVI1IhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 04:37:04 -0400
Received: from mx1.suse.de ([195.135.220.2]:47341 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965062AbVI1IhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 04:37:02 -0400
From: Andi Kleen <ak@suse.de>
To: Harald Welte <laforge@netfilter.org>
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
Date: Wed, 28 Sep 2005 10:37:02 +0200
User-Agent: KMail/1.8.2
Cc: Henrik Nordstrom <hno@marasystems.com>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <432EF0C5.5090908@cosmosbay.com> <Pine.LNX.4.61.0509280219110.25500@filer.marasystems.com> <20050928083240.GP4168@sunbeam.de.gnumonks.org>
In-Reply-To: <20050928083240.GP4168@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281037.03185.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 September 2005 10:32, Harald Welte wrote:

> I totally agree, that from a current perspective, I think the concept of
> just loading a module (that has usage count 0) having severe impact on
> system performance is just wrong.  But then, users are used to the
> current behaviour for almost five years now. 

That doesn't mean it cannot be improved - and I think it should.

In a sense it's even getting worse: For example us losing the CONFIG
option to disable local conntrack (Patrick has disabled it some time ago 
without even a comment why he did it) has a really bad impact in some cases.

> Therefore: Let's do this right next time, but live with that fact for
> now.

Even with a "quite straight-forward" (quoting you) fix?

> Just imagine all those poor sysadmins who know nothing about current
> kernel development, and who upgrade their kernel because their
> distributor provides a new one - suddenly their accounting (which might
> be relevant for their business) doesn't work anymore :(

Accounting with per CPU counters can be done fully lockless.

-Andi
