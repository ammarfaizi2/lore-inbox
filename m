Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751948AbWIGGRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbWIGGRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 02:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbWIGGRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 02:17:32 -0400
Received: from pat.uio.no ([129.240.10.4]:2951 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751947AbWIGGRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 02:17:31 -0400
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1157607018.5929.8.camel@raven.themaw.net>
References: <1157546813.5541.8.camel@lade.trondhjem.org>
	 <1157518718.3066.22.camel@raven.themaw.net>
	 <1157458817.4133.29.camel@raven.themaw.net>
	 <1157451611.4133.22.camel@raven.themaw.net>
	 <1157436412.3915.26.camel@raven.themaw.net>
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
	 <1157421445.5510.13.camel@localhost>
	 <1157424937.3002.4.camel@raven.themaw.net>
	 <1157428241.5510.72.camel@localhost>
	 <1157429030.3915.8.camel@raven.themaw.net>
	 <1157432039.32412.37.camel@localhost>
	 <3698.1157449249@warth! og.cambridge.redhat.com>
	 <4987.1157452656@war! thog.cambridge.redhat.com>
	 <11346.1157463522@warthog.cambridge.redhat.com>
	 <8912.1157536306@warthog.cambridge.redhat.com>
	 <15694.1157549082@warthog.cambridge.redhat.com>
	 <1157607018.5929.8.camel@raven.themaw.net>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 02:17:13 -0400
Message-Id: <1157609833.5787.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.727, required 12,
	autolearn=disabled, AWL 1.14, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-07 at 13:30 +0800, Ian Kent wrote:
> On Wed, 2006-09-06 at 14:24 +0100, David Howells wrote:
> > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > 
> > > It really doesn't matter whether there is a symlink or not. automounters
> > > should _not_ be trying to create directories on any filesystem other
> > > than the autofs filesystem itself.
> > 
> > Yes, I agree.
> 
> Not really.
> 
> What about multiple recursive bind mounts?
> What about the initial directory for the autofs mount itself?
> 
> What about the case where a admin expects autofs to create these
> directories for map entries that have multiple offsets.
> 
> As I've said before in version 5 I'm saying that it is a requirement
> that the the directories already exist in this case but in version 4
> people may have become accustomed to this behavior and right or wrong
> this type of change shouldn't be made without warning to the users or
> possibly not made at all.

What part of the phrase "security risk" are you failing to understand?
If anybody out there is actually relying on having an automounter daemon
that is running with root privileges try to create directories on remote
servers on the basis of the output of the 'showmount' command, then they
need saving from themselves.

