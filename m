Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbTBUGG2>; Fri, 21 Feb 2003 01:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbTBUGG2>; Fri, 21 Feb 2003 01:06:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25550 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267176AbTBUGG2>;
	Fri, 21 Feb 2003 01:06:28 -0500
Date: Thu, 20 Feb 2003 22:00:35 -0800 (PST)
Message-Id: <20030220.220035.64239800.davem@redhat.com>
To: mitch@sfgoth.com
Cc: chas@locutus.cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [ATM] who 'owns' the skb created by drivers/atm?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030220221255.A11525@sfgoth.com>
References: <Pine.LNX.4.44.0302211241070.12797-100000@blackbird.intercode.com.au>
	<1045808570.22228.2.camel@rth.ninka.net>
	<20030220221255.A11525@sfgoth.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mitchell Blank Jr <mitch@sfgoth.com>
   Date: Thu, 20 Feb 2003 22:12:55 -0800
   
   Some people seem to be suggesting that we need to zero
   out ->cb before passing the SKB to netif_rx() but I don't see why
   that would be neccesary.

It is true, the whole input mechanism depends upon skb->cb[] being
clear on new skbs coming in via netif_rx().
