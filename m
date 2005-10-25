Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbVJYFo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbVJYFo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 01:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbVJYFo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 01:44:58 -0400
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:57097 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751462AbVJYFo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 01:44:57 -0400
To: viro@ftp.linux.org.uk
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20051025042519.GJ7992@ftp.linux.org.uk> (message from Al Viro on
	Tue, 25 Oct 2005 05:25:19 +0100)
Subject: Re: [PATCH 2/8] VFS: per inode statfs (core)
References: <E1EU5bT-0005sq-00@dorka.pomaz.szeredi.hu> <20051025042519.GJ7992@ftp.linux.org.uk>
Message-Id: <E1EUHbq-0006t6-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Oct 2005 07:44:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch adds a statfs method to inode operations.  This is invoked
> > whenever the dentry is available (not called from sys_ustat()) and the
> > filesystem implements this method.  Otherwise the normal
> > s_op->statfs() will be called.
> > 
> > This change is backward compatible, but calls to vfs_statfs() should
> > be changed to vfs_dentry_statfs() whenever possible.
> 
> What the fuck for?  statfs() returns data that by definition should
> not depend on inode within a filesystem.

Exactly.  But it's specified nowhere that there has to be a one-one
mapping between remote filesystem - local filesystem.

Miklos
