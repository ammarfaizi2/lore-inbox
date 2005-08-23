Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVHWUbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVHWUbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVHWUbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:31:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60593 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932381AbVHWUa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:30:58 -0400
Date: Tue, 23 Aug 2005 21:33:56 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] namei cleanup
Message-ID: <20050823203356.GF9322@parcelfarce.linux.theplanet.co.uk>
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu> <E1E7fMD-0006En-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1E7fMD-0006En-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 10:26:53PM +0200, Miklos Szeredi wrote:

Bad names, IMO.
  
> +static inline void dput_path(struct path *path, struct nameidata *nd)
> +{
> +	dput(path->dentry);
> +	if (path->mnt != nd->mnt)
> +		mntput(path->mnt);
> +}
> +
> +static inline void path_to_nameidata(struct path *path, struct nameidata *nd)
> +{
> +	dput(nd->dentry);
> +	if (nd->mnt != path->mnt)
> +		mntput(nd->mnt);
> +	nd->mnt = path->mnt;
> +	nd->dentry = path->dentry;
> +}
