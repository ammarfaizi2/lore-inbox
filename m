Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAYApd>; Wed, 24 Jan 2001 19:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135301AbRAYApS>; Wed, 24 Jan 2001 19:45:18 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:6408 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S135276AbRAYApK>; Wed, 24 Jan 2001 19:45:10 -0500
Date: Wed, 24 Jan 2001 18:45:00 -0600
To: "J . A . Magallon" <jamagallon@able.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Justin T . Gibbs" <gibbs@scsiguy.com>
Subject: Re: warning in 2.4.1pre10
Message-ID: <20010124184500.B6941@cadcamlab.org>
In-Reply-To: <20010125004454.C930@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010125004454.C930@werewolf.able.es>; from jamagallon@able.es on Thu, Jan 25, 2001 at 12:44:54AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[J. A. Magallon]
> It is harmless, 'cause the last sentence in the funtion is a panic,
> but it is good to add the 'return 0', just to shut up the compiler.

The correct fix is __attribute__((noreturn)) in the panic() prototype.
As it happens, this has already been done....

Peter

--- 2.3.99pre4pre2/include/linux/raid/md_k.h~	Thu Feb 24 22:02:59 2000
+++ 2.3.99pre4pre2/include/linux/raid/md_k.h	Wed Jan 24 18:40:28 2001
@@ -15,6 +15,8 @@
 #ifndef _MD_K_H
 #define _MD_K_H
 
+#include <linux/kernel.h>	// for panic()
+
 #define MD_RESERVED       0UL
 #define LINEAR            1UL
 #define STRIPED           2UL
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
