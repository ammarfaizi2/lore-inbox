Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271118AbRH1OnR>; Tue, 28 Aug 2001 10:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271124AbRH1OnH>; Tue, 28 Aug 2001 10:43:07 -0400
Received: from mailgw.netvision.net.il ([194.90.1.14]:8578 "EHLO
	mailgw1.netvision.net.il") by vger.kernel.org with ESMTP
	id <S271118AbRH1Om6>; Tue, 28 Aug 2001 10:42:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Aviv Greenberg <deca@netvision.net.il>
Reply-To: deca@netvision.net.il
To: linux-kernel@vger.kernel.org
Subject: TCP_IPV4_MATCH macro
Date: Tue, 28 Aug 2001 17:43:58 +0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01082817435800.06072@aviv_linuxddd>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In tcp.h line 238 :

#define TCP_IPV4_MATCH(__sk, __cookie, __saddr, __daddr, __ports, __dif)\
	(((__sk)->daddr			== (__saddr))	&&		\
	 ((__sk)->rcv_saddr		== (__daddr))	&&		\
	 ((*((__u32 *)&((__sk)->dport)))== (__ports))   &&		\
	 (!((__sk)->bound_dev_if) || ((__sk)->bound_dev_if == (__dif))))

the ((*((__u32 *)&((__sk)->dport))) part is nasty because it assumes that the 
next field in the structure is 'num'. Why not use the TCP_COMBINED_PORTS
for that.? There are other such nasties in the macros there. 

An alternative would be a nice comment in the sock structure.

Alexey ? DaveM ? Someone ? :)

-- 
	- Aviv Greeberg
