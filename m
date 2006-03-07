Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWCGDGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWCGDGO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbWCGDGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:06:14 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40679
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752482AbWCGDGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:06:14 -0500
Date: Mon, 06 Mar 2006 19:06:33 -0800 (PST)
Message-Id: <20060306.190633.08168501.davem@davemloft.net>
To: bcrl@kvack.org
Cc: drepper@gmail.com, da-x@monatomic.org, linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060307013915.GU20768@kvack.org>
References: <20060307004237.GT20768@kvack.org>
	<20060306.165129.62204114.davem@davemloft.net>
	<20060307013915.GU20768@kvack.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin LaHaise <bcrl@kvack.org>
Date: Mon, 6 Mar 2006 20:39:15 -0500

> VM tricks do suck, so you just have to use the tricks that nobody else 
> is...  My thinking is to do something like the following: have a structure 
> to reference a set of pages.  When it is first created, it takes a reference 
> on the pages in question, and it is added to the vm_area_struct of the user 
> so that the vm can poke it for freeing when memory pressure occurs.  The 
> sk_buff dataref also has to have a pointer to the pageref added.

You've just reinvented fbufs, and they have their own known set of
issues.

Please read chapter 5 of Networking Algorithmics or ask someone to
paraphrase the content for you.  It really covers this completely, and
once you read it you will be able to avoid reinenting the wheel and
falling under the false notion of having invented something :-)
