Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752466AbWKBVYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbWKBVYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626AbWKBVYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:24:51 -0500
Received: from pat.uio.no ([129.240.10.4]:57518 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1752455AbWKBVYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:24:50 -0500
Subject: Re: Security issues with local filesystem caching
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Karl MacMillan <kmacmill@redhat.com>,
       jmorris@namei.org, chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <32754.1162499917@redhat.com>
References: <1162496968.6071.38.camel@lade.trondhjem.org>
	 <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil>
	 <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <31035.1162330008@redhat.com>
	 <4417.1162395294@redhat.com> <25037.1162487801@redhat.com>
	 <32754.1162499917@redhat.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 16:24:27 -0500
Message-Id: <1162502667.6071.66.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.794, required 12,
	autolearn=disabled, AWL 1.21, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 20:38 +0000, David Howells wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > Just why are you doing all this? Why do we need a back-end that requires
> > all this extra client-side security infrastructure in order to work? 
> 
> Well, both Christoph and Al are of the opinion that I should be using
> vfs_mkdir() and co rather than bypassing the security and calling inode ops
> directly.

...but why are you needing to call vfs_mkdir? I thought the standard
cachefs backend just uses a pool of files, rather like the original AFS
cache did. Are you trying to mirror the layout and the permissions of
the NFS filesystem? That is a lot more work than it is worth...

> Also I should be setting security labels on the files I create.

To what end? These files shouldn't need to be made visible to userland
at all.

Cheers,
  Trond

