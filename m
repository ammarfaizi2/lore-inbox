Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265172AbSKFAsQ>; Tue, 5 Nov 2002 19:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSKFAsQ>; Tue, 5 Nov 2002 19:48:16 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:56990 "EHLO
	beast.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S265172AbSKFAsP>; Tue, 5 Nov 2002 19:48:15 -0500
Date: Wed, 6 Nov 2002 10:59:41 +1000
From: David McCullough <davidm@snapgear.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RANT] Totally inadequate commenting in flat.h
Message-ID: <20021106105941.A17501@beast.internal.moreton.com.au>
References: <15816.23157.790358.720568@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <15816.23157.790358.720568@argo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Nov 06, 2002 at 10:55:33AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Paul,

Fair comment,  however,  have you looked at a lot of the other files
in include/linux ?  Plenty of examples with the same lack of comments,
a good one that does essentially the same thing as flat.h:

	include/linux/elf.h

No excuses though,  here's a patch to add a comment about what the file is
used for,

Cheers,
Davidm


Index: include/linux/flat.h
===================================================================
RCS file: include/linux/flat.h,v
retrieving revision 1.2
diff -u -1 -r1.2 flat.h
--- include/linux/flat.h	16 Oct 2002 04:34:28 -0000	1.2
+++ include/linux/flat.h	6 Nov 2002 00:51:25 -0000
@@ -4,2 +4,5 @@
  * Copyright (C) 2002  David McCullough <davidm@snapgear.com>
+ *
+ * This file provides the definitions and structures needed to
+ * support uClinux flat-format executables.
  */


Jivin Paul Mackerras lays it down ...
> Looking over the recent changes in Linus' tree, I saw there was this
> new file, include/linux/flat.h.  Hmmm, uninformative name, what's this
> file about?  I look in the file and here is how it starts:
> 
> /* Copyright (C) 1998  Kenneth Albanowski <kjahds@kjahds.com>
>  *                     The Silver Hammer Group, Ltd.
>  * Copyright (C) 2002  David McCullough <davidm@snapgear.com>
>  */
> 
> #ifndef _LINUX_FLAT_H
> #define _LINUX_FLAT_H
> 
> #define	FLAT_VERSION			0x00000004L
> 
> /*
>  * To make everything easier to port and manage cross platform
>  * development,  all fields are in network byte order.
>  */
> 
> struct flat_hdr {
> 	char magic[4];
> 	unsigned long rev;          /* version (as above) */
> 
> etc.
> 
> *Completely* uninformative.  How is anyone supposed to know what this
> relates to?  Is it something to do with a network device, or a
> filesystem, or an executable format, or what?
> 
> [And no, don't reply to this telling me what it's about, add some
> comments to the file instead.]
> 
> Paul.

-- 
David McCullough:    Ph: +61 7 3435 2815  http://www.SnapGear.com
davidm@snapgear.com  Fx: +61 7 3891 3630  Custom Embedded Solutions + Security
