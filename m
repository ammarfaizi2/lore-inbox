Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWGGPjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWGGPjQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWGGPjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:39:15 -0400
Received: from tim.rpsys.net ([194.106.48.114]:16555 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751219AbWGGPjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:39:14 -0400
Subject: Re: [patch] fix ucb initialization on collie
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Dirk@Opfer-Online.de
In-Reply-To: <20060707114145.GA5195@elf.ucw.cz>
References: <20060707114145.GA5195@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 16:35:50 +0100
Message-Id: <1152286551.5548.105.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 13:41 +0200, Pavel Machek wrote:
> From: Dirk Opfer <Dirk@Opfer-Online.de>
> 
> Fix ucb initialization on collie. Wrong frequency was used and that
> led to things not working quite correctly. (I had to actually disable
> checks in my tree to get it to boot).
> 

> @@ -479,7 +481,7 @@ static int ucb1x00_probe(struct mcp *mcp
>  	mcp_enable(mcp);
>  	id = mcp_reg_read(mcp, UCB_ID);
>  
> -	if (id != UCB_ID_1200 && id != UCB_ID_1300) {
> +	if (id != UCB_ID_1200 && id != UCB_ID_1300 && id != UCB_ID_TC35143) {
>  		printk(KERN_WARNING "UCB1x00 ID not found: %04x\n", id);

UCB_ID_TC35143 isn't defined in mainline, otherwise I'd ack this.

Richard

