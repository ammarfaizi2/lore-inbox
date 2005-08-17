Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVHQWBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVHQWBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 18:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVHQWBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 18:01:14 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44985
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751280AbVHQWBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 18:01:13 -0400
Date: Wed, 17 Aug 2005 15:00:47 -0700 (PDT)
Message-Id: <20050817.150047.64537724.davem@davemloft.net>
To: linville@tuxdriver.com
Cc: netdev@vger.kernel.org, linux-tr@linuxtr.net, mikep@linuxtr.net,
       jgarzik@pobox.com, fubar@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-rc6] net/802/tr: use interrupt-safe locking
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050817204959.GA20186@tuxdriver.com>
References: <20050817204959.GA20186@tuxdriver.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John W. Linville" <linville@tuxdriver.com>
Date: Wed, 17 Aug 2005 16:49:59 -0400

> Change operations on rif_lock from spin_{un}lock_bh to
> spin_{un}lock_irq{save,restore} equivalents.  Some of the
> rif_lock critical sections are called from interrupt context via
> tr_type_trans->tr_add_rif_info.  The TR NIC drivers call tr_type_trans
> from their packet receive handlers.

Applied, I'll try to get this into 2.6.13, but it may have
to wait for 2.6.14
