Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVAXTsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVAXTsd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVAXTsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:48:32 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:16039 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261606AbVAXToO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:44:14 -0500
Date: Mon, 24 Jan 2005 20:44:08 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>
Subject: Re: 2.6.11-rc2-mm1 - fix a typo in nfs3proc.c
Message-ID: <20050124194408.GF1847@ens-lyon.fr>
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/
> 
> 
> - Lots of updates and fixes all over the place.
> 
> - On my test box there is no flashing cursor on the vga console.  Known bug,
>   please don't report it.
> 
>   Binary searching shows that the bug was introduced by
>   cleanup-vc-array-access.patch but that patch is, unfortunately, huge.
> 
> +nfsacl-infrastructure-and-server-side-of-nfsacl.patch
> 
>  ACLs for ther NFS client.
>

Patch below fix a typo.


--- linux-clean/fs/nfsd/nfs3proc.c	2005-01-24 12:44:44.000000000 +0100
+++ linux-test/fs/nfsd/nfs3proc.c	2005-01-24 18:22:18.000000000 +0100
@@ -813,7 +813,7 @@ struct svc_procedure		nfsd_acl_procedure
 struct svc_version	nfsd_acl_version3 = {
 		.vs_vers	= 3,
 		.vs_nproc	= 3,
-		.vs_proc	nfsd_acl_procedures3,
+		.vs_proc	= nfsd_acl_procedures3,
 		.vs_dispatch	= nfsd_dispatch,
 		.vs_xdrsize	= NFS3_SVC_XDRSIZE,
 };
