Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286470AbRLTXYw>; Thu, 20 Dec 2001 18:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286471AbRLTXYm>; Thu, 20 Dec 2001 18:24:42 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:13577 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S286470AbRLTXYf>;
	Thu, 20 Dec 2001 18:24:35 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200112201805.VAA11727@ms2.inr.ac.ru>
Subject: Re: TCP with IPv6 always refuses timestamps
To: Mika.Liljeberg@nokia.com
Date: Thu, 20 Dec 2001 21:05:43 +0300 (MSK)
Cc: davem@redhat.com, Mika.Liljeberg@welho.com, linux-kernel@vger.kernel.org
In-Reply-To: <F5FEAC407A690E42BD26E4F145301942AC64A1@esebe002.NOE.Nokia.com> from "Mika.Liljeberg@nokia.com" at Dec 20, 1 12:11:44 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Another bug found.

This is easy, fortunately.

Alexey


--- ../vger3-011203/linux/net/ipv6/tcp_ipv6.c	Sat Nov 10 21:45:08 2001
+++ linux/net/ipv6/tcp_ipv6.c	Thu Dec 20 20:58:06 2001
@@ -1172,6 +1180,7 @@
 
 	tcp_parse_options(skb, &tp, 0);
 
+	tp.tstamp_ok = tp.saw_tstamp;
 	tcp_openreq_init(req, &tp, skb);
 
 	req->class = &or_ipv6;
