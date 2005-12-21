Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVLUHf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVLUHf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 02:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVLUHf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 02:35:27 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12003
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932302AbVLUHf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 02:35:26 -0500
Date: Tue, 20 Dec 2005 23:35:26 -0800 (PST)
Message-Id: <20051220.233526.63337356.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: christopher.leech@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, andrew.grover@intel.com, john.ronciak@intel.com
Subject: Re: [RFC][PATCH 4/5] I/OAT DMA support and TCP acceleration
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43A8F43B.6020307@cosmosbay.com>
References: <1135142263.13781.21.camel@cleech-mobl>
	<43A8F43B.6020307@cosmosbay.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Wed, 21 Dec 2005 07:20:43 +0100

> Please consider not enlarging cb[] if not CONFIG_NET_DMA ?

I also disagree with putting this thing in the cb[] at all.

Just put the dma_cookie_t explicitly into struct sk_buff,
protected by CONFIG_NET_DMA.
