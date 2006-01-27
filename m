Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWA0QGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWA0QGQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 11:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWA0QGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 11:06:15 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:17362 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751498AbWA0QGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 11:06:14 -0500
Message-ID: <43DA447D.7050205@t-online.de>
Date: Fri, 27 Jan 2006 17:04:13 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller
 11ab:4362 (rev 19)
References: <E1F1UqC-0002XE-00@gondolin.me.apana.org.au> <43D9B8A6.5020200@t-online.de> <20060127122242.GA32128@gondor.apana.org.au>
In-Reply-To: <20060127122242.GA32128@gondor.apana.org.au>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: VsOGr-ZCreuWJHbIb+8jDSU5ShyTXYNnAG-cfTt+LQj6yY5ct4Wywi@t-dialin.net
X-TOI-MSGID: c4d08d78-67e7-4bc9-be64-100fdfaf0fa6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

>When we pull the PPP protocol off the skb, we forgot to update the
>hardware RX checksum.  This may lead to messages such as
>
>	dsl0: hw csum failure.
>
>Similarly, we need to clear the hardware checksum flag when we use
>the existing packet to store the decompressed result.
>
>Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>

ACK

That patch seems to solve all my problems with 
sky2 / pppoe / SuSE 9.2 Firewall. 

Thanks a lot!

cu,
 Knut

