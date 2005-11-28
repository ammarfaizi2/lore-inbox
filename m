Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbVK1Ecs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbVK1Ecs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 23:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbVK1Ecs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 23:32:48 -0500
Received: from xenotime.net ([66.160.160.81]:26792 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750994AbVK1Ecs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 23:32:48 -0500
Date: Sun, 27 Nov 2005 20:33:17 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "James G. Sack (jim)" <jgsack@san.rr.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [RFC] HOWTO do Linux kernel development - take 3
Message-Id: <20051127203317.623f9a7c.rdunlap@xenotime.net>
In-Reply-To: <op.s0qed2o1c50ahi@jgs.sack-net.pvt>
References: <op.s0qed2o1c50ahi@jgs.sack-net.pvt>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005 22:16:40 -0800 James G. Sack (jim) wrote:

> Pardon the technical question, but..
> 
> I wonder if you could either elaborate or give a reference to what is  
> meant by
> 
>    "Arbitrary long long divisions .. not allowed"

(if not already answered)

short answer:  see include/asm-generic/div64.h


longer answer:

Not supported:

long long numerator, divisor, dividend;
/* init. numerator & divisor */
dividend = numerator / divisor;

Is supported:

uin64_t numerator, dividend;
uint32_t divisor, remainder;
/* init. numerator & divisor */
remainder = do_div(&numerator, divisor);


---
~Randy
