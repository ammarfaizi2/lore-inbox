Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVI2W45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVI2W45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVI2W45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:56:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63623 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750833AbVI2W44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:56:56 -0400
Date: Thu, 29 Sep 2005 15:56:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.14-rc2-mm2
Message-Id: <20050929155646.757339a9.akpm@osdl.org>
In-Reply-To: <433C60B1.8080003@ens-lyon.fr>
References: <20050929143732.59d22569.akpm@osdl.org>
	<433C60B1.8080003@ens-lyon.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Buisse <alexandre.buisse@ens-lyon.fr> wrote:
>
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

Strange, it compiled OK for me.  <looks at spin_macros.h, hurriedly
resiles>

Please send the .config.
