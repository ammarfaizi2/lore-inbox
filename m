Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280694AbRKFXoB>; Tue, 6 Nov 2001 18:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280709AbRKFXnx>; Tue, 6 Nov 2001 18:43:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2177 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280695AbRKFXl7>;
	Tue, 6 Nov 2001 18:41:59 -0500
Date: Tue, 06 Nov 2001 15:40:59 -0800 (PST)
Message-Id: <20011106.154059.126759204.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: fokkensr@linux06.vertis.nl, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: Re: iptables and tcpdump
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011031172835.4f0c0ed2.rusty@rustcorp.com.au>
In-Reply-To: <20011030152812.2e9ba8ee.rusty@rustcorp.com.au>
	<20011029.213157.39157336.davem@redhat.com>
	<20011031172835.4f0c0ed2.rusty@rustcorp.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Wed, 31 Oct 2001 17:28:35 +1100

   On Mon, 29 Oct 2001 21:31:57 -0800 (PST)
   "David S. Miller" <davem@redhat.com> wrote:
   
   >    From: Rusty Russell <rusty@rustcorp.com.au>
   >    Date: Tue, 30 Oct 2001 15:28:12 +1100
   >    
   >    should the NAT layer be doing skb_unshare() before altering the packet?
   > 
   > I think it should.
   
   Agreed.  The 2.2 masq code didn't do this, and hence the "don't
   tcpdump on masq host" recommendation.
   
   Please try this patch (compiles at least),

Applied to my sources...

Franks a lot,
David S. Miller
davem@redhat.com
