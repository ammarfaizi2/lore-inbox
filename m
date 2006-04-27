Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWD0S7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWD0S7Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWD0S7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:59:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16591 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965019AbWD0S7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:59:24 -0400
Subject: Re: [RFC: 2.6 patch] fs/read_write.c: unexport iov_shorten
From: Arjan van de Ven <arjan@infradead.org>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1146163983.8365.28.camel@dyn9047017100.beaverton.ibm.com>
References: <20060427180331.GK3570@stusta.de>
	 <1146163983.8365.28.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 20:59:20 +0200
Message-Id: <1146164361.2894.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 11:52 -0700, Badari Pulavarty wrote:
> On Thu, 2006-04-27 at 20:03 +0200, Adrian Bunk wrote:
> > This patch removes the unused EXPORT_SYMBOL(iov_shorten).
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > ---
> > 
> > This patch was already sent on:
> > - 23 Apr 2006
> > 
> > --- linux-2.6.17-rc1-mm3-full/fs/read_write.c.old	2006-04-23 15:51:52.000000000 +0200
> > +++ linux-2.6.17-rc1-mm3-full/fs/read_write.c	2006-04-23 15:52:02.000000000 +0200
> > @@ -436,8 +436,6 @@
> >  	return seg;
> >  }
> >  
> > -EXPORT_SYMBOL(iov_shorten);
> > -
> >  /* A write operation does a read from user space and vice versa */
> >  #define vrfy_dir(type) ((type) == READ ? VERIFY_WRITE : VERIFY_READ)
> >  
> 
> How about this ? Wondering if we need to make this "inline" also (since
> its used only in one place).


no real need; if it's static modern gcc will inline it anyway

