Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129557AbRABAAb>; Mon, 1 Jan 2001 19:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbRABAAM>; Mon, 1 Jan 2001 19:00:12 -0500
Received: from linuxcare.com.au ([203.29.91.49]:13829 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129557AbRABAAJ>; Mon, 1 Jan 2001 19:00:09 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Mark James <mrj@cs.usyd.edu.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: netfilter enum conflict? 
In-Reply-To: Your message of "Tue, 02 Jan 2001 04:49:32 +1100."
             <3A50C32C.91350CB@cs.usyd.edu.au> 
Date: Tue, 02 Jan 2001 10:29:13 +1100
Message-Id: <E14DEO9-0001GI-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3A50C32C.91350CB@cs.usyd.edu.au> you write:
> Hi:
> 
> include/linux/netfilter_ipv4.h and include/linux/netfilter_ipv6.h
> both define enum nf_ip_hook_priorities.  This trips the compiler
> if both are included.  Should one change to nf_ipv6_hook_priorities?

Yes.  Only noone has ever included both yet.

Rusty.
--
Hacking time.

--- working-2.4.0-test13-3/include/linux/netfilter_ipv6.h.~1~	Tue May 23 02:50:55 2000
+++ working-2.4.0-test13-3/include/linux/netfilter_ipv6.h	Tue Jan  2 10:27:51 2001
@@ -54,7 +54,7 @@
 #define NF_IP6_NUMHOOKS		5
 
 
-enum nf_ip_hook_priorities {
+enum nf_ip6_hook_priorities {
 	NF_IP6_PRI_FIRST = INT_MIN,
 	NF_IP6_PRI_CONNTRACK = -200,
 	NF_IP6_PRI_MANGLE = -150,
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
