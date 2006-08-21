Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWHUUcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWHUUcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 16:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWHUUcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 16:32:42 -0400
Received: from xenotime.net ([66.160.160.81]:11938 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750972AbWHUUcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 16:32:41 -0400
Date: Mon, 21 Aug 2006 13:35:47 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Henne <henne@nachtwindheim.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jgarzik <jgarzik@pobox.com>
Subject: Re: [PATCH] [DOCBOOK] fix segfault in docproc.c
Message-Id: <20060821133547.dbb9ee4c.rdunlap@xenotime.net>
In-Reply-To: <44E9FCB5.4050101@nachtwindheim.de>
References: <44E9FCB5.4050101@nachtwindheim.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 20:34:29 +0200 Henne wrote:

> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Adds a missing exit, if the file that should be parsed couldn't be opened.
> Without it crashes with a segfault, cause the filedescriptor is accessed even if the file could not be opened.
> This error happens on 2.6.18-rc4-mm[12] when executing make xmldocs.
> 
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

Thanks.

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

Could you also update Documentation/DocBook/libata.tmpl to use
drivers/ata/ instead of drivers/scsi/ on the !I and !E lines?


> ---
> 
> --- linux-2.6.18-rc4/scripts/basic/docproc.c	2006-06-18 03:49:35.000000000 +0200
> +++ linux/scripts/basic/docproc.c	2006-08-18 22:19:48.000000000 +0200
> @@ -177,6 +177,7 @@
>  		{
>  			fprintf(stderr, "docproc: ");
>  			perror(real_filename);
> +			exit(1);
>  		}
>  		while(fgets(line, MAXLINESZ, fp)) {
>  			char *p;
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


---
~Randy
