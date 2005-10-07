Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVJGKFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVJGKFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 06:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVJGKFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 06:05:39 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:53142 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932314AbVJGKFi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 06:05:38 -0400
Date: Fri, 7 Oct 2005 12:04:46 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andreas Herrmann <aherrman@de.ibm.com>
Subject: Re: [PATCH] gfp flags annotations - part 1
Message-ID: <20051007100446.GA15122@osiris.boeblingen.de.ibm.com>
References: <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk> <20051005202904.GA27229@mipter.zuzino.mipt.ru> <20051006201534.GX7992@ftp.linux.org.uk> <20051007025644.GA11132@kroah.com> <20051007064604.GB7992@ftp.linux.org.uk> <20051007100145.GA27310@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051007100145.GA27310@mipter.zuzino.mipt.ru>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > --- RC14-rc3-git4-linus-delta/drivers/s390/scsi/zfcp_aux.c
> > +++ current/drivers/s390/scsi/zfcp_aux.c
> 
> >  static void *
> > -zfcp_mempool_alloc(unsigned int __nocast gfp_mask, void *size)
> > +zfcp_mempool_alloc(gfp_t gfp_mask, void *size)
> >  {
> >  	return kmalloc((size_t) size, gfp_mask);
> >  }
> 
> Lovely. Yes, they cast sizeof() to void * in all calls.

zfcp_mempool_alloc needs to fit the prototype of mempool_alloc_t.
If you have a better idea to implement a mempool, please let us
know. The calls you mention are actually calls to mempool_create
and not to zfcp_mempool_alloc, or are you talking about
something different?

Heiko
