Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWHVT2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWHVT2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWHVT2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:28:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:525 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751255AbWHVT2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:28:15 -0400
Date: Tue, 22 Aug 2006 21:28:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] arch/um/sys-i386/setjmp.S: useless #ifdef _REGPARM's?
Message-ID: <20060822192814.GA19896@stusta.de>
References: <20060821215641.GQ11651@stusta.de> <20060822022012.GA7070@ccure.user-mode-linux.org> <20060822160741.GB11651@stusta.de> <20060822174233.GA5471@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822174233.GA5471@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 01:42:33PM -0400, Jeff Dike wrote:
> On Tue, Aug 22, 2006 at 06:07:41PM +0200, Adrian Bunk wrote:
> > I didn't find a corresponding open bug in the gcc Bugzilla.
> > 
> > Can someone verify whether it's still present, and if yes, open a gcc 
> > bug?
> 
> Yup, it's easy enough to check.

Thanks.

> > It's set globally in arch/i386/Makefile:
> >   cflags-$(CONFIG_REGPARM) += -mregparm=3
> 
> IIRC, there used to be functions explicitly declared as __regparam or
> something, and that's what I was grepping for.  Does this turn every
> function with three or fewer parameters into a regparam function?
>...

With -mregparm=3, the first up to three parameters that aren't bigger 
than an integer are passed in registers instead of on the stack.

> 				Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

