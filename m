Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267516AbTBFSsQ>; Thu, 6 Feb 2003 13:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267524AbTBFSsQ>; Thu, 6 Feb 2003 13:48:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27096 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267516AbTBFSsP>;
	Thu, 6 Feb 2003 13:48:15 -0500
Date: Thu, 06 Feb 2003 10:44:24 -0800 (PST)
Message-Id: <20030206.104424.39167597.davem@redhat.com>
To: christopher.leech@intel.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: skb_padto and small fragmented transmits
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1044559370.4620.36.camel@localhost.localdomain>
References: <BD9B60A108C4D511AAA10002A50708F20BA2AAD1@orsmsx118.jf.intel.com>
	<1044559370.4620.36.camel@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Leech <christopher.leech@intel.com>
   Date: 06 Feb 2003 11:22:51 -0800
   
   I fail to see how the statement "skb->len + skb->data_len" has any
   usable meaning, or how it can be anything other than a bug.

This equation is the standard way to find the full length
on any skb.  For linear skbs, data_len is always zero.

I asked Alan to use this formula so that greps on the source
tree would always show data_len being taken into account, and
thus usage would be consistent.
