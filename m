Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276525AbRI2Pdv>; Sat, 29 Sep 2001 11:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276524AbRI2Pdl>; Sat, 29 Sep 2001 11:33:41 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:53121 "EHLO ookhoi.xs4all.nl")
	by vger.kernel.org with ESMTP id <S276523AbRI2Pd1>;
	Sat, 29 Sep 2001 11:33:27 -0400
Date: Sat, 29 Sep 2001 17:33:52 +0200
From: Ookhoi <ookhoi@dds.nl>
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac17 Adaptec AIC7XXX problems (new driver, old one works fine)
Message-ID: <20010929173352.F9327@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <20010929162224.E9327@humilis> <E15nLLO-00027M-00@fenrus.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15nLLO-00027M-00@fenrus.demon.nl>
User-Agent: Mutt/1.3.19i
X-Uptime: 20:50:40 up 1 day, 9 min,  9 users,  load average: 0.08, 0.12, 0.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In article <20010929162224.E9327@humilis> you wrote:
> > Hi Justin, Alan,
> 
> > aic7xxx_old.c:11965: parse error before string constant
> > aic7xxx_old.c:11965: warning: type defaults to `int' in declaration of `MODULE_LICENSE'
> > aic7xxx_old.c:11965: warning: function declaration isn't a prototype
> > aic7xxx_old.c:11965: warning: data definition has no type or storage class
> 
> 
> Yet another driver with bogus #ifdef around the module.h include.. sigh

You mean linux/drivers/scsi/aic7xxx_old.c ? The old one is the one that
fails to compile with -ac17


> --- linux/drivers/scsi/aic7xxx/aic7xxx_linux.c~	Fri Sep 28 13:02:13 2001
> +++ linux/drivers/scsi/aic7xxx/aic7xxx_linux.c	Sat Sep 29 15:41:52 2001
> @@ -120,9 +120,7 @@
>   * under normal conditions.
>   */
>  
> -#if defined(MODULE)
>  #include <linux/module.h>
> -#endif
>  
>  #include "aic7xxx_osm.h"
>  #include "aic7xxx_inline.h"
