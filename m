Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbWIEHID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbWIEHID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 03:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbWIEHID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 03:08:03 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:641 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S965184AbWIEHIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 03:08:00 -0400
X-Sasl-enc: V23ya0t05KECJvIwqa11gm8yJ/OYwGZ0IonMj2hst79+ 1157440079
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Ian Kent <raven@themaw.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1157438714.4133.0.camel@raven.themaw.net>
References: <20060901195009.187af603.akpm@osdl.org>
	 <20060831102127.8fb9a24b.akpm@osdl.org>
	 <20060830135503.98f57ff3.akpm@osdl.org>
	 <20060830125239.6504d71a.akpm@osdl.org>
	 <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	 <27414.1156970238@warthog.cambridge.redhat.com>
	 <9849.1157018310@warthog.cambridge.redhat.com>
	 <9534.1157116114@warthog.cambridge.redhat.com>
	 <20060901093451.87aa486d.akpm@osdl.org>
	 <1157130044.5632.87.camel@localhost>
	 <28945.1157370732@warthog.cambridge.redhat.com>
	 <1157423027.5510.23.camel@localhost>
	 <1157429219.3915.11.camel@raven.themaw.net>
	 <1157432221.32412.41.camel@localhost>
	 <1157438714.4133.0.camel@raven.themaw.net>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 15:07:52 +0800
Message-Id: <1157440072.4133.14.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 14:45 +0800, Ian Kent wrote:
> On Tue, 2006-09-05 at 00:57 -0400, Trond Myklebust wrote:
> > On Tue, 2006-09-05 at 12:06 +0800, Ian Kent wrote:
> > 
> > > > One way to fix this is to simply not hash the dentry when we're doing
> > > > the O_EXCL intent optimisation, but rather to only hash it _after_ we've
> > > > successfully created the file on the server. Something like the attached
> > > > patch ought to do it.
> > > 
> > > No.
> > > 
> > > This patch simply marks the dentry negative and returns ENOMEM from the
> > > lookup which, as would be expected, results in this error being returned
> > > to userspace.
> > 
> > Oops. You are right. I forgot to set res=NULL...
> 
> Now returns EPERM.

Sorry that's EACCES.



