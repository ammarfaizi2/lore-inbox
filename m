Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262726AbSJCDtz>; Wed, 2 Oct 2002 23:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262729AbSJCDtz>; Wed, 2 Oct 2002 23:49:55 -0400
Received: from dino.conectiva.com.br ([200.250.58.152]:19730 "EHLO
	dino.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262726AbSJCDty>; Wed, 2 Oct 2002 23:49:54 -0400
From: acme@conectiva.com.br
To: yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Allow Both IPv6 and IPv4 Sockets on the Same Port Number (IPV6_V6ONLY Support)
Message-ID: <1033617319.3d9bbfa7cd15e@webmail.conectiva.com.br>
Date: Thu, 03 Oct 2002 00:55:19 -0300 (BRST)
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
References: <20021003.121350.119660876.yoshfuji@linux-ipv6.org>
In-Reply-To: <20021003.121350.119660876.yoshfuji@linux-ipv6.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>: 
 
 
> +	 (((a)->s6_addr32[2]) == __constant_htonl(0x0000ffff))) 
 
Please use plain htonl, __constant_htonl is only needed in static 
initializations, in all other cases with constants as a parameter it 
generates the same code as htonl, so lets prefer using the shorter, 
more readable format. 
 
- Arnaldo 
 
