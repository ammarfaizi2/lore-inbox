Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVE0WOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVE0WOm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVE0WLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:11:30 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:49954 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262611AbVE0WKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:10:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RFCzLR2S9A1e2gmLUDzrBj70+Je0Q4yzmnP9LfSE5ygnJgK/WeJAFebtjkSYpiMZwJX2CWB1yfe9bwa3apl3ns/nrIUxQUgCTJLIYqDOTQVBDvhjXJwgx9AAaVMrODaBU6DXg1sAvu92/yax+zl5tjsoPF6cpvcmMROd1B79/Ns=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Subject: Re: update-comment-about-gzip-scratch-size.patch added to -mm tree
Date: Sat, 28 May 2005 02:15:00 +0400
User-Agent: KMail/1.7.2
Cc: olh@suse.de, linux-kernel@vger.kernel.org
References: <200505272149.j4RLnKZW011173@shell0.pdx.osdl.net>
In-Reply-To: <200505272149.j4RLnKZW011173@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505280215.01241.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 May 2005 01:50, akpm@osdl.org wrote:
> From: Olaf Hering <olh@suse.de>
> 
> fix a comment about the array size.

> --- 25/arch/ppc/boot/openfirmware/chrpmain.c~update-comment-about-gzip-scratch-size
> +++ 25-akpm/arch/ppc/boot/openfirmware/chrpmain.c

>  #define SCRATCH_SIZE	(128 << 10)
>  
> -static char scratch[SCRATCH_SIZE];	/* 1MB of scratch space for gunzip */
> +static char scratch[SCRATCH_SIZE];	/* 128k of scratch space for gunzip */

How about this?



Remove incorrect size from comment. scratch size is defined two lines above.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- linux-vanilla/arch/ppc/boot/openfirmware/chrpmain.c	2005-05-27 23:06:23.000000000 +0400
+++ linux-scratch/arch/ppc/boot/openfirmware/chrpmain.c	2005-05-28 02:08:54.000000000 +0400
@@ -39,7 +39,7 @@ char *avail_high;
 
 #define SCRATCH_SIZE	(128 << 10)
 
-static char scratch[SCRATCH_SIZE];	/* 1MB of scratch space for gunzip */
+static char scratch[SCRATCH_SIZE];	/* scratch space for gunzip */
 
 typedef void (*kernel_start_t)(int, int, void *, unsigned int, unsigned int);
 
