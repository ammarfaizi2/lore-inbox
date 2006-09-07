Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751895AbWIGFaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbWIGFaa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 01:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWIGFa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 01:30:29 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:5249 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751891AbWIGFa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 01:30:28 -0400
X-Sasl-enc: W7w/EZxCc6EEcGfUD2XO4zF6p/LvLHzCvn/M7FHK77BZ 1157607026
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Ian Kent <raven@themaw.net>
To: David Howells <dhowells@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, steved@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <15694.1157549082@warthog.cambridge.redhat.com>
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
Content-Type: text/plain
Date: Thu, 07 Sep 2006 13:30:18 +0800
Message-Id: <1157607018.5929.8.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 14:24 +0100, David Howells wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > It really doesn't matter whether there is a symlink or not. automounters
> > should _not_ be trying to create directories on any filesystem other
> > than the autofs filesystem itself.
> 
> Yes, I agree.

Not really.

What about multiple recursive bind mounts?
What about the initial directory for the autofs mount itself?

What about the case where a admin expects autofs to create these
directories for map entries that have multiple offsets.

As I've said before in version 5 I'm saying that it is a requirement
that the the directories already exist in this case but in version 4
people may have become accustomed to this behavior and right or wrong
this type of change shouldn't be made without warning to the users or
possibly not made at all.

Ian


