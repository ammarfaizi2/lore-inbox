Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbUBWNP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbUBWNP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:15:58 -0500
Received: from anatevka.vcpc.univie.ac.at ([131.130.186.140]:51588 "EHLO
	anatevka.vcpc.univie.ac.at") by vger.kernel.org with ESMTP
	id S261839AbUBWNPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:15:46 -0500
Message-ID: <4039FCF8.20008@vcpc.univie.ac.at>
Date: Mon, 23 Feb 2004 14:15:36 +0100
From: Willy Weisz <weisz@vcpc.univie.ac.at>
Organization: VCPC, European Centre for Parallel Computing at Vienna
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.0.1) Gecko/20020920 Netscape/7.0
X-Accept-Language: en-us, en, de-at, fr
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Kurt Rabitsch <kurt@vcpc.univie.ac.at>
Subject: Re: Fw: Client looses NFS handle (kernel 2.6.3)
References: <20040221214345.6533eb68.akpm@osdl.org> <1077444724.2944.10.camel@nidelv.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Trond,

thank you for the fast reply. I chose the first solution (unsetting 
CONFIG_SECURITY)
as I don't have local security modules anyhow. and our problem disapeared.

Is there any reason to nevertheless install your patch?

Cheers

Willy

Trond Myklebust wrote:

>The "Can't bind to reserved port" error message looks like the known
>problem when you set CONFIG_SECURITY. It has been discussed several
>times already on l-k.
>
>Please either disable CONFIG_SECURITY (it's not as if *that* is going to
>be a showstopper when migrating to 2.6.x from 2.4.x) or go to my website
>and apply the advertised fix:
>
>http://www.fys.uio.no/~trondmy/src/Linux-2.6.x/2.6.3/linux-2.6.3-08-reconnect.dif
>
>Cheers,
>  Trond
>
>
>På lau , 21/02/2004 klokka 21:43, skreiv Andrew Morton:
>  
>
>>fyi..
>>
>>Begin forwarded message:
>>
>>Date: Sun, 22 Feb 2004 00:36:13 +0100
>>From: Willy Weisz <weisz@vcpc.univie.ac.at>
>>To: linux-kernel@vger.kernel.org
>>Subject: Client looses NFS handle (kernel 2.6.3)
>>
>>
>>The client looses the handle to a statically mounted NFS file system. A 
>>user sees
>>a stale handle in "df" and can't access files and directories.
>>
>>When root issues a "df" or accesses a file or directory on the NFS file 
>>system,
>>it gets a correct result.
>>
>>Thereafter a normal user also can access files and directories on the 
>>NFS file system.
>>After a short time the NFS handle becomes stale again.
>>/var/log/messages contains the lines:
>>Feb 21 23:33:50 gsr108 kernel: RPC: Can't bind to reserved port (13).
>>Feb 21 23:33:50 gsr108 kernel: RPC: can't bind to reserved port.
>>after a user tries to access a file on the NFS file system.
>>The NFS server runs kernel version 2.4.23 SMP. Client NFS 2.4.23 works.
>>
>>The filesystem is mounted with the following options in /etc/fstab:
>>rw,bg,hard,intr,rsize=8192,wsize=8192
>>
>>We are stuck and can't upgrade to 2.6.x with this bug.
>>
>>Regards
>>
>>Willy Weisz
>>-----------------------------------------------------------
>>Willy Weisz
>>
>>European Centre for Parallel Computing at Vienna (VCPC)
>>                 Liechtensteinstrasse 22
>>                 A-1090 Wien
>>Tel: (+43 1) 4277 - 38824          Fax: (+43 1) 4277 - 9388
>>                e-mail: weisz@vcpc.univie.ac.at
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>
>
>
>  
>

-- 
-----------------------------------------------------------
Willy Weisz

European Centre for Parallel Computing at Vienna (VCPC)
                 Liechtensteinstrasse 22
                 A-1090 Wien
Tel: (+43 1) 4277 - 38824          Fax: (+43 1) 4277 - 9388
                e-mail: weisz@vcpc.univie.ac.at



