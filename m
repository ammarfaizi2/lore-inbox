Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264254AbUENMRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbUENMRO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 08:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbUENMRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 08:17:14 -0400
Received: from web90105.mail.scd.yahoo.com ([66.218.94.76]:25269 "HELO
	web90105.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264254AbUENMRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 08:17:13 -0400
Message-ID: <20040514092349.77206.qmail@web90105.mail.scd.yahoo.com>
Date: Fri, 14 May 2004 02:23:49 -0700 (PDT)
From: linux lover <linux_lover2004@yahoo.com>
Subject: question about ip_build_xmit
To: linuxkernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello ,
   In ip_output.c file there is ip_build_xmit function
call. when packet comes from tcp layer to IP layer
this function is called. In that i found that 
   skb = sock_alloc_send_skb(sk, length+hh_len+15
,flags&MSG_DONTWAIT, &err);
staement allocates skb for packet. after that i found
that no iphdr adding statement in ip_build_xmit. i
want to know where is iphdr push to skb? cause skb
works using first alloc_skb to allocate memory then
skb_reserve to reserve headroom then put data in skb
by skb_put or skb_push for pushing headers in skb. so
there i found       
  skb->nh.iph = iph = (struct iphdr *)skb_put(skb,
length); 
statement is this does that iphdr adding?

regards,
linuxlover


	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/
