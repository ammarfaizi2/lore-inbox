Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261736AbTCLPlO>; Wed, 12 Mar 2003 10:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbTCLPlL>; Wed, 12 Mar 2003 10:41:11 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:21695 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S261736AbTCLPjE>; Wed, 12 Mar 2003 10:39:04 -0500
Date: Wed, 12 Mar 2003 16:49:43 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] Linux 2.4.21pre5-ac3 - change format in
 reiserfs/super.c
In-Reply-To: <Pine.LNX.4.51.0303121645130.10932@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.51.0303121648520.10932@dns.toxicfilms.tv>
References: <200303121500.h2CF0U2F000852@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.51.0303121645130.10932@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux 2.4.21pre5-ac3

This removes int format, long argument issue in fs/reiserfs/super.c


--- linux-2.4.20/fs/reiserfs/super.c~	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20/fs/reiserfs/super.c	2003-03-12 16:42:56.000000000 +0100
@@ -865,7 +865,7 @@
     brelse (bh);

     if (s->s_blocksize != 4096) {
-	printk("Unsupported reiserfs blocksize: %d on %s, only 4096 bytes "
+	printk("Unsupported reiserfs blocksize: %ld on %s, only 4096 bytes "
 	       "blocksize is supported.\n", s->s_blocksize, kdevname (s->s_dev));
 	return 1;
     }
