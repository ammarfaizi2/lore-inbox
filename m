Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbUDOBZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 21:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUDOBZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 21:25:39 -0400
Received: from web12505.mail.yahoo.com ([216.136.173.197]:42118 "HELO
	web12505.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262429AbUDOBZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 21:25:37 -0400
Message-ID: <20040415012536.61202.qmail@web12505.mail.yahoo.com>
Date: Wed, 14 Apr 2004 18:25:36 -0700 (PDT)
From: ZI ZHOU <zhouzi@yahoo.com>
Subject: HELP ! Why my dev->hard_start_xmit get called three times for one ping packet?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've written a ethernet device driver based on 2.6.4
sis190.c, and I am testing it on my 2.4.25 machine. I
am currently testing the transmit part and couldn't
figure out the scenorio I've seen. Can someone shed
some light PLEASE !

After I configure the ethernet interface(it's a PCI
card plugged in my debian PC), I run command ' ping -c
1 192.168.0.100', (the interface is configured with IP
address 192.168.0.35), I used smartbit to look at the
wire and found 3 ping packets. From the debugging
info, I can see dev->hard_start_xmit is called three
times, the DMA engine seems to be acting correctly,
and each time hard_start_xmit is invoked the skb
address is different. How can this happen? Could it be
sth related to tx timeout? I am not very clear about
what happens between IP send and dev->hard_start_xmit
besides knowing there is a queue for skb, and if
device is busy, the skb will be re-queued? Can someone
give me some idea about how the driver communicate
with the upper layer software about the status of its
transmit ? There used to be tbusy I remember, but I've
lost track of what happen there after.

Btw, I run different number of ping packets, here is
some result, Haven't been able to make sense out of it
yet.

ping -c 1/2/3  -> recv 3 packets
ping -c 4/5/6  -> recv 6 packets
ping -c 7      -> recv 8 packets

Thanks & your help is greatly appreciated !

Zi

 



	
		
__________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online by April 15th
http://taxes.yahoo.com/filing.html
