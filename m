Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132553AbRDLXkC>; Thu, 12 Apr 2001 19:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132612AbRDLXjw>; Thu, 12 Apr 2001 19:39:52 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27950 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132553AbRDLXjb>; Thu, 12 Apr 2001 19:39:31 -0400
Date: Fri, 13 Apr 2001 01:47:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: glouis@dynamicro.on.ca
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac5
Message-ID: <20010413014711.D930@athlon.random>
In-Reply-To: <E14njvB-0000xu-00@the-village.bc.nu> <20010412191726.A719@athame.dynamicro.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010412191726.A719@athame.dynamicro.on.ca>; from glouis@dynamicro.on.ca on Thu, Apr 12, 2001 at 07:17:26PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2001 at 07:17:26PM -0400, Greg Louis wrote:
> On 20010412 (Thu) at 1726:11 +0100, Alan Cox wrote:
> > 
> > 2.4.3-ac5
> 
> > o	Fix rwsem compile problem			(me)
> 
> No such luck, I fear, at least not with egcs-2.91.66:
> /usr/src/linux-2.4.3ac5/include/asm/rwsem.h:26: badly punctuated
> parameter list in #define'
> /usr/src/linux-2.4.3ac5/include/asm/rwsem.h: In function 'down_read':
> /usr/src/linux-2.4.3ac5/include/asm/rwsem.h:52: warning: implicit
> declaration of function 'rwsemdebug'

I didn't checked ac5 but this is how I fixed the UP compile problem of 4pre2:

--- 2.4.4pre2aa/include/asm-i386/rwsem.h.~1~	Thu Apr 12 17:25:24 2001
+++ 2.4.4pre2aa/include/asm-i386/rwsem.h	Thu Apr 12 17:38:10 2001
@@ -17,7 +17,7 @@
 
 #include <asm/system.h>
 #include <asm/atomic.h>
-#include <asm/spinlock.h>
+#include <linux/spinlock.h>
 #include <linux/wait.h>
 
 #if RWSEM_DEBUG

Andrea
