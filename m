Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946493AbWJSUwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946493AbWJSUwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946489AbWJSUwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:52:09 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:60545 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1946491AbWJSUwH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:52:07 -0400
To: Trond.Myklebust@netapp.com
CC: torvalds@osdl.org, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
In-reply-to: <20061019171113.8593.8585.stgit@lade.trondhjem.org> (message from
	Trond Myklebust on Thu, 19 Oct 2006 13:11:13 -0400)
Subject: Re: [PATCH 1/2] VFS: Make d_materialise_unique() enforce directory
	uniqueness
References: <20061019171113.8593.8585.stgit@lade.trondhjem.org>
Message-Id: <E1GaerI-0007Af-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 19 Oct 2006 22:51:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Trond Myklebust <Trond.Myklebust@netapp.com>
> 
> If the caller tries to instantiate a directory using an inode that already
> has a dentry alias, then we attempt to rename the existing dentry instead
> of instantiating a new one. Fail with an ELOOP error if the rename would
> affect one of our parent directories.
> 
> This behaviour is needed in order to avoid issues such as
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=7178
>

This looks like a stale patch.  You posted one on -fsdevel that did
i_mutex locking as well.

Miklos
