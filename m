Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbTA1Paz>; Tue, 28 Jan 2003 10:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbTA1Paz>; Tue, 28 Jan 2003 10:30:55 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:62895 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S265154AbTA1Pay>; Tue, 28 Jan 2003 10:30:54 -0500
Date: Tue, 28 Jan 2003 16:39:38 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Stuart Cheshire <cheshire@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] in drivers/net/strip.c
Message-ID: <20030128153938.GB10685@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This one-liner appears to be fixing a range error, but I'd like
someone to check it first.

Jörn

-- 
Jörn Engel
mailto: joern@wohnheim.fh-wedel.de
http://wohnheim.fh-wedel.de/~joern
Phone: +49 179 6704074

diff -Naur linux-2.4.21-pre3-ac4/drivers/net/strip.c scratch/drivers/net/strip.c
--- linux-2.4.21-pre3-ac4/drivers/net/strip.c	Fri Nov  9 23:02:24 2001
+++ scratch/drivers/net/strip.c	Tue Jan 28 13:38:57 2003
@@ -527,7 +527,7 @@
 
     *p++ = '\"';
 
-    while (ptr<end && p < &pkt_text[MAX_DumpData-4])
+    while (ptr<end && p < &pkt_text[MAX_DumpData-5])
     {
         if (*ptr == '\\')
         {
