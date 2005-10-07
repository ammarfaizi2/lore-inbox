Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVJGJuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVJGJuU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 05:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVJGJuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 05:50:20 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:24753 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932268AbVJGJuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 05:50:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=blJpBbL8tCdqivvY6M3SHLk4HfOzdbxfvV/9z83705qnvYr1d7DB6rEAxApPHCthpJaSmdkC0wJg7I0PHp78NKMvLiLWKMgzOdDPkctaJI7aaKMaP031ItuVKvfijkochfRBIwvofYf5rF2sBkHtXLOnz7wy6YDdixykCp245zA=
Date: Fri, 7 Oct 2005 14:01:45 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfp flags annotations - part 1
Message-ID: <20051007100145.GA27310@mipter.zuzino.mipt.ru>
References: <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk> <20051005202904.GA27229@mipter.zuzino.mipt.ru> <20051006201534.GX7992@ftp.linux.org.uk> <20051007025644.GA11132@kroah.com> <20051007064604.GB7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051007064604.GB7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 07:46:04AM +0100, Al Viro wrote:
> --- RC14-rc3-git4-linus-delta/drivers/s390/scsi/zfcp_aux.c
> +++ current/drivers/s390/scsi/zfcp_aux.c

>  static void *
> -zfcp_mempool_alloc(unsigned int __nocast gfp_mask, void *size)
> +zfcp_mempool_alloc(gfp_t gfp_mask, void *size)
>  {
>  	return kmalloc((size_t) size, gfp_mask);
>  }

Lovely. Yes, they cast sizeof() to void * in all calls.

