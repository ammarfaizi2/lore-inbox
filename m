Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWE3Kw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWE3Kw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWE3Kw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:52:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25273 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932181AbWE3Kwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:52:55 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060530103550.GV27946@ftp.linux.org.uk> 
References: <20060530103550.GV27946@ftp.linux.org.uk>  <20060519154640.11791.2928.stgit@warthog.cambridge.redhat.com> <20060519154650.11791.71116.stgit@warthog.cambridge.redhat.com> 
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       steved@redhat.com, trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/14] NFS: Abstract out namespace initialisation [try #10] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 30 May 2006 11:51:28 +0100
Message-ID: <23521.1148986288@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:

> > The attached patch abstracts out the namespace initialisation so that
> > temporary namespaces can be set up elsewhere.
> 
> IDGI...   Where does your patchset use it?

Hmmm... That's a good point.  It doesn't any more.  This patch is obsolete and
can be dropped.

It used to be used to set up a separate namespace in which to do NFSv4 path
traversal during mount so that we could walk from '/' to the nominated
directory on the NFS4 server using link_path_walk(), but the patches don't do
that now.

David
