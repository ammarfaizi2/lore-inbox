Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265797AbTGLBof (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 21:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266873AbTGLBof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 21:44:35 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:47185 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S265797AbTGLBoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 21:44:34 -0400
Date: Fri, 11 Jul 2003 21:59:16 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200307120159.h6C1xGL12421@devserv.devel.redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: update ymfpci for new ac97
In-Reply-To: <mailman.1057949943.19028.linux-kernel2news@redhat.com>
References: <mailman.1057949943.19028.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.5.75/sound/oss/ymfpci.c	2003-07-10 21:11:35.000000000 +0100
> +++ linux-2.5.75-ac1/sound/oss/ymfpci.c	2003-07-11 16:59:04.000000000 +0100
> @@ -2462,7 +2474,7 @@
>  	}
>  
>  	eid = ymfpci_codec_read(codec, AC97_EXTENDED_ID);
> -	if (eid==0xFFFFFF) {
> +	if (eid==0xFFFF) {
>  		printk(KERN_WARNING "ymfpci: no codec attached ?\n");
>  		goto out_kfree;
>  	}

ok, I think it's all right for 2.5, though for 2.4 I just removed
the check. Consider that it was not working for the whole life
time of the driver, and not a single soul complained. Don't forget
to fix cs46xx, the origin of this copy-n-paste.

-- Pete
