Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132828AbQLNUDJ>; Thu, 14 Dec 2000 15:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132854AbQLNUCt>; Thu, 14 Dec 2000 15:02:49 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:520 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132828AbQLNUCm>;
	Thu, 14 Dec 2000 15:02:42 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012141931.WAA03039@ms2.inr.ac.ru>
Subject: Re: linux ipv6 questions.  bugs?
To: rmk@arm.linux.org.uk (Russell King)
Date: Thu, 14 Dec 2000 22:31:58 +0300 (MSK)
Cc: pete@research.NETsol.COM, linux-kernel@vger.kernel.org
In-Reply-To: <200012141210.eBECAiF06083@flint.arm.linux.org.uk> from "Russell King" at Dec 14, 0 12:10:43 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> sendto(3, "\200\0\0\0l\32\0\0\7\2678:YH\16\0\10\t\n\v\f\r\16\17\20"..., 64, 0, {sin_family=AF_INET6, sin6_port=htons(58), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=htonl(0)}}, 24) = 64
> setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={1, 0}}, NULL) = 0
> time(NULL)                              = 976795399
> recvmsg(3, 0xbffff9e4, 0)               = ? ERESTARTSYS (To be restarted)--- SIGALRM (Alarm clock) ---
> 
> - /proc/net/snmp6 (zero entries removed) -
> Ip6InReceives                   	6
> Ip6OutRequests                  	6
> Icmp6InMsgs                     	6
> Icmp6InEchos                    	3
> Icmp6InEchoReplies              	3
> Icmp6OutMsgs                    	15
> Icmp6OutEchoReplies             	3
> Icmp6OutRouterSolicits          	8
> Icmp6OutNeighborSolicits        	4

It is very interesting, indeed. I was going to suspect DNS,
now it is clear that the problem is not here.

I still have no guesses, what happened with you.


> little about this, but should I be able to ping6 these link addresses?

Yes, of course.


> bash-2.04# ping6 fe80::a00:2bff:fe95:1d7b
> connect: Invalid argument

Yes, of course. Link local address without interface is invalid.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
