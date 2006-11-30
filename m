Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030572AbWK3Ppi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbWK3Ppi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 10:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030594AbWK3Ppi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 10:45:38 -0500
Received: from il.qumranet.com ([62.219.232.206]:28821 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1030572AbWK3Pph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 10:45:37 -0500
Message-ID: <456EFC9F.9060607@argo.co.il>
Date: Thu, 30 Nov 2006 17:45:35 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kswapd/tg3 issue
References: <20061130144355.GK2021@washoe.onerussian.com>	<20061130150406.3d0b6afd@localhost.localdomain>	<20061130151003.GM2021@washoe.onerussian.com> <20061130153906.59d78223@localhost.localdomain>
In-Reply-To: <20061130153906.59d78223@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> Under heavy network or I/O pressure it may not have time to swap to get
> the memory. Thus adding swap won't usually help. Adding RAM may do but
> its often not the best answer. Arjan's suggestion should sort it, and -
> yes typically boxes with very high I/O and network load need more of a
> pool of memory free for immediate use than other systems.
>   

It could be nice if the kernel could autotune this, for example by 
raising the free memory goal when memory shortage is detected, and 
lowering it gradually when not.

The sysctl could be a minimum from which this is calculated.

-- 
error compiling committee.c: too many arguments to function

