Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316823AbSFJKMy>; Mon, 10 Jun 2002 06:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316825AbSFJKMx>; Mon, 10 Jun 2002 06:12:53 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:32398 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S316823AbSFJKMx>; Mon, 10 Jun 2002 06:12:53 -0400
Date: Mon, 10 Jun 2002 06:17:41 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.21: "ata_task_file: unknown command 50"
In-Reply-To: <3D045B72.9000304@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020610101248.HZWL28280.pop018.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> This kernel has several patches applied, which got it to build:
> 
> 	vmalloc patch

If that's the patch I sent then you should reverse it and apply the
patch Anton sent.  I got it wrong.  It won't affect any of the errors
you're getting though.

I'm including his patch in case you need it...


--- tng/kernel/ksyms.c.old	Mon Jun 10 03:19:58 2002
+++ tng/kernel/ksyms.c	Mon Jun 10 03:21:18 2002
@@ -108,6 +108,9 @@ EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
+EXPORT_SYMBOL(vmalloc);
+EXPORT_SYMBOL(vmalloc_dma);
+EXPORT_SYMBOL(vmalloc_32);
 EXPORT_SYMBOL(vmalloc_to_page);
 EXPORT_SYMBOL(mem_map);
 EXPORT_SYMBOL(remap_page_range);


-- 
Skip
