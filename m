Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130692AbQKQDVY>; Thu, 16 Nov 2000 22:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130842AbQKQDVO>; Thu, 16 Nov 2000 22:21:14 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:10742 "HELO
	halfway.linuxcare.com.au") by vger.kernel.org with SMTP
	id <S130667AbQKQDVG>; Thu, 16 Nov 2000 22:21:06 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Dan Aloni <karrde@callisto.yi.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netfilter@us5.samba.org
Subject: Re: (iptables) ip_conntrack bug? 
In-Reply-To: Your message of "Thu, 16 Nov 2000 01:42:14 +0200."
             <Pine.LNX.4.21.0011160131050.18364-100000@callisto.yi.org> 
Date: Fri, 17 Nov 2000 13:50:56 +1100
Message-Id: <20001117025056.6C92E813F@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.21.0011160131050.18364-100000@callisto.yi.org> you write
:
> I think I got something, icmp_error_track() increases the use count
> (calling ip_conntrack_find_get()) when it returns with no error (not NULL). 

The reference count is now held by the skb.

Hope that helps,
Rusty.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
