Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTI1Nyw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbTI1Nyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:54:52 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:42368 "HELO
	develer.com") by vger.kernel.org with SMTP id S262540AbTI1Nyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:54:50 -0400
Message-ID: <3F76E81F.2050002@develer.com>
Date: Sun, 28 Sep 2003 15:54:39 +0200
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030918
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <20030928135046.A30736@flint.arm.linux.org.uk>
In-Reply-To: <20030928135046.A30736@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>>>Bernardo Innocenti:
>>>  o GCC 3.3.x/3.4 compatiblity fix in include/linux/init.h
>>
>>This change breaks 2.95 for some source files, because <linux/init.h> doesn't
>>include <linux/compiler.h>. Do you want to have the missing include added to
>><linux/init.h>, or to the individual source files that need it?

The golden rule of C headers says that each file should stand
on its own, so that you have no errors when compiling the header
alone.

This is the trivial fix. Sorry for not noticing before.

--- include/linux/init.h.orig	2003-09-28 15:48:06.000000000 +0200
+++ include/linux/init.h	2003-09-28 15:48:10.000000000 +0200
@@ -2,6 +2,7 @@
 #define _LINUX_INIT_H
 
 #include <linux/config.h>
+#include <linux/compiler.h>
 
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)


-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html



