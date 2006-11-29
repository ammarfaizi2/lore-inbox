Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966875AbWK2KPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966875AbWK2KPD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966867AbWK2KPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:15:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58081 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966798AbWK2KO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:14:59 -0500
Subject: Re: [-mm patch] #if 0 fs/gfs2/acl.c:gfs2_check_acl()
From: Steven Whitehouse <swhiteho@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       cluster-devel@redhat.com
In-Reply-To: <20061129100401.GH11084@stusta.de>
References: <20061128020246.47e481eb.akpm@osdl.org>
	 <20061129100401.GH11084@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Wed, 29 Nov 2006 10:14:13 +0000
Message-Id: <1164795253.3752.46.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A better solution is just to remove it I think, so thats what I'll do in
my git tree. Thanks for pointing it out,

Steve.

On Wed, 2006-11-29 at 11:04 +0100, Adrian Bunk wrote:
> On Tue, Nov 28, 2006 at 02:02:46AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.19-rc6-mm1:
> >...
> >  git-gfs2-nmw.patch
> >...
> >  git trees
> >...
> 
> 
> This patch #if 0's the no longer used gfs2_check_acl().
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  fs/gfs2/acl.c |    2 ++
>  fs/gfs2/acl.h |    1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.19-rc6-mm2/fs/gfs2/acl.h.old	2006-11-29 08:49:13.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/fs/gfs2/acl.h	2006-11-29 08:49:22.000000000 +0100
> @@ -32,7 +32,6 @@
>  			  int *remove, mode_t *mode);
>  int gfs2_acl_validate_remove(struct gfs2_inode *ip, int access);
>  int gfs2_check_acl_locked(struct inode *inode, int mask);
> -int gfs2_check_acl(struct inode *inode, int mask);
>  int gfs2_acl_create(struct gfs2_inode *dip, struct gfs2_inode *ip);
>  int gfs2_acl_chmod(struct gfs2_inode *ip, struct iattr *attr);
>  
> --- linux-2.6.19-rc6-mm2/fs/gfs2/acl.c.old	2006-11-29 08:49:31.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/fs/gfs2/acl.c	2006-11-29 08:49:45.000000000 +0100
> @@ -170,6 +170,7 @@
>  	return -EAGAIN;
>  }
>  
> +#if 0
>  int gfs2_check_acl(struct inode *inode, int mask)
>  {
>  	struct gfs2_inode *ip = GFS2_I(inode);
> @@ -184,6 +185,7 @@
>  
>  	return error;
>  }
> +#endif  /*  0  */
>  
>  static int munge_mode(struct gfs2_inode *ip, mode_t mode)
>  {
> 

