Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275256AbTHMQSR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 12:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275261AbTHMQSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 12:18:16 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:26520 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S275256AbTHMQSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 12:18:15 -0400
Date: Wed, 13 Aug 2003 09:16:41 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>, Con Kolivas <kernel@kolivas.org>
cc: Andrew Morton <akpm@osdl.org>,
       Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm2
Message-ID: <22380000.1060791398@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0308131529200.1558-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0308131529200.1558-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- 2.6.0-test3-mm2/mm/filemap.c	Wed Aug 13 11:51:33 2003
> +++ linux/mm/filemap.c	Wed Aug 13 15:26:36 2003
> @@ -1927,8 +1927,6 @@ generic_file_aio_write_nolock(struct kio
>  	ssize_t ret;
>  	loff_t pos = *ppos;
>  
> -	BUG_ON(iocb->ki_pos != *ppos);
> -
>  	if (!iov->iov_base && !is_sync_kiocb(iocb)) {
>  		/* nothing to transfer, may just need to sync data */
>  		ret = iov->iov_len; /* vector AIO not supported yet */

Even with this, still hangs when "mostly-booted". alt+sysrq+t doesn't
work, but ping does, oddly enough. I suppose I'll play with nmi_watchdog
or something later, but I doubt I'll have time today.

M.

