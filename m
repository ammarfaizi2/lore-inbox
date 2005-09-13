Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVIMU0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVIMU0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVIMU0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:26:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2518
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932337AbVIMU0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:26:10 -0400
Date: Tue, 13 Sep 2005 13:26:07 -0700 (PDT)
Message-Id: <20050913.132607.113443001.davem@davemloft.net>
To: shemminger@osdl.org
Cc: kiran@scalex86.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, bharata@in.ibm.com, shai@scalex86.org,
       rusty@rustcorp.com.au, netdev@vger.kernel.org
Subject: Re: [patch 7/11] net: Use bigrefs for net_device.refcount
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050913092659.791bddec@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain>
	<20050913161012.GI3570@localhost.localdomain>
	<20050913092659.791bddec@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Tue, 13 Sep 2005 09:26:59 -0700

> Since when is bringing a network device up/down performance critical?

The issue is the dev_get()'s that occur all over the place
to during packet transmit/receive, that's what they are
trying to address.

I'm still against all of these invasive NUMA changes to the
networking though, they are simply too ugly and special cased
to consider seriously.
