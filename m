Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319186AbSIDPnf>; Wed, 4 Sep 2002 11:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319189AbSIDPnf>; Wed, 4 Sep 2002 11:43:35 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:15092 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S319186AbSIDPne>;
	Wed, 4 Sep 2002 11:43:34 -0400
Date: Wed, 4 Sep 2002 11:48:04 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.33-mm2
Message-ID: <20020904154804.GA29967@www.kroptech.com>
References: <3D75CD24.AF9B769B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D75CD24.AF9B769B@zip.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems to need this patch to satisfy the compiler gremlins...

--Adam

--- linux-2.5.33-mm2.orig/mm/vmalloc.c	Wed Sep  4 11:42:50 2002
+++ linux-2.5.33-mm2/mm/vmalloc.c	Wed Sep  4 11:38:53 2002
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
+#include <linux/interrupt.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>

