Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264868AbTE1Uvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 16:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264869AbTE1Uvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 16:51:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:15071 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264868AbTE1Uvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 16:51:52 -0400
Date: Wed, 28 May 2003 14:05:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Riley Williams" <Riley@Williams.Name>
Cc: akpm@digeo.com, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: CODA breaks boot
Message-Id: <20030528140506.38adeca7.rddunlap@osdl.org>
In-Reply-To: <BKEGKPICNAKILKJKMHCACEPLEBAA.Riley@Williams.Name>
References: <20030528043600.650a2f82.akpm@digeo.com>
	<BKEGKPICNAKILKJKMHCACEPLEBAA.Riley@Williams.Name>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

|  >  fs/coda/inode.c |    6 +++---
|  >  1 files changed, 3 insertions(+), 3 deletions(-)
|  > 
|  > diff -puN fs/coda/inode.c~coda-typo-fix fs/coda/inode.c
|  > --- 25/fs/coda/inode.c~coda-typo-fix	2003-05-27 22:27:11.000000000 -0700
|  > +++ 25-akpm/fs/coda/inode.c	2003-05-27 22:27:27.000000000 -0700
|  > @@ -69,9 +69,9 @@ static void init_once(void * foo, kmem_c
|  >  int coda_init_inodecache(void)
|  >  {
|  >  	coda_inode_cachep = kmem_cache_create("coda_inode_cache",
|  > -					     sizeof(struct coda_inode_info),
|  > +				sizeof(struct coda_inode_info),
|  > -					     0, SLAB_HWCACHE_ALIGN||SLAB_RECLAIM_ACCOUNT,
                  ^^ change to |

|  > +				0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
|  > -					     init_once, NULL);
|  > +				init_once, NULL);
|  >  	if (coda_inode_cachep == NULL)
|  >  		return -ENOMEM;
|  >  	return 0;
| 
| That patch has me puzzled. Other than changing the white space, what actual
| change to the code does it make? I can't see any.

See above.
Yes, I understand.  :)

--
~Randy
