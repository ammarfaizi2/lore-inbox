Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136685AbREGV4J>; Mon, 7 May 2001 17:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136684AbREGVz7>; Mon, 7 May 2001 17:55:59 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:2867 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S136681AbREGVzv>; Mon, 7 May 2001 17:55:51 -0400
Date: Mon, 7 May 2001 23:55:41 +0200
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Jesper Juhl <juhl@eisenstein.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch to improve readability of sock_rcvlowat() - comments wanted...
Message-ID: <20010507235541.Q4514@tux.bitfreak.net>
In-Reply-To: <3AF72A19.7030009@eisenstein.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3AF72A19.7030009@eisenstein.dk>; from juhl@eisenstein.dk on Tue, May 08, 2001 at 01:04:57 +0200
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.05.08 01:04:57 +0200 Jesper Juhl wrote:
> 
> static inline int sock_rcvlowat(struct sock *sk, int waitall, int len)
> {
>          int r = len;
>          if (!waitall)
>                  r = min(sk->rcvlowat, len);
>          return max(1,r);
> }
> 

return max(1, waitall ? len : min(sk->rcvlowat, len));

Although I doubt this is more readable... :-)

--
Ronald

