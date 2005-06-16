Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVFPSVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVFPSVC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 14:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVFPSVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 14:21:01 -0400
Received: from mail.dif.dk ([193.138.115.101]:65202 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261766AbVFPSUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 14:20:51 -0400
Date: Thu, 16 Jun 2005 20:26:17 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Martin Mares <mj@ucw.cz>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, LKML <linux-kernel@vger.kernel.org>,
       Hannu Savolainen <hannu@opensound.com>,
       Matthias Urlichs <matthias@urlichs.de>,
       Nick Holloway <Nick.Holloway@pyrites.org.uk>,
       Hans Lermen <lermen@elserv.ffm.fgan.de>,
       Werner Almesberger <werner@almesberger.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] trivial warning fix and whitespace cleanup for
 arch/i386/boot/compressed/misc.c
In-Reply-To: <20050616114402.GG14042@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.62.0506162024310.2477@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506160002020.3842@dragon.hyggekrogen.localhost>
 <20050616114402.GG14042@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2005, Martin Mares wrote:

> > Here's a trivial patch to fix two tiny gcc -W warnings:
> 
> Fine with me. You can also remove the surplus (char *) casts.
> 
How about this?

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 arch/i386/boot/compressed/misc.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

--- linux-2.6.12-rc6-mm1-orig/arch/i386/boot/compressed/misc.c	2005-06-12 15:58:34.000000000 +0200
+++ linux-2.6.12-rc6-mm1/arch/i386/boot/compressed/misc.c	2005-06-16 20:16:27.000000000 +0200
@@ -205,22 +205,24 @@ static void putstr(const char *s)
 	outb_p(0xff & (pos >> 1), vidport+1);
 }
 
-static void* memset(void* s, int c, size_t n)
+static void *memset(void *s, int c, size_t n)
 {
-	int i;
-	char *ss = (char*)s;
+	size_t i;
+	char *ss = s;
 
-	for (i=0;i<n;i++) ss[i] = c;
+	for (i = 0; i < n; i++)
+		ss[i] = c;
 	return s;
 }
 
-static void* memcpy(void* __dest, __const void* __src,
+static void *memcpy(void *__dest, __const void *__src,
 			    size_t __n)
 {
-	int i;
-	char *d = (char *)__dest, *s = (char *)__src;
+	size_t i;
+	char *d = __dest, *s = __src;
 
-	for (i=0;i<__n;i++) d[i] = s[i];
+	for (i = 0; i < __n; i++)
+		d[i] = s[i];
 	return __dest;
 }
 


