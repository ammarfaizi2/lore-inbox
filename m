Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267140AbRHRUaq>; Sat, 18 Aug 2001 16:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbRHRUah>; Sat, 18 Aug 2001 16:30:37 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:33803 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S267140AbRHRUa1>; Sat, 18 Aug 2001 16:30:27 -0400
Date: Sat, 18 Aug 2001 16:30:39 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: [PATCH] fs/unistr.c needs to include linux/kernel.h
Message-ID: <20010818163039.C6893@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, alan@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Subject pretty much says it all, fs/unistr.h uses min(),
but does not include linux/kernel.h

This causes build errors.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.4.9-cd-unistr.c_include_kernel.h"

--- linux/fs/ntfs/unistr.c.include	Sat Aug 18 16:19:28 2001
+++ linux/fs/ntfs/unistr.c	Sat Aug 18 16:19:06 2001
@@ -21,6 +21,7 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/kernel.h>
 #include <linux/string.h>
 #include <asm/byteorder.h>
 

--NzB8fVQJ5HfG6fxh--
