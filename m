Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbUKONo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUKONo3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 08:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbUKONo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 08:44:29 -0500
Received: from ip126.globalintech.pl ([62.89.81.126]:31989 "EHLO
	MAILSERVER.dmz.globalintech.pl") by vger.kernel.org with ESMTP
	id S261595AbUKONoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 08:44:23 -0500
Message-ID: <4198B2B6.9050803@globalintech.pl>
Date: Mon, 15 Nov 2004 14:44:22 +0100
From: Blizbor <kernel@globalintech.pl>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6 native IPsec implementation question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2004 13:44:22.0458 (UTC) FILETIME=[36A461A0:01C4CB19]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I hope, this is right place to ask my questions.

1. Why IPsec in 2.6 doesn't uses separate interface ?
It makes impossible to implement firewall logic like this (or I'm 
missing something):

incoming from eth0 allow AH
incoming from eth0 allow ESP
incoming from eth0 allow udp 500
incoming from eth0 allow udp 53
incoming from eth0 allow ICMP related
incoming from eth0 deny all

then set of filters restricting traffic incoming via IPsec for examle:
incoming from ipsec0 allow tcp 389
incoming from ipsec0 allow ICMP related
incoming from ipsec0 deny all

(please consider roadwarrior client with not known IP address)

2. Why IPsec in 2.6 doesn't creates entries in the route tables ?
It's a bit confusing when 'ip route list' doesnt makes you aware that
some traffic is going somwhere else than defined in route tables.

(you must know that there is IPsec in use on the host, then you are using
setkey to list rules, and then you must analyse rules to catch routes - 
ugly solution.)


Reards,
Blizbor
