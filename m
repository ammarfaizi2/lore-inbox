Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287809AbSAXNbU>; Thu, 24 Jan 2002 08:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287804AbSAXNbL>; Thu, 24 Jan 2002 08:31:11 -0500
Received: from coruscant.franken.de ([193.174.159.226]:53392 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S287809AbSAXNaz>; Thu, 24 Jan 2002 08:30:55 -0500
Date: Thu, 24 Jan 2002 14:24:32 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        Rusty Russell <rusty@rustcorp.com.au>,
        Marcelo Tossati <marcelo@conectiva.com.br>,
        David Miller <davem@redhat.com>
Subject: Re: Patch: linux-2.5.3-pre4/net/ipv4/netfilter/ipfwadm_core.c typo fixes to make it compile
Message-ID: <20020124142432.J11216@sunbeam.de.gnumonks.org>
In-Reply-To: <200201241009.CAA00324@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200201241009.CAA00324@baldur.yggdrasil.com>; from adam@yggdrasil.com on Thu, Jan 24, 2002 at 02:09:22AM -0800
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Prickle-Prickle, the 24th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 02:09:22AM -0800, Adam J. Richter wrote:
> 	linux-2.5.3-pre4/net/ipv4/netfilter/ipfwadm_core.c incorrectly
> contained parentheses after uses of the MOD_{INC,DEC}_USE_COUNT macros.
> This causes it to fail to compile.  

*sigh*. I feel really stupid. 

This change was introduced by a patch from Rusty Russell.

> It is not clear to me who the maintainer of this file is.  So, I apologize
> for not including that person directly in this email.

The maintainer am now I, and I feel guilty for passing this on without even
trying to compile it. Sorry.

> 	Here is the patch.

Thanks. 

Linus, DaveM, Marcelo: Please apply to 2.4.x and 2.5.x ASAP. Thanks.

> 
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104

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
-
-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
