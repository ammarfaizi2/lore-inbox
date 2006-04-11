Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWDKIgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWDKIgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 04:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWDKIgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 04:36:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48281
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932361AbWDKIgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 04:36:46 -0400
Date: Tue, 11 Apr 2006 01:36:42 -0700 (PDT)
Message-Id: <20060411.013642.78129957.davem@davemloft.net>
To: vda@ilport.com.ua
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] deinline a few large functions in vlan code - v3
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200604111111.12554.vda@ilport.com.ua>
References: <200604111047.36941.vda@ilport.com.ua>
	<20060411.005858.49205474.davem@davemloft.net>
	<200604111111.12554.vda@ilport.com.ua>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Vlasenko <vda@ilport.com.ua>
Date: Tue, 11 Apr 2006 11:11:12 +0300

> Ok, one last try. Would you like this smallish patch instead?
> It takes care of those BIG inlines.

You're putting vlan stuff into a net/core/*.c file, that
is not correct.

If we're not going to do the ifdef mess, fudging around it
by putting a "VLAN" function into generic networking core
code isn't the way to try and deal with it.

Like I said, let's just leave things they way they are.
Every suggestion shown so far has been worse than what we
have now.
