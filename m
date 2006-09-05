Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWIEMxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWIEMxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 08:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWIEMxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 08:53:54 -0400
Received: from pat.uio.no ([129.240.10.4]:49048 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932150AbWIEMxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 08:53:52 -0400
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Ian Kent <raven@themaw.net>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1157460472.5621.3.camel@localhost>
References: <1157421445.5510.13.camel@localhost>
	 <20060901195009.187af603.akpm@osdl.org>
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
	 <1157376295.3240.13.camel@raven.themaw.net>
	 <4012.1157450226@warthog.cambridge.redhat.com>
	 <1157460472.5621.3.camel@localhost>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 08:53:35 -0400
Message-Id: <1157460815.5621.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.117, required 12,
	autolearn=disabled, AWL 1.88, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 08:47 -0400, Trond Myklebust wrote:
> On Tue, 2006-09-05 at 10:57 +0100, David Howells wrote:
> > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > 
> > > Why the hell is it doing a mkdir in the first place?
> > 
> > I think the problems it is solving are these:
> > 
> >  (1) What happens if "/" is _not_ exported?
> > 
> >  (2) What happens if some intermediate directory (say "/usr") is not
> >      accessible?
> > 
> > 
> > In the first case, the automounter just makes "usr" and "usr/src", say, in the
> > autofs filesystem, and then mounts server:/usr/src on that.
> 
> That is fine. As long as it is doing so in the _autofs_ filesystem. A
> call to 'stat()' should suffice to tell if this is the case.

I meant statfs().


