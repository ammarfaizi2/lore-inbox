Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286893AbSAXKJr>; Thu, 24 Jan 2002 05:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286904AbSAXKJi>; Thu, 24 Jan 2002 05:09:38 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:54431 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S286895AbSAXKJZ>; Thu, 24 Jan 2002 05:09:25 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 24 Jan 2002 02:09:22 -0800
Message-Id: <200201241009.CAA00324@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Patch: linux-2.5.3-pre4/net/ipv4/netfilter/ipfwadm_core.c typo fixes to make it compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.5.3-pre4/net/ipv4/netfilter/ipfwadm_core.c incorrectly
contained parentheses after uses of the MOD_{INC,DEC}_USE_COUNT macros.
This causes it to fail to compile.  It is not clear to me who
the maintainer of this file is.  So, I apologize for not including
that person directly in this email.

	Here is the patch.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--- linux-2.5.3-pre4/net/ipv4/netfilter/ipfwadm_core.c	Thu Jan 24 01:38:47 2002
+++ linux/net/ipv4/netfilter/ipfwadm_core.c	Thu Jan 24 01:27:58 2002
@@ -688,7 +688,7 @@
 		ftmp = *chainptr;
 		*chainptr = ftmp->fw_next;
 		kfree(ftmp);
-		MOD_DEC_USE_COUNT();
+		MOD_DEC_USE_COUNT;
 	}
 	restore_flags(flags);
 }
@@ -732,7 +732,7 @@
 	ftmp->fw_next = *chainptr;
        	*chainptr=ftmp;
 	restore_flags(flags);
-	MOD_INC_USE_COUNT();
+	MOD_INC_USE_COUNT;
 	return(0);
 }
 
@@ -783,7 +783,7 @@
 	else
         	*chainptr=ftmp;
 	restore_flags(flags);
-	MOD_INC_USE_COUNT();
+	MOD_INC_USE_COUNT;
 	return(0);
 }
 
@@ -858,7 +858,7 @@
 	}
 	restore_flags(flags);
 	if (was_found) {
-		MOD_DEC_USE_COUNT();
+		MOD_DEC_USE_COUNT;
 		return 0;
 	} else
 		return(EINVAL);
