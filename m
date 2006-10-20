Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWJTMnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWJTMnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWJTMnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:43:33 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:677 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S964805AbWJTMnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:43:32 -0400
Date: Fri, 20 Oct 2006 06:43:31 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061020124331.GV2602@parisc-linux.org>
References: <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk> <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org> <20061018160609.GO29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org> <20061020005337.GV29920@ftp.linux.org.uk> <20061020005737.GW29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020005737.GW29920@ftp.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 01:57:37AM +0100, Al Viro wrote:
> That's just a dead weight these days

Agreed.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/arch/parisc/kernel/unwind.c b/arch/parisc/kernel/unwind.c
index 920bdbf..9c98ed2 100644
--- a/arch/parisc/kernel/unwind.c
+++ b/arch/parisc/kernel/unwind.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/kallsyms.h>
 
diff --git a/include/asm-parisc/uaccess.h b/include/asm-parisc/uaccess.h
index d973e8b..2e87e82 100644
--- a/include/asm-parisc/uaccess.h
+++ b/include/asm-parisc/uaccess.h
@@ -4,7 +4,6 @@ #define __PARISC_UACCESS_H
 /*
  * User space memory access functions
  */
-#include <linux/sched.h>
 #include <asm/page.h>
 #include <asm/system.h>
 #include <asm/cache.h>
