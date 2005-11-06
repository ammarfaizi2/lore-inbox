Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVKFIYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVKFIYf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVKFIYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:24:35 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:63628 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932328AbVKFIYd (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:24:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=0Qf8sgcmp8racG33n2fuDppWD4vYuCRgAhEWgI2T88YiGxI9afeXLAFP/QHIJy7sYvK8ysc53PMdrpMGyx/4DFiwDMkQdckntEPewodbaWmZczs0X06b2Go0Fqmpr/8AfzsbUJ/czDVJJ2uuJIoTgzqUGe/GgW1tau4c7qqMTzk=  ;
Message-ID: <436DBE43.1080405@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:26:43 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 11/14] mm: increase pcp size
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au> <436DBDA9.2040908@yahoo.com.au> <436DBDC8.5090308@yahoo.com.au> <436DBDE5.2010405@yahoo.com.au> <436DBE03.90009@yahoo.com.au> <436DBE26.5080504@yahoo.com.au>
In-Reply-To: <436DBE26.5080504@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------080008090107020907040701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080008090107020907040701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

11/14

-- 
SUSE Labs, Novell Inc.


--------------080008090107020907040701
Content-Type: text/plain;
 name="mm-increase-pcp-size.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-increase-pcp-size.patch"

Increasing pageset size gives improvements on kbuild on my Xeon.

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -1784,7 +1784,7 @@ inline void setup_pageset(struct per_cpu
 	memset(p, 0, sizeof(*p));
 	p->count = 0;
 	p->cold_count = 0;
-	p->high = 6 * batch;
+	p->high = 16 * batch;
 	p->batch = max(1UL, 1 * batch);
 	INIT_LIST_HEAD(&p->list);
 }

--------------080008090107020907040701--
Send instant messages to your online friends http://au.messenger.yahoo.com 
