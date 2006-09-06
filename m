Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751726AbWIFEyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbWIFEyO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 00:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWIFEyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 00:54:13 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39558 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751720AbWIFEyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 00:54:11 -0400
X-Sasl-enc: w8anZqKs5ke6xUjazT9r+lVo9Zx5TFHQyHuMSd39hBTR 1157518447
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Ian Kent <raven@themaw.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1157460777.5621.8.camel@localhost>
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
	 <1157436412.3915.26.camel@raven.themaw.net>
	 <1157439691.4133.12.camel@raven.themaw.net>
	 <1157460777.5621.8.camel@localhost>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 12:54:01 +0800
Message-Id: <1157518441.3066.18.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 08:52 -0400, Trond Myklebust wrote:
> On Tue, 2006-09-05 at 15:01 +0800, Ian Kent wrote:
> 
> > > autofs v4 doesn't rely on mkdir never returning EACCESS just that it
> > > return EEXIST if the directory exists. Never the less if the behavior of
> > > stat will work in this case I'll change v4 to do it the way you suggest
> > > (as v5 does already). 
> > 
> > Aaah. Wrong again!
> > 
> > Although v5 doesn't attempt to mount an NFS export if the directory
> > doesn't exist it does end up doing a mkdir later as the most common case
> > is mounting an NFS export within an autofs filesystem or other, usually
> > local filesystem.
> 
> Then make sure that it only does this within the autofs filesystem. The
> value of f_type as returned by statfs() should be able to tell you if
> this is the case.
> 

Yep. I've done that elsewhere.

Ian


