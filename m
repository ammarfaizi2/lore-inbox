Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWIYIL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWIYIL1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 04:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWIYIL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 04:11:26 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:11084 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750774AbWIYILZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 04:11:25 -0400
Subject: Re: [S390] remove old z90crypt driver.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: David Woodhouse <dwmw2@infradead.org>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1159131115.24527.956.camel@pmac.infradead.org>
References: <200609222101.k8ML1w93019317@hera.kernel.org>
	 <1159131115.24527.956.camel@pmac.infradead.org>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 25 Sep 2006 10:11:23 +0200
Message-Id: <1159171883.28115.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-24 at 21:51 +0100, David Woodhouse wrote:
> You neglected to remove the defunct z90crypt.h from
> include/asm-s390/Kbuild, breaking 'make headers_install' on s390.
> 
> You also neglected to export the new asm/zcrypt.h too. This should fix
> both:
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 
> --- a/include/asm-s390/Kbuild
> +++ b/include/asm-s390/Kbuild
> @@ -6,7 +6,7 @@ header-y += qeth.h
>  header-y += tape390.h
>  header-y += ucontext.h
>  header-y += vtoc.h
> -header-y += z90crypt.h
> +header-y += zcrypt.h
> 
>  unifdef-y += cmb.h
>  unifdef-y += debug.h
> 

Unfortunately true. The patches for the new crypto driver originate from
before headers_install. I forgot to update them accordingly ..
Anyway, thanks for the heads up. I'll add the patch to git390. 

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


