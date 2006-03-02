Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752011AbWCBRLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbWCBRLc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbWCBRLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:11:32 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:56784 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752011AbWCBRLb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:11:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=X8VqR75tpUtyxwdQNj6JbWm0KtIl2laCEGums89EBJvlUBtYY06tFRE1gg0HhLfB7KDF0XXytzACuR0K/j7bPy7TsDRdsM0pMKjMwarm5qGw9mbOgNCRf65zsk5CGMFxzd/8oTbXWX6LWNqOUnXcYrrr1VSFlAzIYmwjqT92ZA0=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Steffen Weber <email@steffenweber.net>
Subject: Re: Another compile problem with 2.6.15.5 on AMD64
Date: Thu, 2 Mar 2006 18:11:50 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <44071AF3.1010400@steffenweber.net>
In-Reply-To: <44071AF3.1010400@steffenweber.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603021811.50765.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 17:18, Steffen Weber wrote:
> I´m getting a compile error with 2.6.15.5 on x86_64 using GCC 3.4.4 
> (does not seem to be related to the NFS one):
> 
>    CC      mm/mempolicy.o
> mm/mempolicy.c: In function `get_nodes':
> mm/mempolicy.c:527: error: `BITS_PER_BYTE' undeclared (first use in
> this function)
> mm/mempolicy.c:527: error: (Each undeclared identifier is reported only
> once
> mm/mempolicy.c:527: error: for each function it appears in.)
> 

Try the following (untested patch).


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 mm/mempolicy.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.5/mm/mempolicy.c~	2006-03-02 18:05:18.000000000 +0100
+++ linux-2.6.15.5/mm/mempolicy.c	2006-03-02 18:05:18.000000000 +0100
@@ -82,7 +82,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/compat.h>
-#include <linux/mempolicy.h>
+#include <linux/types.h>
 #include <asm/tlbflush.h>
 #include <asm/uaccess.h>
 



