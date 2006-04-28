Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbWD1AZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbWD1AZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWD1AYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:24:51 -0400
Received: from mx1.suse.de ([195.135.220.2]:19930 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965157AbWD1AYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:24:18 -0400
Date: Thu, 27 Apr 2006 17:22:45 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ralf Baechle <ralf@linux-mips.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 21/24] MIPS: Use "R" constraint for cache_op.
Message-ID: <20060428002245.GV18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="MIPS-0001.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
Gcc might emit an absolute address for the the "m" constraint which
gas unfortunately does not permit.
    
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-mips/r4kcache.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.11.orig/include/asm-mips/r4kcache.h
+++ linux-2.6.16.11/include/asm-mips/r4kcache.h
@@ -37,7 +37,7 @@
 	"	cache	%0, %1					\n"	\
 	"	.set	pop					\n"	\
 	:								\
-	: "i" (op), "m" (*(unsigned char *)(addr)))
+	: "i" (op), "R" (*(unsigned char *)(addr)))
 
 static inline void flush_icache_line_indexed(unsigned long addr)
 {

--
