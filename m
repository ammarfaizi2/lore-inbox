Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267445AbTBLSOh>; Wed, 12 Feb 2003 13:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTBLSOg>; Wed, 12 Feb 2003 13:14:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:27616 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267445AbTBLSOc>;
	Wed, 12 Feb 2003 13:14:32 -0500
Date: Wed, 12 Feb 2003 10:24:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: <larry@minfin.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange TCP with 2.5.60
Message-Id: <20030212102418.3a15b4a8.akpm@digeo.com>
In-Reply-To: <000801c2d28d$376df550$1504a8c0@larry2>
References: <000801c2d28d$376df550$1504a8c0@larry2>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Feb 2003 18:24:13.0361 (UTC) FILETIME=[F1995A10:01C2D2C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kostadin Karaivanov" <larry@minfin.bg> wrote:
>
> Trying to use traceroute i get folowing error:
> ...
> 
> Networking works....... but command route can't give me the status of
> default route:
> ...
> iptables doesn't work as expected too.....
> ...
> everything works fine with 2.5.59 and 2.4.20

Could you pelase retest with this patch, and tell us how many of these
problems go away?

diff -puN net/ipv4/fib_hash.c~a net/ipv4/fib_hash.c
--- 25/net/ipv4/fib_hash.c~a	2003-02-12 10:23:55.000000000 -0800
+++ 25-akpm/net/ipv4/fib_hash.c	2003-02-12 10:24:00.000000000 -0800
@@ -941,7 +941,7 @@ static __inline__ struct fib_node *fib_g
 
 			if (!iter->zone)
 				goto out;
-			if (iter->zone->fz_next)
+			if (iter->zone->fz_next);
 				break;
 		}
 		

_

