Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbVI2LlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVI2LlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 07:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVI2LlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 07:41:21 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:5312 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP
	id S1750876AbVI2LlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 07:41:21 -0400
Date: Thu, 29 Sep 2005 13:41:17 +0200
Message-Id: <1976447075@web.de>
MIME-Version: 1.0
From: Joachim Bremer <joachim.bremer@web.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rcX: strange timestamp on ping
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

since very early in the 2.6.14 process ping or traceroute gives very
strange timestamps. eg 
64 bytes from 192.168.0.1: icmp_seq=1 ttl=127 time=4294971590970 ms

Translating the time to hex gives something like 0x03e8 xxxx xxxx which
make me wonder a little. This was introduced by the patch:

[NET]: Store skb->timestamp as offset to a base timestamp

Reduces skb size by 8 bytes on 64-bit.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>

---
commit a61bbcf28a8cb0ba56f8193d512f7222e711a294
tree 33ae1976ab3b08aac516debb2742d2c6696d5436
parent 25ed891019b84498c83903ecf53df7ce35e9cff6


I checked this on two machines. Both where equipped with Opteron processors
in 64bit mode. Using gcc 3.4.3, 4.0.1 and 4.0.2 gives exactly the same reults.
Reverting that patch restores the correct timestamping

Bye

Joachim

______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193

