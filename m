Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132285AbRCWA07>; Thu, 22 Mar 2001 19:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132286AbRCWA0k>; Thu, 22 Mar 2001 19:26:40 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58634 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132285AbRCWA03>; Thu, 22 Mar 2001 19:26:29 -0500
Subject: Re: [PATCH] gcc-3.0 warnings
To: jamagallon@able.es (J . A . Magallon)
Date: Fri, 23 Mar 2001 00:28:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <20010323011140.A1176@werewolf.able.es> from "J . A . Magallon" at Mar 23, 2001 01:11:41 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gFRT-0003f4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	page_cache_release(page);
> -out:

out:;

does that trick

> -	default:
> +	default:;

Agree - done

> --- linux-2.4.2-ac21/net/ipv4/icmp.c.orig	Thu Mar 22 23:39:22 2001
> +++ linux-2.4.2-ac21/net/ipv4/icmp.c	Thu Mar 22 23:42:23 2001

Again out:;

>  			goto error;
> -	default:
> +	default:;

Ok

The aic7xxx change looks right too. Someone with the hardware handy needs to
check that one though.

As to the asm - I'll apply it to -ac if you can verify the asm after changes
goes happily through the older gcc/binutils (should do) and send me a nice
clean diff of just those changes



