Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261728AbTCGT53>; Fri, 7 Mar 2003 14:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbTCGT52>; Fri, 7 Mar 2003 14:57:28 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34779 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261728AbTCGT52>; Fri, 7 Mar 2003 14:57:28 -0500
Date: Fri, 7 Mar 2003 15:08:01 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200303072008.h27K81j19556@devserv.devel.redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (5/7): kmalloc arguments.
In-Reply-To: <mailman.1047042481.25045.linux-kernel2news@redhat.com>
References: <mailman.1047042481.25045.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Add missing GFP_KERNEL to kmallocs with GFP_DMA.

> -	sch = kmalloc (sizeof (*sch), GFP_DMA);
> +	sch = kmalloc (sizeof (*sch), GFP_KERNEL | GFP_DMA);
>  	if (sch == NULL)
>  		return -ENOMEM;

Would you mind explaining why you are doing this?
What does GFP_DMA do on s390 and s390x?

-- Pete
