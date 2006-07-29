Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWG2Mc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWG2Mc4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 08:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWG2Mc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 08:32:56 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:7933 "EHLO gepetto.dc.ltu.se")
	by vger.kernel.org with ESMTP id S932119AbWG2Mcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 08:32:55 -0400
Message-ID: <1154176331.44cb554b633ef@portal.student.luth.se>
Date: Sat, 29 Jul 2006 14:32:11 +0200
From: ricknu-0@student.ltu.se
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Paul Jackson <pj@sgi.com>, Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       Nicholas Miell <nmiell@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Noschinski <cebewee@gmx.de>
Subject: [PATCH 1/2] include/linux: Defining bool, false and true
References: <1154175570.44cb5252d3f09@portal.student.luth.se>
In-Reply-To: <1154175570.44cb5252d3f09@portal.student.luth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines:
* a generic boolean-type, named "bool"
* aliases to 0 and 1, named "false" and "true"

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 stddef.h |    5 +++++
 types.h  |    2 ++
 2 files changed, 7 insertions(+)


diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index b3a2cad..0382065 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -10,6 +10,11 @@ #else
 #define NULL ((void *)0)
 #endif
 
+enum {
+	false	= 0,
+	true	= 1
+};
+
 #undef offsetof
 #ifdef __compiler_offsetof
 #define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)
diff --git a/include/linux/types.h b/include/linux/types.h
index 3f23566..406d4ae 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -33,6 +33,8 @@ typedef __kernel_clockid_t	clockid_t;
 typedef __kernel_mqd_t		mqd_t;
 
 #ifdef __KERNEL__
+typedef _Bool			bool;
+
 typedef __kernel_uid32_t	uid_t;
 typedef __kernel_gid32_t	gid_t;
 typedef __kernel_uid16_t        uid16_t;

