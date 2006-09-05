Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbWIEGHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWIEGHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 02:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWIEGHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 02:07:05 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57003 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S965166AbWIEGHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 02:07:03 -0400
X-Sasl-enc: e4lz/0k88ew5k80Xq8BLx5cF3n7qEgHJUxx0Uv6fU234 1157436422
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Ian Kent <raven@themaw.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1157432039.32412.37.camel@localhost>
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
	 <1157376295.3240.13.camel@raven.themaw.net>
	 <1157421445.5510.13.camel@localhost>
	 <1157424937.3002.4.camel@raven.themaw.net>
	 <1157428241.5510.72.camel@localhost>
	 <1157429030.3915.8.camel@raven.themaw.net>
	 <1157432039.32412.37.camel@localhost>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 14:06:52 +0800
Message-Id: <1157436412.3915.26.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 00:53 -0400, Trond Myklebust wrote:
> On Tue, 2006-09-05 at 12:03 +0800, Ian Kent wrote:
> > Sure but this is an old version of autofs which is in use so changing
> > the expected behavior of a system call is not acceptable and I expect
> > other applications may well have a problem with this also.
> 
> Applications that rely on mkdir() to never return EACCES are broken.
> Particularly so in an selinux system (as was the case here).

That's not quite right.

autofs v4 doesn't rely on mkdir never returning EACCESS just that it
return EEXIST if the directory exists. Never the less if the behavior of
stat will work in this case I'll change v4 to do it the way you suggest
(as v5 does already). 



