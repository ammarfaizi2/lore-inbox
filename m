Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbRFPQJY>; Sat, 16 Jun 2001 12:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263686AbRFPQJO>; Sat, 16 Jun 2001 12:09:14 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:61444 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S262658AbRFPQJL>;
	Sat, 16 Jun 2001 12:09:11 -0400
Message-ID: <3B2B845F.50300@nyc.rr.com>
Date: Sat, 16 Jun 2001 12:07:59 -0400
From: Daniel Dickman <ddickman@nyc.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] to init/main.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a small patch to main.c.

It does the following:
- makes sure that asm/mtrr.h actually gets included, and
- changes formatting in one place as per Documentation/CodingStyle

--- linux-2.4.5/init/main.c     Tue May 22 12:35:42 2001
+++ linux/init/main.c   Sat Jun 16 11:48:42 2001
@@ -50,7 +50,7 @@
 #endif
 
 #ifdef CONFIG_MTRR
-#  include <asm/mtrr.h>
+#include <asm/mtrr.h>
 #endif
 
 #ifdef CONFIG_NUBUS
@@ -292,8 +292,7 @@
        ROOT_DEV = name_to_kdev_t(line);
        memset (root_device_name, 0, sizeof root_device_name);
        if (strncmp (line, "/dev/", 5) == 0) line += 5;
-       for (i = 0; i < sizeof root_device_name - 1; ++i)
-       {
+       for (i = 0; i < sizeof root_device_name - 1; ++i) {
            ch = line[i];
            if ( isspace (ch) || (ch == ',') || (ch == '\0') ) break;
            root_device_name[i] = ch;

