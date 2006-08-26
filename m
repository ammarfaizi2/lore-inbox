Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWHZX4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWHZX4a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 19:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWHZX4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 19:56:30 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17417 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751254AbWHZX43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 19:56:29 -0400
Date: Sun, 27 Aug 2006 01:56:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Chuck Lever <chuck.lever@oracle.com>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc4-mm3: ROOT_NFS=y compile error
Message-ID: <20060826235628.GL4765@stusta.de>
References: <20060826160922.3324a707.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060826160922.3324a707.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 04:09:22PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm2:
>...
>  git-nfs.patch
>...
>  git trees
>...

This breaks CONFIG_ROOT_NFS=y:

<--  snip  -->

...
  CC      fs/nfs/mount_clnt.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c: In function ‘mnt_create’:
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c:82: error: implicit declaration of function ‘xprt_create_proto’
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c:82: warning: assignment makes pointer from integer without a cast
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c:86: error: implicit declaration of function ‘rpc_create_client’
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c:88: warning: assignment makes pointer from integer without a cast
make[3]: *** [fs/nfs/mount_clnt.o] Error 1

<--  snip  -->

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

