Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbULaMyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbULaMyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 07:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbULaMyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 07:54:38 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:63969 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261989AbULaMyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 07:54:35 -0500
Message-ID: <41D54BA3.70403@t-online.de>
Date: Fri, 31 Dec 2004 13:52:51 +0100
From: mikeb1@t-online.de (Michael Berger)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cal Peake <cp@absolutedigital.net>, linux-kernel@vger.kernel.org
Subject: Re: Compile error in kernel 2.6.10-bk3 in file slhc.c
References: <3hbOM-43L-21@gated-at.bofh.it> <41D5009E.4090100@t-online.de> <297f4e0104123102571bb1759f@mail.gmail.com> <Pine.LNX.4.61.0412310614320.6599@lancer.cnet.absolutedigital.net>
In-Reply-To: <Pine.LNX.4.61.0412310614320.6599@lancer.cnet.absolutedigital.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: Xd0JGqZaweWN--dny80SR5G0UsM2g0aAGiYnvNCPRTvcJZ+5oXMM0d
X-TOI-MSGID: f71889ec-8d1b-4ba5-8ee2-84e26709a9f2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal Peake wrote:

>On Fri, 31 Dec 2004, Ikke wrote:
>
>  
>
>>Could you point me to the patch please?
>>    
>>
>
>at:
>
>http://linux.bkbits.net:8080/linux-2.5/cset@1.2082?nav=index.html|ChangeSet@-1d
>
>and below.
>
>-- Cal
>
># This is a BitKeeper generated diff -Nru style patch.
>#
># ChangeSet
>#   2004/12/30 15:21:16-08:00 acme@conectiva.com.br 
>#   [PATCH] Fix net/core/sock.o build failure
>#   
>#   This fixes a build failure that happens when you don't select IPV6.
>#   
>#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
># 
># include/linux/ipv6.h
>#   2004/12/29 14:22:45-08:00 acme@conectiva.com.br +1 -1
>#   Fix net/core/sock.o build failure
># 
>diff -Nru a/include/linux/ipv6.h b/include/linux/ipv6.h
>--- a/include/linux/ipv6.h	2004-12-31 03:15:16 -08:00
>+++ b/include/linux/ipv6.h	2004-12-31 03:15:16 -08:00
>@@ -273,6 +273,7 @@
> 	struct ipv6_pinfo inet6;
> };
> 
>+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> static inline struct ipv6_pinfo * inet6_sk(const struct sock *__sk)
> {
> 	return inet_sk(__sk)->pinet6;
>@@ -283,7 +284,6 @@
> 	return &((struct raw6_sock *)__sk)->raw6;
> }
> 
>-#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> #define __ipv6_only_sock(sk)	(inet6_sk(sk)->ipv6only)
> #define ipv6_only_sock(sk)	((sk)->sk_family == PF_INET6 && __ipv6_only_sock(sk))
> #else
>
>  
>
Dear Cal

Thank you. I already received the same patch and found it also posted at 
the LKML. Kernel 2.6.10-bk3 is up now for 17+ hours.

Good work LKML

--Michael
