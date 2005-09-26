Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbVIZXVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVIZXVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 19:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVIZXVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 19:21:34 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21640
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932522AbVIZXVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 19:21:33 -0400
Date: Mon, 26 Sep 2005 16:21:31 -0700 (PDT)
Message-Id: <20050926.162131.118639723.davem@davemloft.net>
To: ecashin@coraid.com
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 2.6.14-rc2] aoe [1/2]: explicitly set minimum packet
 length to ETH_ZLEN
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <87vf0npip4.fsf@coraid.com>
References: <87hdc7ept7.fsf@coraid.com>
	<200509261710.j8QHAkE7008871@turing-police.cc.vt.edu>
	<87vf0npip4.fsf@coraid.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L Cashin <ecashin@coraid.com>
Date: Mon, 26 Sep 2005 18:28:39 -0400

> No, it looks like alloc_skb just kmallocs the data, so I'd need to
> follow up with something like this:

You should explicitly initialize the data areas of the SKB as you
"push" and "put" to allocate space in the data buffer, not right
after alloc_skb() and before you've allocate any space.

