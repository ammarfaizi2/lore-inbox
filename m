Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUKPRsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUKPRsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbUKPRsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:48:47 -0500
Received: from mail.netshadow.at ([217.116.182.106]:61645 "EHLO
	skeletor.netshadow.at") by vger.kernel.org with ESMTP
	id S262071AbUKPRr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:47:27 -0500
Subject: Re: 2.6 native IPsec implementation question
From: Andreas Unterkircher <unki@netshadow.at>
Reply-To: unki@netshadow.at
To: linux-kernel@vger.kernel.org
Cc: Blizbor <kernel@globalintech.pl>
In-Reply-To: <4198B2B6.9050803@globalintech.pl>
References: <4198B2B6.9050803@globalintech.pl>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 18:47:05 +0100
Message-Id: <1100627225.1817.1.camel@kuecken.unki.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI: openswan is working on a rebirth of klips (ipsecX interfaces)
for 2.6 kernels

http://www.openswan.org/

Andi

Am Montag, den 15.11.2004, 14:44 +0100 schrieb Blizbor:
> Greetings,
> 
> I hope, this is right place to ask my questions.
> 
> 1. Why IPsec in 2.6 doesn't uses separate interface ?
> It makes impossible to implement firewall logic like this (or I'm 
> missing something):
> 
> incoming from eth0 allow AH
> incoming from eth0 allow ESP
> incoming from eth0 allow udp 500
> incoming from eth0 allow udp 53
> incoming from eth0 allow ICMP related
> incoming from eth0 deny all
> 
> then set of filters restricting traffic incoming via IPsec for examle:
> incoming from ipsec0 allow tcp 389
> incoming from ipsec0 allow ICMP related
> incoming from ipsec0 deny all
> 
> (please consider roadwarrior client with not known IP address)
> 
> 2. Why IPsec in 2.6 doesn't creates entries in the route tables ?
> It's a bit confusing when 'ip route list' doesnt makes you aware that
> some traffic is going somwhere else than defined in route tables.
> 
> (you must know that there is IPsec in use on the host, then you are using
> setkey to list rules, and then you must analyse rules to catch routes - 
> ugly solution.)
> 
> 
> Reards,
> Blizbor
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

