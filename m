Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317033AbSEWWcy>; Thu, 23 May 2002 18:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSEWWcx>; Thu, 23 May 2002 18:32:53 -0400
Received: from relay1.pair.com ([209.68.1.20]:36361 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S317033AbSEWWcv>;
	Thu, 23 May 2002 18:32:51 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CED6E0F.215BF408@kegel.com>
Date: Thu, 23 May 2002 15:32:47 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin P. Fleming" <kevin@labsysgrp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: [PATCH] patch for 2.4.19-pre8 nfsroot.c to compile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch below is required for fs/nfs/nfsroot.c to compile in 2.4.19-pre8:
> 
> diff -X dontdiff -urN linux/fs/nfs/nfsroot.c linux-nfsroot/fs/nfs/nfsroot.c
> --- linux/fs/nfs/nfsroot.c Thu May 23 12:04:17 2002
> +++ linux-nfsroot/fs/nfs/nfsroot.c Thu May 23 12:10:11 2002
> @@ -344,7 +344,7 @@
>   struct sockaddr_in sin;
>  
>   printk(KERN_NOTICE "Looking up port of RPC %d/%d on %s\n",
> -  program, version, in_ntoa(servaddr));
> +  program, version, NIPQUAD(servaddr));
>   set_sockaddr(&sin, servaddr, 0);
>   return rpc_getport_external(&sin, program, version, proto);
>  }

Er, shouldn't you change the %s to a %d.%d.%d.%d?
- Dan
