Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbSKVFwZ>; Fri, 22 Nov 2002 00:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbSKVFwZ>; Fri, 22 Nov 2002 00:52:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:46494 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265480AbSKVFwZ>;
	Fri, 22 Nov 2002 00:52:25 -0500
Date: Thu, 21 Nov 2002 21:56:28 -0800 (PST)
Message-Id: <20021121.215628.133829160.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       kuznet@ms2.inr.ac.ru.ee.t.u-tokyo.ac.jp, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix BUG When Received Unknown Protocol
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021121.013203.100868154.yoshfuji@linux-ipv6.org>
References: <20021121.013203.100868154.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Thu, 21 Nov 2002 01:32:03 -0500 (EST)

   Since 2.5.43, kernel panics by executing BUG() when
   received unknown protocol in IPv6 packet. 
   This is because ip6_input_finish() try to kfree_skb() 
   while icmpv6_param_prob() has already kfree_skb()'ed the skb.

Patch applied, thanks.
