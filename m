Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSHGXrl>; Wed, 7 Aug 2002 19:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSHGXrl>; Wed, 7 Aug 2002 19:47:41 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:24078 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316709AbSHGXrU>; Wed, 7 Aug 2002 19:47:20 -0400
Message-ID: <3D51B25E.2000C8C8@linux-m68k.org>
Date: Thu, 08 Aug 2002 01:50:54 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] module cleanup (3/5)
References: <E17cDB7-0002v5-00@scrub.xs4all.nl>
Content-Type: multipart/mixed;
 boundary="------------47B808B48F8D04F348505F79"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------47B808B48F8D04F348505F79
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hi,

I wrote:

> This patch removes __MODULE_STRING() in favour of __stringify().

Unfortunately too much code still uses it, so here is a small follow up
patch to add a compatibility define.

bye, Roman
--------------47B808B48F8D04F348505F79
Content-Type: text/plain; charset=iso-8859-15;
 name="string.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="string.diff"

--- linux/include/linux/module.h.org	Thu Aug  8 01:41:46 2002
+++ linux/include/linux/module.h	Thu Aug  8 01:42:37 2002
@@ -130,6 +130,7 @@
 /* Backwards compatibility definition.  */
 
 #define GET_USE_COUNT(module)	(atomic_read(&(module)->uc.usecount))
+#define __MODULE_STRING(x)	__stringify(x)
 
 /* Poke the use count of a module.  */
 

--------------47B808B48F8D04F348505F79--

