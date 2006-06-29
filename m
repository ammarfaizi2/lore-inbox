Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWF2TsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWF2TsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWF2TsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:48:14 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27115
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932352AbWF2TsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:48:13 -0400
Date: Thu, 29 Jun 2006 12:48:12 -0700 (PDT)
Message-Id: <20060629.124812.90122373.davem@davemloft.net>
To: josht@vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, samuel@sortiz.org
Subject: Re: [PATCH] irda: Fix RCU lock pairing on error path
From: David Miller <davem@davemloft.net>
In-Reply-To: <1151542602.18723.19.camel@josh-work.beaverton.ibm.com>
References: <1151542602.18723.19.camel@josh-work.beaverton.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Triplett <josht@vnet.ibm.com>
Date: Wed, 28 Jun 2006 17:56:41 -0700

> irlan_client_discovery_indication calls rcu_read_lock and rcu_read_unlock, but
> returns without unlocking in an error case.  Fix that by replacing the return
> with a goto so that the rcu_read_unlock always gets executed.
> 
> Signed-off-by: Josh Triplett <josh@freedesktop.org>

Applied, thanks a lot.
