Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318785AbSIPDj0>; Sun, 15 Sep 2002 23:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318786AbSIPDj0>; Sun, 15 Sep 2002 23:39:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19423 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318785AbSIPDjX>;
	Sun, 15 Sep 2002 23:39:23 -0400
Date: Sun, 15 Sep 2002 20:35:28 -0700 (PDT)
Message-Id: <20020915.203528.08097520.davem@redhat.com>
To: bart.de.schuymer@pandora.be
Cc: buytenh@math.leidenuniv.nl, linux-kernel@vger.kernel.org
Subject: Re: bridge-netfilter patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209140905.40816.bart.de.schuymer@pandora.be>
References: <20020913144518.A31318@math.leidenuniv.nl>
	<20020913.112235.27948638.davem@redhat.com>
	<200209140905.40816.bart.de.schuymer@pandora.be>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bart De Schuymer <bart.de.schuymer@pandora.be>
   Date: Sat, 14 Sep 2002 09:05:40 +0200

   On Friday 13 September 2002 20:22, David S. Miller wrote:
   > First explain to me why the copy is needed for.
   
   memcpy(skb2->data - 16, skb->data - 16, 16);
   
   This is for purely bridged packets.

Why is it being added, therefore, to ip_queue_xmit() which is only
ever invoked by TCP output processing?

If the patch adds the call somewhere else, please correct me, but
I specifically remember it being added to ip_queue_xmit() which is
why I barfed when seeing it :-)


