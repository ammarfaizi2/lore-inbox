Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263578AbTCUKyz>; Fri, 21 Mar 2003 05:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263580AbTCUKyz>; Fri, 21 Mar 2003 05:54:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:64193 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263578AbTCUKyy>;
	Fri, 21 Mar 2003 05:54:54 -0500
Date: Fri, 21 Mar 2003 03:05:40 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm3
Message-Id: <20030321030540.598ebca5.akpm@digeo.com>
In-Reply-To: <87znnp3s1h.fsf@lapper.ihatent.com>
References: <20030320235821.1e4ff308.akpm@digeo.com>
	<87znnp3s1h.fsf@lapper.ihatent.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2003 11:05:41.0146 (UTC) FILETIME=[CF94B7A0:01C2EF99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> wrote:
>
> Andrew Morton <akpm@digeo.com> writes:
> >
> > [SNIP]
> >
>
> ... 
> make[4]: *** [net/ipv4/netfilter/ip_conntrack_core.o] Error 1

Bah, sorry.

--- 25/net/ipv4/netfilter/ip_conntrack_core.c~a	2003-03-21 03:04:45.000000000 -0800
+++ 25-akpm/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-21 03:04:48.000000000 -0800
@@ -274,7 +274,7 @@ static void remove_expectations(struct i
 		 * the un-established ones only */
 		if (exp->sibling) {
 			DEBUGP("remove_expectations: skipping established %p of %p\n", exp->sibling, ct);
-			exp->sibling =3D NULL;
+			exp->sibling = NULL;
 			continue;
 		}
 

_

