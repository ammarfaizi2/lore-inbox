Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264967AbSJWNG7>; Wed, 23 Oct 2002 09:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSJWNG6>; Wed, 23 Oct 2002 09:06:58 -0400
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:23814 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S264967AbSJWNG5>; Wed, 23 Oct 2002 09:06:57 -0400
To: linux-kernel@vger.kernel.org
Subject: How to make routing decision from kernel module ?
From: ut4q@stud.uni-karlsruhe.de
Reply-To: ut4q@stud.uni-karlsruhe.de
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP3 Imap webMail Program 2.0.11
Message-Id: <E184LJq-0005C1-00@ssl4.rz.uni-karlsruhe.de>
Date: Wed, 23 Oct 2002 15:13:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi ALL, 

we are a small study group at university of karlsruhe (germany) 
and working on a modular ipsec implementation for linux. 

One goal of the implementation is to avoid changes to the 
original kernel, the complete ipsec implementation is 
realized as kernel modules.  

In our implementation we receive an skb/ip packet
(by NF_IP_PRE_ROUTING netfilter hook) and must know, 
if the packet is for the local machine. So we need to make 
a routing decision, but we only need the result of the 
routing decision, not the routing itself.

(yes, we MUST do this in NF_IP_PRE_ROUTING hook, LOCAL_IN is slightly to late)

First attempt was using ip_route_input() and compare 
skb.dst with ip_local_deliver/ip_forward. This fails 
because of unexported symbols in the kernel (ip_local_deliver/ip_forward). 

Next trial was using fib_lookup(), but it fails also
due unexported symbols.


Now we are a little bit frustrated and dont know how to make 
a routing decision (that we can analyse) inside a kernel module.

Is there a possibillity to make a routing lookup from a kernel module 
without hacking the kernel ? 


thanks for your help 

    Michael Conrad
