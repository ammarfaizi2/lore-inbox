Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267680AbTBFWq7>; Thu, 6 Feb 2003 17:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbTBFWq7>; Thu, 6 Feb 2003 17:46:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39897 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267680AbTBFWq6>;
	Thu, 6 Feb 2003 17:46:58 -0500
Date: Thu, 06 Feb 2003 14:43:06 -0800 (PST)
Message-Id: <20030206.144306.14966745.davem@redhat.com>
To: christopher.leech@intel.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: skb_padto and small fragmented transmits
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1044559328.4618.54.camel@localhost.localdomain>
References: <BD9B60A108C4D511AAA10002A50708F20BA2AAE3@orsmsx118.jf.intel.com>
	<1044559328.4618.54.camel@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Leech <christopher.leech@intel.com>
   Date: 06 Feb 2003 11:22:08 -0800
   
   OK, now I'm really getting confused.  Every other example I can find in
   the networking code, and every scatter-gather capable driver, uses
   skb->len as the full length and skb->len - skb->data_len as the length
   of the first or linear portion.
   
Indeed, Alan you need to fix the skb_padto stuff to use
skb->len, ignore the skb->data_len as skb->len is the
full length.

Sorry for telling you to do the wrong thing Alan, my bad :)
