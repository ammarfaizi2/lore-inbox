Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBGDic>; Tue, 6 Feb 2001 22:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129028AbRBGDiX>; Tue, 6 Feb 2001 22:38:23 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:31472 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S129027AbRBGDiM>;
	Tue, 6 Feb 2001 22:38:12 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Eric Berenguier <Eric.Berenguier@sycomore.fr>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: ipfwadm IP accounting (2.4.1) 
In-Reply-To: Your message of "Tue, 06 Feb 2001 13:38:37 BST."
             <l0310280ab6a59b6a53d3@[172.30.8.86]> 
Date: Wed, 07 Feb 2001 14:37:57 +1100
Message-Id: <E14QLQb-0002Tp-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <l0310280ab6a59b6a53d3@[172.30.8.86]> you write:
> Using ipfwadm on a 2.4.1 kernel, some ip accouting rules for outgoing
> packets have theirs packet and byte counter stuck to 0 value. There is no
> such problem with incoming packets.

Hi Eric!

You're exactly right: it was a typo.  Thanks.

Linus, please apply.

Rusty.
--- linux-2.4.1/net/ipv4/netfilter/ip_fw_compat.c	Tue Feb  6 11:10:01 2001
+++ linux/net/ipv4/netfilter/ip_fw_compat.c	Tue Feb  6 09:03:17 2001
@@ -132,7 +132,7 @@
 		if (ret == FW_ACCEPT || ret == FW_SKIP) {
 			if (fwops->fw_acct_out)
 				fwops->fw_acct_out(fwops, PF_INET,
-						   (struct net_device *)in,
+						   (struct net_device *)out,
 						   (*pskb)->nh.raw, &redirpt,
 						   pskb);
 			confirm_connection(*pskb);

--
Premature optmztion is rt of all evl. --DK
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
