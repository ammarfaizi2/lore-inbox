Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWH1Rnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWH1Rnx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWH1Rnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:43:53 -0400
Received: from mx2.netapp.com ([216.240.18.37]:36000 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1751221AbWH1Rnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:43:52 -0400
X-IronPort-AV: i="4.08,176,1154934000"; 
   d="scan'208"; a="404424357:sNHT935156148"
Subject: Re: 2.6.18-rc4-mm3: ROOT_NFS=y compile error
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <004401c6cac8$85991570$0d71908d@ralph>
References: <20060826160922.3324a707.akpm@osdl.org>
	 <20060826235628.GL4765@stusta.de><000601c6ca06$28b62cc0$b461908d@ralph>
	 <20060827135654.27e29ee4.akpm@osdl.org>
	 <004401c6cac8$85991570$0d71908d@ralph>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Mon, 28 Aug 2006 13:43:45 -0400
Message-Id: <1156787025.5607.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-OriginalArrivalTime: 28 Aug 2006 17:43:46.0287 (UTC) FILETIME=[8311FFF0:01C6CAC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 13:36 -0400, Chuck Lever wrote:
> ----- Original Message ----- 
> From: "Andrew Morton" <akpm@osdl.org>
> To: "Chuck Lever" <chuck.lever@oracle.com>
> Cc: "Adrian Bunk" <bunk@stusta.de>; "Trond Myklebust" 
> <Trond.Myklebust@netapp.com>; <linux-kernel@vger.kernel.org>
> Sent: Sunday, August 27, 2006 4:56 PM
> Subject: Re: 2.6.18-rc4-mm3: ROOT_NFS=y compile error
> 
> >>  All my copies of this patch
> >> series has this change, but Andrew's doesn't.
> >
> > What is "this change"?  The only change I see in Trond's mount_clnt.c is 
> > the
> > removal of the xprt.h include.
> 
> Found the problem.  Because of changes Trond had included already in his 
> tree, my patches didn't fit on his repository.  When I ported my patches to 
> his tree, I accidentally left out the hunk that updates fs/nfs/mount_clnt.c.
> 
> Trond should be sending out the missing hunk soon. 

Already merged into the NFS git tree. See

http://linux-nfs.org/cgi-bin/gitweb.cgi?p=nfs-2.6.git;a=commitdiff;h=f0d01cd34daccb47b7eeab03f80fe7986485528e

The raw patch can also be found on

http://client.linux-nfs.org/Linux-2.6.x/2.6.18-rc5/linux-2.6.18-056-fix_nfsroot.dif

Cheers,
  Trond
