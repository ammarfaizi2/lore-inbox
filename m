Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286653AbRLVDTy>; Fri, 21 Dec 2001 22:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286654AbRLVDTp>; Fri, 21 Dec 2001 22:19:45 -0500
Received: from f12.law8.hotmail.com ([216.33.241.12]:5896 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S286653AbRLVDTa>;
	Fri, 21 Dec 2001 22:19:30 -0500
X-Originating-IP: [24.45.107.83]
From: "se d" <seandarcy@hotmail.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 build fails at network.o
Date: Fri, 21 Dec 2001 22:19:24 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F12JYBLxLlF8KCM80NP0000a130@hotmail.com>
X-OriginalArrivalTime: 22 Dec 2001 03:19:25.0005 (UTC) FILETIME=[74F5DFD0:01C18A97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nope. Inserted the one line fix. Tried again. Same problem.

jay


>From: "David S. Miller" <davem@redhat.com>
>To: seandarcy@hotmail.com
>CC: linux-kernel@vger.kernel.org
>Subject: Re: 2.4.17 build fails at network.o
>Date: Fri, 21 Dec 2001 18:49:01 -0800 (PST)
>
>
>This should fix it:
>
>--- net/sunrpc/sched.c.~1~	Fri Oct 12 18:47:31 2001
>+++ net/sunrpc/sched.c	Fri Dec 21 18:48:09 2001
>@@ -21,6 +21,7 @@
>  #include <linux/spinlock.h>
>
>  #include <linux/sunrpc/clnt.h>
>+#include <linux/sunrpc/xprt.h>
>
>  #ifdef RPC_DEBUG
>  #define RPCDBG_FACILITY		RPCDBG_SCHED
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/




_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

