Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSHVSyI>; Thu, 22 Aug 2002 14:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSHVSyI>; Thu, 22 Aug 2002 14:54:08 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:5118 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315449AbSHVSyH>; Thu, 22 Aug 2002 14:54:07 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 22 Aug 2002 12:56:21 -0600
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] export symbol for panic_notifier_list
Message-ID: <20020822185621.GG19435@clusterfs.com>
Mail-Followup-To: Corey Minyard <minyard@acm.org>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <3D64F92A.9040406@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D64F92A.9040406@acm.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 22, 2002  09:46 -0500, Corey Minyard wrote:
> If a module needs to be notified of a panic, well, it needs to get at 
> the notifier list, but that's not exported.  patch is attached.

Excellent, we have this in our private kernel patch as well.

> --- linux.orig/kernel/ksyms.c	Thu Aug 22 08:20:26 2002
> +++ linux/kernel/ksyms.c	Thu Aug 22 09:03:01 2002
> @@ -492,6 +492,7 @@
>  
>  /* misc */
>  EXPORT_SYMBOL(panic);
> +EXPORT_SYMBOL(panic_notifier_list);
>  EXPORT_SYMBOL(sprintf);
>  EXPORT_SYMBOL(snprintf);
>  EXPORT_SYMBOL(sscanf);


Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

