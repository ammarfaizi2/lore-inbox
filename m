Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263399AbRFAHvk>; Fri, 1 Jun 2001 03:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263402AbRFAHva>; Fri, 1 Jun 2001 03:51:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16389 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263400AbRFAHvR>; Fri, 1 Jun 2001 03:51:17 -0400
Subject: Re: [CHECKER] 2.4.5-ac4 use of freed pointers
To: engler@csl.Stanford.EDU (Dawson Engler)
Date: Fri, 1 Jun 2001 08:48:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200106010452.VAA17405@csl.Stanford.EDU> from "Dawson Engler" at May 31, 2001 09:52:49 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155jfv-00009w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	if (!rose_route_frame(skbn, NULL)) {
> Start --->
> 		kfree_skb(skbn);
> 		stats->tx_errors++;

Missing return - fixed

> [BUG] frees then uses the next pointer.
> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/wan/lapbether.c:101:lapbeth_check_devices: ERROR:FREE:113:101: Use-after-free of 'lapbeth'! set by 'kfree':113
> 	save_flags(flags);

Fixed

> [BUG] frees then uses the next pointer.
> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/hamradio/bpqether.c:178:bpq_check_devices: ERROR:FREE:193:178: Use-after-free of 'bpq'! set by 'kfree':193
> 	save_flags(flags);
>

Fixed
 	cli();

