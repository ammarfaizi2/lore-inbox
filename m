Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVI2Wvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVI2Wvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVI2Wvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:51:50 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:58514 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932363AbVI2Wvt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:51:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CCQhnPSg9cZ6roO1WJnkwrr9W1atoPJGoZOq6kjJcbN5BPgWgL5hhEIHyfeA6mAN40JF9+nwTrZjxnukIg4zRvGsGNmAPE+Drx85IZg2xoXpj6u0ojyUvYdPWWcknG5sFoky78ukz8WVBlQ8MSIyPaevOy/r8Qed0rLAV2S3bCY=
Message-ID: <6bffcb0e0509291551161e7eb5@mail.gmail.com>
Date: Fri, 30 Sep 2005 00:51:48 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
Subject: Re: 2.6.14-rc2-mm2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <433C60B1.8080003@ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050929143732.59d22569.akpm@osdl.org>
	 <433C60B1.8080003@ens-lyon.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/09/05, Alexandre Buisse <alexandre.buisse@ens-lyon.fr> wrote:
> Andrew Morton wrote:
>
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/
> >
> >(temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)
> >
>
>
> Hi Andrew,
>
> just wanting to report that reiser4 as a module was not compiling
> anymore. It failed with the following message :
>
> In file included from fs/reiser4/lock.h:15,
>                  from fs/reiser4/context.h:14,
>                  from fs/reiser4/debug.c:25:
> fs/reiser4/txnmgr.h: In function `spin_atom_init':
> fs/reiser4/txnmgr.h:512: error: duplicate case value
> fs/reiser4/txnmgr.h:512: error: previously used here
> fs/reiser4/txnmgr.h: In function `spin_txnh_init':
> fs/reiser4/txnmgr.h:513: error: duplicate case value
> fs/reiser4/txnmgr.h:513: error: previously used here
> fs/reiser4/txnmgr.h: In function `spin_txnmgr_init':
> fs/reiser4/txnmgr.h:514: error: duplicate case value
> fs/reiser4/txnmgr.h:514: error: previously used here
> In file included from fs/reiser4/context.h:14,
>                  from fs/reiser4/debug.c:25:
> fs/reiser4/lock.h: In function `spin_stack_init':
> fs/reiser4/lock.h:198: error: duplicate case value
> fs/reiser4/lock.h:198: error: previously used here
> In file included from fs/reiser4/znode.h:16,
>                  from fs/reiser4/tree.h:15,
>                  from fs/reiser4/super.h:9,
>                  from fs/reiser4/debug.c:26:
> fs/reiser4/jnode.h: In function `spin_jnode_init':
> fs/reiser4/jnode.h:344: error: duplicate case value
> fs/reiser4/jnode.h:344: error: previously used here
> fs/reiser4/jnode.h: In function `spin_jload_init':
> fs/reiser4/jnode.h:348: error: duplicate case value
> fs/reiser4/jnode.h:348: error: previously used here
> In file included from fs/reiser4/super.h:9,
>                  from fs/reiser4/debug.c:26:
> fs/reiser4/tree.h: In function `spin_epoch_init':
> fs/reiser4/tree.h:169: error: duplicate case value
> fs/reiser4/tree.h:169: error: previously used here
> In file included from fs/reiser4/debug.c:26:
> fs/reiser4/super.h: In function `spin_super_init':
> fs/reiser4/super.h:379: error: duplicate case value
> fs/reiser4/super.h:379: error: previously used here
> make[2]: *** [fs/reiser4/debug.o] Error 1
> make[1]: *** [fs/reiser4] Error 2
> make: *** [fs] Error 2
>
>
> I did not investigate further and simply removed the module.
>
> Regards,
> Alexandre
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

I haven't noticed it. I have reiser4 as module

# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISER4_FS=m
CONFIG_REISER4_DEBUG=y
CONFIG_REISERFS_FS=m

ng02:/usr/src/linux-mm# gcc --version
gcc (GCC) 3.3.5 (Debian 1:3.3.5-13)
Copyright (C) 2003 Free Software Foundation, Inc.

gcc issue?

Regards,
Michal Piotrowski
