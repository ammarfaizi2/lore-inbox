Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVAMFbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVAMFbr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 00:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVAMFbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 00:31:47 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:3974 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261152AbVAMFbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 00:31:45 -0500
To: akpm@osdl.org
CC: torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20050112143652.6adfcc1b.akpm@osdl.org> (message from Andrew
	Morton on Wed, 12 Jan 2005 14:36:52 -0800)
Subject: Re: [PATCH 2/11] FUSE - core
References: <E1CoOpP-0003Jb-00@dorka.pomaz.szeredi.hu> <20050112143652.6adfcc1b.akpm@osdl.org>
Message-Id: <E1CoxZv-0002VM-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Jan 2005 06:31:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +static int fuse_fill_super(struct super_block *sb, void *data, int silent)
> > +{
> > ...
> > +	if (!inc_mount_count() && current->uid != 0)
> > +		goto err;
> 
> The open-coded current->uid test needs to go.  capable(CAP_SYS_ADMIN)?

OK.

Thanks,
Miklos
