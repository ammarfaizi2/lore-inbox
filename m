Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWF3ACr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWF3ACr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWF3ACr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:02:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58543
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751322AbWF3ACq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:02:46 -0400
Date: Thu, 29 Jun 2006 17:02:44 -0700 (PDT)
Message-Id: <20060629.170244.104032326.davem@davemloft.net>
To: samuel@sortiz.org
Cc: paulmck@us.ibm.com, josht@vnet.ibm.com, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, akpm@osdl.org, netdev@vger.kernel.org,
       irda-users@lists.sourceforge.net
Subject: Re: [PATCH 1/2] [IrDA] Fix RCU lock pairing on error path
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060630065534.GA4729@sortiz.org>
References: <1151542602.18723.19.camel@josh-work.beaverton.ibm.com>
	<20060629142741.GA1294@us.ibm.com>
	<20060630065534.GA4729@sortiz.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Ortiz <samuel@sortiz.org>
Date: Fri, 30 Jun 2006 09:55:34 +0300

> irlan_client_discovery_indication calls rcu_read_lock and rcu_read_unlock, but
> returns without unlocking in an error case.  Fix that by replacing the return
> with a goto so that the rcu_read_unlock always gets executed.
> 
> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Samuel Ortiz samuel@sortiz.org <>

Applied, thanks.
