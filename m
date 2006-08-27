Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWH0S2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWH0S2t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWH0S2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:28:49 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:5099 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932241AbWH0S2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:28:48 -0400
Message-ID: <000601c6ca06$28b62cc0$b461908d@ralph>
From: "Chuck Lever" <chuck.lever@oracle.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>,
       "Trond Myklebust" <Trond.Myklebust@netapp.com>
Cc: <linux-kernel@vger.kernel.org>
References: <20060826160922.3324a707.akpm@osdl.org> <20060826235628.GL4765@stusta.de>
Subject: Re: 2.6.18-rc4-mm3: ROOT_NFS=y compile error
Date: Sun, 27 Aug 2006 14:25:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Adrian Bunk" <bunk@stusta.de>
To: "Andrew Morton" <akpm@osdl.org>; "Chuck Lever" <chuck.lever@oracle.com>; 
"Trond Myklebust" <Trond.Myklebust@netapp.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, August 26, 2006 7:56 PM
Subject: 2.6.18-rc4-mm3: ROOT_NFS=y compile error


> On Sat, Aug 26, 2006 at 04:09:22PM -0700, Andrew Morton wrote:
>>...
>> Changes since 2.6.18-rc4-mm2:
>>...
>>  git-nfs.patch
>>...
>>  git trees
>>...
>
> This breaks CONFIG_ROOT_NFS=y:
>
> <--  snip  -->
>
> ...
>  CC      fs/nfs/mount_clnt.o
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c: In 
> function ‘mnt_create’:
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c:82: 
> error: implicit declaration of function ‘xprt_create_proto’
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c:82: 
> warning: assignment makes pointer from integer without a cast
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c:86: 
> error: implicit declaration of function ‘rpc_create_client’
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/fs/nfs/mount_clnt.c:88: 
> warning: assignment makes pointer from integer without a cast
> make[3]: *** [fs/nfs/mount_clnt.o] Error 1
>
> <--  snip  -->

Looks like a patch got misapplied somewhere.  All my copies of this patch 
series has this change, but Andrew's doesn't.  Trond, let's hook up Monday 
and work this out. 

