Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbWCGAvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWCGAvX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWCGAvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:51:22 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:64219
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932556AbWCGAvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:51:22 -0500
Date: Mon, 06 Mar 2006 16:51:29 -0800 (PST)
Message-Id: <20060306.165129.62204114.davem@davemloft.net>
To: bcrl@kvack.org
Cc: drepper@gmail.com, da-x@monatomic.org, linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060307004237.GT20768@kvack.org>
References: <20060306233300.GR20768@kvack.org>
	<20060306.162444.107249907.davem@davemloft.net>
	<20060307004237.GT20768@kvack.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin LaHaise <bcrl@kvack.org>
Date: Mon, 6 Mar 2006 19:42:37 -0500

> I'm open to suggestions. =-)  So far my thoughts have mostly been limited 
> to how to make tx faster, at which point you have to go into the kernel 
> somehow to deal with the virtual => physical address translation (be it 
> with a locked buffer or whatever) and kicking the hardware.  Rx has been 
> much less interesting simply because the hardware side doesn't offer as 
> much.

I think any such VM tricks need serious thought.  It has serious
consequences as far as cost especially on SMP.  Evgivny has some data
that shows this, and chapter 5 of Networking Algorithmics has a lot of
good analysis and paper references on this topic.
