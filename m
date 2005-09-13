Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVIMUyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVIMUyT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbVIMUyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:54:19 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:45286
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932524AbVIMUyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:54:17 -0400
Date: Tue, 13 Sep 2005 13:54:16 -0700 (PDT)
Message-Id: <20050913.135416.112398983.davem@davemloft.net>
To: shemminger@osdl.org
Cc: jes@trained-monkey.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] hippi: change to not use skb private
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050913113858.440d3a0f@localhost.localdomain>
References: <20050913113858.440d3a0f@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Tue, 13 Sep 2005 11:38:58 -0700

> It looks like the following would fix hippi to not have to put
> fields in sk_buff. The ifield looks appears to to be additional
> header information that is being passed in the skb but could just
> be put in the header.

I can't see any problem with this patch, and it fixes
all the realloc stuff that has to potentially occur
in the transmit path.
