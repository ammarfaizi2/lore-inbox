Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965184AbWIEJlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbWIEJlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 05:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWIEJlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 05:41:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28073 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965184AbWIEJlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 05:41:08 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1157436412.3915.26.camel@raven.themaw.net> 
References: <1157436412.3915.26.camel@raven.themaw.net>  <20060901195009.187af603.akpm@osdl.org> <20060831102127.8fb9a24b.akpm@osdl.org> <20060830135503.98f57ff3.akpm@osdl.org> <20060830125239.6504d71a.akpm@osdl.org> <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com> <27414.1156970238@warthog.cambridge.redhat.com> <9849.1157018310@warthog.cambridge.redhat.com> <9534.1157116114@warthog.cambridge.redhat.com> <20060901093451.87aa486d.akpm@osdl.org> <1157130044.5632.87.camel@localhost> <28945.1157370732@warthog.cambridge.redhat.com> <1157376295.3240.13.camel@raven.themaw.net> <1157421445.5510.13.camel@localhost> <1157424937.3002.4.camel@raven.themaw.net> <1157428241.5510.72.camel@localhost> <1157429030.3915.8.camel@raven.themaw.net> <1157432039.32412.37.camel@localhost> 
To: Ian Kent <raven@themaw.net>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock sharing [try #13] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 05 Sep 2006 10:40:49 +0100
Message-ID: <3698.1157449249@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> autofs v4 doesn't rely on mkdir never returning EACCESS just that it
> return EEXIST if the directory exists. Never the less if the behavior of
> stat will work in this case I'll change v4 to do it the way you suggest
> (as v5 does already). 

As long as you don't rely on stat...mkdir working.  That can go wrong if the
dentry gets booted from the dcache by memory pressure in the "...".

David
