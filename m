Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVHLTLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVHLTLh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVHLTLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:11:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11224
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751247AbVHLTLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:11:36 -0400
Date: Fri, 12 Aug 2005 12:10:38 -0700 (PDT)
Message-Id: <20050812.121038.23012223.davem@davemloft.net>
To: john.ronciak@gmail.com
Cc: mpm@selenic.com, akpm@osdl.com, ak@suse.de, jmoyer@redhat.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       john.ronciak@intel.com, rostedt@goodmis.org
Subject: Re: [PATCH 3/8] netpoll: e1000 netpoll tweak
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <56a8daef0508121202172bcd17@mail.gmail.com>
References: <3.502409567@selenic.com>
	<4.502409567@selenic.com>
	<56a8daef0508121202172bcd17@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ronciak <john.ronciak@gmail.com>
Subject: Re: [PATCH 3/8] netpoll: e1000 netpoll tweak
Date: Fri, 12 Aug 2005 12:02:03 -0700

> Sorry this reply was to go to the whole list but only made it to Matt.
> 
> The e1000_intr() routine already calls e1000_clean_tx_irq().  So
> what's the point of this patch?  Am I missing something?

e1000_intr() does not call e1000_clean_tx_irq() when NAPI
is enabled.
