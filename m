Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVGHLUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVGHLUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVGHLUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:20:41 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:21681 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262524AbVGHLSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:18:42 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Michael Tokarev <mjt@tls.msk.ru>, linux-os@analogic.com
Subject: Re: sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0 on lo?
Date: Fri, 8 Jul 2005 14:18:01 +0300
User-Agent: KMail/1.5.4
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42CBCEDD.2020401@tls.msk.ru> <Pine.LNX.4.61.0507070801080.9558@chaos.analogic.com> <42CD289B.5080403@tls.msk.ru>
In-Reply-To: <42CD289B.5080403@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507081418.01686.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is, I can't see what is causing this misconfiguration
> or whatever.  I wasn't able to capture such a packet so far either --
> it never happened while tcpdump was running.

You may try to add printk("bad boy is: %s\n", current()->comm)),
or dump_stack(), or something like that in icmp path of IP stack.
(I am currently tracking an intermittent network problem
on my home box in similar way).

>  Note the local IP address mentioned is different, I've
> seen 3 so far, all 3 are local on this box and are on 3
> different (ethernet) interfaces (but the ICMP always comes
> from lo).

BTW what tcpdump actually shows?
--
vda

