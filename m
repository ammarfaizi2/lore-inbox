Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWHPJFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWHPJFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWHPJFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:05:50 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35719
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751037AbWHPJFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:05:49 -0400
Date: Wed, 16 Aug 2006 02:05:03 -0700 (PDT)
Message-Id: <20060816.020503.74744144.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: hch@infradead.org, arnd@arndb.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060816090028.GA25476@2ka.mipt.ru>
References: <20060816053545.GB22921@2ka.mipt.ru>
	<20060816084808.GA7366@infradead.org>
	<20060816090028.GA25476@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Wed, 16 Aug 2006 13:00:31 +0400

> So I would like to know how to determine which node should be used for
> allocation. Changes of __get_user_pages() to alloc_pages_node() are
> trivial.

netdev_alloc_skb() knows the netdevice, and therefore you can
obtain the "struct device;" referenced inside of the netdev,
and therefore you can determine the node using the struct
device.

Christophe is working on adding support for this using existing
allocator.
