Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbTCPXMc>; Sun, 16 Mar 2003 18:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261648AbTCPXMc>; Sun, 16 Mar 2003 18:12:32 -0500
Received: from mailer.syr.edu ([128.230.18.29]:51062 "EHLO mailer.syr.edu")
	by vger.kernel.org with ESMTP id <S261646AbTCPXMb>;
	Sun, 16 Mar 2003 18:12:31 -0500
Subject: ip_check_sum problem
From: Norka Lucena <norka@ecs.syr.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Mar 2003 18:31:00 -0500
Message-Id: <1047857461.11087.73.camel@venus.csa.syr.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having problems computing the IP checksum with the th ip_fast_csum.
I would REALLY appreciate if any of you can help me.

This is the function I am using to compute the IP checksum.

void computeIPChecksum(struct iphdr* ip) {
  printk("*** IP checksum (before) : %d\n", ip->check);
  
  ip->check = 0;  /* it must be pre-zero'd */
  ip->check = ip_fast_csum((unsigned char *)ip, ip->ihl);

  printk("*** IP checksum (after)  : %d\n", ip->check);
}
 
Please notice that because I am not modifying the packet at all yet, I
should 
get the same result. Well, I don't. I have no clue why. 
Any thoughts?

Please, reply directly to norka@ecs.syr.edu.
Thank you so much, in advance,


Norka 




