Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286646AbRLVCuH>; Fri, 21 Dec 2001 21:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbRLVCt4>; Fri, 21 Dec 2001 21:49:56 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8089 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286646AbRLVCtm>;
	Fri, 21 Dec 2001 21:49:42 -0500
Date: Fri, 21 Dec 2001 18:49:01 -0800 (PST)
Message-Id: <20011221.184901.66657527.davem@redhat.com>
To: seandarcy@hotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 build fails at network.o
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <F236jsdO0S5MVdnE0bN0000a020@hotmail.com>
In-Reply-To: <F236jsdO0S5MVdnE0bN0000a020@hotmail.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This should fix it:

--- net/sunrpc/sched.c.~1~	Fri Oct 12 18:47:31 2001
+++ net/sunrpc/sched.c	Fri Dec 21 18:48:09 2001
@@ -21,6 +21,7 @@
 #include <linux/spinlock.h>
 
 #include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/xprt.h>
 
 #ifdef RPC_DEBUG
 #define RPCDBG_FACILITY		RPCDBG_SCHED
