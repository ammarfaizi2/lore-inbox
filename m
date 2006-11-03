Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753248AbWKCPeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbWKCPeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 10:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753269AbWKCPeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 10:34:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51333 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753248AbWKCPet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 10:34:49 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1162561291.5635.64.camel@lade.trondhjem.org> 
References: <1162561291.5635.64.camel@lade.trondhjem.org>  <1162502667.6071.66.camel@lade.trondhjem.org> <1162496968.6071.38.camel@lade.trondhjem.org> <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil> <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <31035.1162330008@redhat.com> <4417.1162395294@redhat.com> <25037.1162487801@redhat.com> <32754.1162499917@redhat.com> <12984.1162549621@redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       Karl MacMillan <kmacmill@redhat.com>, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 03 Nov 2006 15:33:18 +0000
Message-ID: <23076.1162567998@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> No. I was thinking of keeping the cache on its own partition

That's a requirement I am specifically avoiding with CacheFiles.  I might, for
instance, want to use it on my laptop, and I don't really have enough space to
set aside a partition just for that.  The whole point of CacheFiles is that
you don't have to set one aside.  If you're going to do that, then CacheFS
should be a better option.

> and using kernel mounts. cachefilesd could possibly mount the thing in its
> own private namespace.

That's still user visible, and SELinux in enforcing mode would still apply.

David
