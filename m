Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWDUTeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWDUTeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWDUTeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:34:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14765 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932354AbWDUTeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:34:07 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060421113805.2ec6fd74.akpm@osdl.org> 
References: <20060421113805.2ec6fd74.akpm@osdl.org>  <20060420174622.6d7390d6.akpm@osdl.org> <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com> <20060420165937.9968.57149.stgit@warthog.cambridge.redhat.com> <18005.1145628949@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       sct@redhat.com, aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] FS-Cache: Generic filesystem caching facility 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 21 Apr 2006 20:33:49 +0100
Message-ID: <17634.1145648029@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > Modules that might depend on fscache need to know that it's there,
> 
> In theory, module A isn't supposed to care whether module B was configured,
> because module B might be compiled separately, or dowloaded from elsewhere
> or whatever.

In this case it's sort of necessary - unless you're suggesting I make FS-Cache
mandatory...

The problem is that I don't want NFS or whatever to be carrying around the
cookie pointers if FS-Cache isn't compiled as that saves memory.  But that
involves conditionally changing the composition of structures, something
that's most clearly done with cpp-conditionals.

David
