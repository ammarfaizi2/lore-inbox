Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbTDOOjR (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbTDOOjR 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:39:17 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:14535 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261488AbTDOOjQ (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 10:39:16 -0400
Message-ID: <3E9C1C4C.2030406@nortelnetworks.com>
Date: Tue, 15 Apr 2003 10:50:52 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to configure an ethernet dev as PtP ?
References: <20030415102109.4802ddd0.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> Hello all,
> 
> I tried to configure an ethernet device as a pointopoint link recently, just to
> find out that this does not work as one would expect via:
> 
> ifconfig eth0 192.168.1.1 pointopoint 192.168.5.1 up

How about:

/sbin/ip ad ad 192.168.1.1 peer 192.168.5.1 dev eth0

this gives:

# /sbin/ip ad
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
     link/ether 00:06:5b:a2:b3:8a brd ff:ff:ff:ff:ff:ff
     inet 192.168.1.1 peer 192.168.5.1/32 scope global eth0

Does that do what you want?


Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

