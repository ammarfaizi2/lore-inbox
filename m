Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbTESLgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 07:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTESLgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 07:36:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35790 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262416AbTESLgM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 07:36:12 -0400
Date: Mon, 19 May 2003 13:48:36 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Paul Mackerras <paulus@samba.org>
cc: <linux-kernel@vger.kernel.org>, <benh@kernel.crashing.org>
Subject: Re: [PATCH] Compile fix for pmac IDE driver
In-Reply-To: <16072.13753.498811.834748@argo.ozlabs.ibm.com>
Message-ID: <Pine.SOL.4.30.0305191344390.23742-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Paul.

I've seen this fix also in hch's pmac compilation fixes patch,
so I think it will be in Linus' tree soon.

--
Bartlomiej

On Mon, 19 May 2003, Paul Mackerras wrote:

> Bart,
>
> The version of drivers/ide/ppc/pmac.c in Linus' tree at the moment
> doesn't compile.  The one-liner below fixes it.  Please apply.
>
> Thanks,
> Paul.
>
> diff -urN linux-2.5/drivers/ide/ppc/pmac.c pmac-2.5/drivers/ide/ppc/pmac.c
> --- linux-2.5/drivers/ide/ppc/pmac.c	2003-05-12 17:41:32.000000000 +1000
> +++ pmac-2.5/drivers/ide/ppc/pmac.c	2003-05-13 16:48:42.000000000 +1000
> @@ -721,7 +721,7 @@
>  		}
>  	}
>
> -	return NODEV;
> +	return 0;
>  }
>
>  void __init

