Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136802AbRECNRD>; Thu, 3 May 2001 09:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136803AbRECNQx>; Thu, 3 May 2001 09:16:53 -0400
Received: from c000-h009.c000.zsm.cp.net ([209.228.56.68]:60367 "HELO
	c000.zsm.cp.net") by vger.kernel.org with SMTP id <S136802AbRECNQl>;
	Thu, 3 May 2001 09:16:41 -0400
Date: 3 May 2001 06:16:36 -0700
Message-ID: <20010503131636.6397.cpmta@c000.zsm.cp.net>
X-Sent: 3 May 2001 13:16:36 GMT
Content-Type: text/plain; charset=unicode-1-1-utf-8
Content-Disposition: inline
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: rexyan@us.sina.com
X-Mailer: Web Mail 3.0
Subject: skbuff about skbuff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Does anyone know how to adjust the skb->h.raw, skb->nh.raw?
I'm going to add a shim header between layer2 header and layer3 header
	+--------+============+----------+--------
	|   L2   |   Shim     | L3       |   L4
	+--------+============+----------+--------
The code to insert the shim:

skb_push(skb, 4); /*say the size of shim is 4 bytes. */
memmove(skb->data, &shim, 4);

Do I need to adjust the skb->h.raw and skb->nh.raw? How to?

Thanks in advance,

Rex


_______________________________________________________________
http://www.SINA.com - #1 Destination Site for Chinese Worldwide
