Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129334AbRAYXcE>; Thu, 25 Jan 2001 18:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbRAYXbv>; Thu, 25 Jan 2001 18:31:51 -0500
Received: from linuxcare.com.au ([203.29.91.49]:58127 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129334AbRAYXbk>; Thu, 25 Jan 2001 18:31:40 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Fri, 26 Jan 2001 10:19:21 +1100
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [UPDATE] Zerocopy, last one today I promise :-)
Message-ID: <20010126101921.A16670@linuxcare.com>
In-Reply-To: <14960.13645.936452.235135@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <14960.13645.936452.235135@pizda.ninka.net>; from davem@redhat.com on Thu, Jan 25, 2001 at 06:16:45AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> o If sock_writepage is called on path via device without SG support,
>   the cooked up sock_sendmsg() call needs to switch to KERNEL_DS.
>   Discovered and fixed by Ingo Molnar.

Good catch.

> This does show that not too many people are testing this all that
> thoroughly :-) Basically, any sys_sendfile() over TCP using a network
> card other than loopback/3c59x/sunhme/acenic would fail with -EFAULT
> or even worse a kernel crash depending upon architecture.

Hey now, I was seeing it but I hadn't got around to chasing the bug down. :)

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
