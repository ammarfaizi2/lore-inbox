Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWGYANK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWGYANK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 20:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWGYANK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 20:13:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16074 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932345AbWGYANJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 20:13:09 -0400
Date: Mon, 24 Jul 2006 17:12:13 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: Tom Walter Dillig <tdillig@stanford.edu>, linux-kernel@vger.kernel.org,
       w@1wt.eul, kernel_org@digitalpeer.com, security@kernel.org,
       Netdev list <netdev@vger.kernel.org>
Subject: Re: softmac possible null deref [was: Complete report of Null
 dereference errors in kernel 2.6.17.1]
Message-ID: <20060724171213.62810d2b@localhost.localdomain>
In-Reply-To: <44C55F36.5000701@gentoo.org>
References: <1153782637.44c5536e013a4@webmail>
	<44C55F36.5000701@gentoo.org>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.19; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006 01:00:54 +0100
Daniel Drake <dsd@gentoo.org> wrote:

> Tom Walter Dillig wrote:
> > [109]
> > 452 net/ieee80211/softmac/ieee80211softmac_io.c
> > Possible null dereference of variable "*pkt" in function call
> > (include/asm/string.h:__constant_c_and_count_memset) checked at
> > (453:net/ieee80211/softmac/ieee80211softmac_io.c)
> 
> Either I'm misunderstanding, or this is bogus.
> 
> when *pkt is allocated by the various child functions (e.g. 
> ieee80211softmac_disassoc_deauth), it is always checked for NULL.
> 
> Finally, line 453 does another NULL check.

> 
> What is the report trying to say?

That the check in 453 should be removed because is unneeded.

People who obsess about code coverage care that there are unneded
checks. I don't think it matters.
