Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWHRPvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWHRPvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbWHRPvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:51:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31164 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161020AbWHRPvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:51:20 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <76bd70e30608180843m536e9f57y90e1915f40f85b2@mail.gmail.com> 
References: <76bd70e30608180843m536e9f57y90e1915f40f85b2@mail.gmail.com>  <20060818153502.29482.91650.stgit@warthog.cambridge.redhat.com> <20060818153514.29482.78513.stgit@warthog.cambridge.redhat.com> 
To: "Chuck Lever" <chucklever@gmail.com>
Cc: "David Howells" <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       steved@redhat.com, trond.myklebust@fys.uio.no,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] NFS: Use local caching [try #12] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 18 Aug 2006 16:51:06 +0100
Message-ID: <30101.1155916266@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever <chucklever@gmail.com> wrote:

> > +static uint16_t nfs_server_get_key(const void *cookie_netfs_data,
> > +                                  void *buffer, uint16_t bufmax)
> > +{
> 
> Why don't you use the function declaration style that is used in the
> rest of the NFS client?

Actually, the NFS client has several different styles, and mine's not without
precedent, eg:

extern int nfs3_setxattr(struct dentry *, const char *,
			const void *, size_t, int);

extern ssize_t nfs_direct_IO(int, struct kiocb *, const struct iovec *, loff_t,
			unsigned long);

static inline loff_t
nfs_size_to_loff_t(__u64 size)

> All the parameters belong on one line, don't they?

Depends how much you want to upset those people who tremble with anxiety at
the sight of a line longer than 80 chars.

David
