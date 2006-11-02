Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWKBUkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWKBUkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 15:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWKBUkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 15:40:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42913 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750733AbWKBUkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 15:40:12 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1162496968.6071.38.camel@lade.trondhjem.org> 
References: <1162496968.6071.38.camel@lade.trondhjem.org>  <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil> <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <31035.1162330008@redhat.com> <4417.1162395294@redhat.com> <25037.1162487801@redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       Karl MacMillan <kmacmill@redhat.com>, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 02 Nov 2006 20:38:37 +0000
Message-ID: <32754.1162499917@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> Just why are you doing all this? Why do we need a back-end that requires
> all this extra client-side security infrastructure in order to work? 

Well, both Christoph and Al are of the opinion that I should be using
vfs_mkdir() and co rather than bypassing the security and calling inode ops
directly.

Also I should be setting security labels on the files I create.

> IOW: What is wrong with the existing CacheFS?

Well, you did require it to be reviewed by Christoph...

David
