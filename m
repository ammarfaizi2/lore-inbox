Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269166AbUJFKn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269166AbUJFKn5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 06:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269193AbUJFKn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 06:43:57 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:7176 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269166AbUJFKnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 06:43:50 -0400
Date: Wed, 6 Oct 2004 11:43:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "David A. Hinds" <dahinds@users.sourceforge.net>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
Subject: Re: [PATCH] check the return value of __copy_to_user in drivers/pcmcia/ds.c::ds_ioctl and return -EFAULT if it fails
Message-ID: <20041006114342.B29243@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesper Juhl <juhl-lkml@dif.dk>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"David A. Hinds" <dahinds@users.sourceforge.net>,
	linux-pcmcia <linux-pcmcia@lists.infradead.org>
References: <Pine.LNX.4.61.0410060012590.2913@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0410060012590.2913@dragon.hygekrogen.localhost>; from juhl-lkml@dif.dk on Wed, Oct 06, 2004 at 12:21:58AM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 12:21:58AM +0200, Jesper Juhl wrote:
> 
>   CC      drivers/pcmcia/ds.o
> include/asm/uaccess.h: In function `ds_ioctl':
> drivers/pcmcia/ds.c:1049: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
> 
> Patch adds a check of the return value and returns -EFAULT if 
> __copy_to_user fails.

I think this function should use the non-__ prefix version and remove access_ok
again

