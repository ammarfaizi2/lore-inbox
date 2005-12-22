Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbVLVHeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbVLVHeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 02:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbVLVHeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 02:34:22 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14291
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965107AbVLVHeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 02:34:22 -0500
Date: Wed, 21 Dec 2005 23:31:17 -0800 (PST)
Message-Id: <20051221.233117.97061334.davem@davemloft.net>
To: coniodiago@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Un aligned addresses
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <993d182d0512212236u525b6f25wf1dcaae9c389537f@mail.gmail.com>
References: <993d182d0512212236u525b6f25wf1dcaae9c389537f@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conio sandiago <coniodiago@gmail.com>
Date: Thu, 22 Dec 2005 12:06:46 +0530

> After a lot of observation ,
> i observed that i am getting un-aligned addresses of the data payload
> from the TCP/IP stack.because of this problem i always have to do
> memcpy to a word aligned buffer,because of which throughput is reduced
> significantly.

Do skb_reserve(skb, 2), before you give the buffer at
skb->data to the chip, this will align all the headers
correctly.
