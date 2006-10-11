Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030788AbWJKDur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030788AbWJKDur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 23:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030787AbWJKDur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 23:50:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47043
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030783AbWJKDuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 23:50:46 -0400
Date: Tue, 10 Oct 2006 20:50:49 -0700 (PDT)
Message-Id: <20061010.205049.132929620.davem@davemloft.net>
To: rdreier@cisco.com
Cc: mst@mellanox.co.il, shemminger@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
From: David Miller <davem@davemloft.net>
In-Reply-To: <adafydvbjgq.fsf@cisco.com>
References: <adak637bjs3.fsf@cisco.com>
	<20061010.204528.90823856.davem@davemloft.net>
	<adafydvbjgq.fsf@cisco.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 10 Oct 2006 20:49:09 -0700

>     David> non-sendfile() paths will generate big packets just fine,
>     David> as long as the application is providing that much data.
> 
> OK, cool.  Will the big packets be non-linear skbs?

If you had SG enabled (and thus checksumming offload too) then yes
you'll get a non-linear SKB.  Otherwise, without SG, you'll get a
fully linear SKB.
