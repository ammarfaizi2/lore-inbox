Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTARDyz>; Fri, 17 Jan 2003 22:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbTARDyy>; Fri, 17 Jan 2003 22:54:54 -0500
Received: from [217.7.64.198] ([217.7.64.198]:49885 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id <S262258AbTARDyy>;
	Fri, 17 Jan 2003 22:54:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: John Cherry <cherry@osdl.org>
Subject: Re: Linux 2.5.59
Date: Sat, 18 Jan 2003 05:03:49 +0100
User-Agent: KMail/1.4.3
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301161826430.8879-100000@penguin.transmeta.com> <1042822516.14996.10.camel@cherrypit.pdx.osdl.net>
In-Reply-To: <1042822516.14996.10.camel@cherrypit.pdx.osdl.net>
X-Message-Flag: Warning: May contain useful information
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301180503.49525.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 17. Januar 2003 17:55, John Cherry wrote:

...
> Compile statistics have been for kernel releases from 2.5.46 to 2.5.59
> at: www.osdl.org/archive/cherry/stability

think on old oldconfigs:

--- compregress.sh.old  2003-01-18 04:49:26.000000000 +0100
+++ compregress.sh      2003-01-18 04:51:17.000000000 +0100
@@ -231,18 +231,16 @@

 if [ $HAS_OLDCONFIG == 1 ]; then
   printf "   Making bzImage (oldconfig): "
+  STR="\n"
   for x in 1 2 3 4 5 6 7 8 9 10; do
-    echo "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" >> tmp_return
+    STR="$STR$STR"
   done
-  STR=`cat tmp_return`
-  rm -f tmp_return

   test -f .config && cp -f .config .config.bak
   make mrproper > /dev/null 2>&1
   test -f .config.bak && mv .config.bak .config

   echo -e $STR | make oldconfig &> /dev/null
-  echo -e $STR | make oldconfig &> /dev/null
   make dep >> $KERNEL_OLDCONFIG 2>&1
   make $MAKEOPT bzImage >> $KERNEL_OLDCONFIG 2>&1
   WARN_COUNT=`egrep "warning:" $KERNEL_OLDCONFIG | wc -l`
