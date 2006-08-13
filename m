Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWHMQS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWHMQS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 12:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWHMQS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 12:18:28 -0400
Received: from vmail.comtv.ru ([217.10.32.17]:30153 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id S1751299AbWHMQS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 12:18:27 -0400
X-UCL: actv
Message-ID: <44DF4275.8A68AAC@inCTV.ru>
Date: Sun, 13 Aug 2006 15:17:09 +0000
From: Innocenti Maresin <qq@inCTV.ru>
Organization: [ =?KOI8-R?Q?=DA=C1_IP_=C2=C5=DA_=C3=C5=CE=DA=D5=D2=D9?= ] 
 http://internet.comtv.ru/
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.6.13-rc6 i686)
X-Accept-Language: ru, fr, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4 - net/ipv4/route.c/ip_route_output_slow()
References: <LKML-nat-0.qq@inCTV.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, my dear kernel coding gurus. 
You have almost nothing to say about "internal IP addresses" and "connect() failures". 
Let me swicth the question's language :) 
Please, help with the function ip_route_output_slow() in net/ipv4/route.c. 
There is such code as:
        if (res.type == RTN_NAT)
                goto e_inval;

In late 2.4 it is line 1922 (2.6 is irrelevant because of elimination of RTN_NAT). 
I realize that this condition means, at least, an explicit ban 
on all attempts to use RTN_NATted destination addresses in connect(), 
so the kernel fails before the process (or the transport level) attempts to send any packet. 
Please, tell me, what value should return this function by design 
and what is the difference between it and a similar situation in ip_route_input_slow() 
where fib_rules_map_destination() is called instead of just failing. 
For what reasons (religious, I think) locally generated packets 
may not be RTN_NATted in a manner similar to the routing of forwarding traffic? 

Thank you for your attention.


-- 
qq~~~~\	
/ /\   \
\  /_/ /
 \____/
