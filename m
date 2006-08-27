Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWH0VAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWH0VAk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 17:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWH0VAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 17:00:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51660 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932065AbWH0VAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 17:00:40 -0400
Date: Sun, 27 Aug 2006 13:56:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Adrian Bunk" <bunk@stusta.de>,
       "Trond Myklebust" <Trond.Myklebust@netapp.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc4-mm3: ROOT_NFS=y compile error
Message-Id: <20060827135654.27e29ee4.akpm@osdl.org>
In-Reply-To: <000601c6ca06$28b62cc0$b461908d@ralph>
References: <20060826160922.3324a707.akpm@osdl.org>
	<20060826235628.GL4765@stusta.de>
	<000601c6ca06$28b62cc0$b461908d@ralph>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 14:25:21 -0400
"Chuck Lever" <chuck.lever@oracle.com> wrote:

> >  CC      fs/nfs/mount_clnt.o
> > /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c: In 
> > function ‘mnt_create’:
> > /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c:82: 
> > error: implicit declaration of function ‘xprt_create_proto’
> > /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c:82: 
> > warning: assignment makes pointer from integer without a cast
> > /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c:86: 
> > error: implicit declaration of function ‘rpc_create_client’
> > /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c:88: 
> > warning: assignment makes pointer from integer without a cast
> > make[3]: *** [fs/nfs/mount_clnt.o] Error 1
> >
> > <--  snip  -->
> 
> Looks like a patch got misapplied somewhere.

That's quite possible.

>  All my copies of this patch 
> series has this change, but Andrew's doesn't.

What is "this change"?  The only change I see in Trond's mount_clnt.c is the
removal of the xprt.h include.
