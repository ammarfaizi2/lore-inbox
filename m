Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263248AbTJBFdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 01:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263251AbTJBFdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 01:33:09 -0400
Received: from dp.samba.org ([66.70.73.150]:34212 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263248AbTJBFdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 01:33:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: shinemohamed_j@naturesoft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initializedd the module parameters in drivers/net/wireless/arlan-main.c 
In-reply-to: Your message of "Wed, 01 Oct 2003 20:52:28 MST."
             <20031001205228.3bee8c69.rddunlap@osdl.org> 
Date: Thu, 02 Oct 2003 15:18:08 +1000
Message-Id: <20031002053307.640D92C14D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031001205228.3bee8c69.rddunlap@osdl.org> you write:
> On Wed, 01 Oct 2003 19:01:04 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:
> | This is clearly wrong: it's declared below.
> 
> Hello.  Anybody there?
> 
> This is what you get with 2.6.0-test6 plain vanilla:
> drivers/net/wireless/arlan-main.c:1923: `probe' undeclared (first use in this function)
> drivers/net/wireless/arlan-main.c:1923: (Each undeclared identifier is reported only once
> drivers/net/wireless/arlan-main.c:1923: for each function it appears in.)

See line 1885:

	#ifdef  MODULE

	static int probe = probeUNKNOWN;

	static int __init arlan_find_devices(void)

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
