Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270101AbRHQKb7>; Fri, 17 Aug 2001 06:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271076AbRHQKbu>; Fri, 17 Aug 2001 06:31:50 -0400
Received: from ns.caldera.de ([212.34.180.1]:9904 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S270101AbRHQKbe>;
	Fri, 17 Aug 2001 06:31:34 -0400
Date: Fri, 17 Aug 2001 12:31:10 +0200
Message-Id: <200108171031.f7HAVAc16023@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: trond.myklebust@fys.uio.no (Trond Myklebust)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, adam@yggdrasil.com
Subject: Re: linux-2.4.9: atomic_dec_and_lock sometimes used while not defined
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <shsu1z7c7qa.fsf@charged.uio.no>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

In article <shsu1z7c7qa.fsf@charged.uio.no> you wrote:
> diff -u --recursive --new-file linux-2.4.9.orig/lib/Makefile linux-2.4.9/lib/Makefile
> --- linux-2.4.9.orig/lib/Makefile	Wed Apr 25 22:31:03 2001
> +++ linux-2.4.9/lib/Makefile	Fri Aug 17 11:52:35 2001
> @@ -16,6 +16,7 @@
>  obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
>  
>  ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
> +  export-objs += dec_and_lock.o
>    obj-y += dec_and_lock.o
>  endif

Nonono!  Please add it to export-objs _always_ not dependand on some
CONFIG_ symbol, that's how the 2.4 makefiles work.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
