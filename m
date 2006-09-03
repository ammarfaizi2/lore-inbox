Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWICQ6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWICQ6e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 12:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWICQ6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 12:58:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43500 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751427AbWICQ6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 12:58:32 -0400
Date: Sun, 3 Sep 2006 09:58:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ian Kent <raven@themaw.net>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
 sharing [try #13]
Message-Id: <20060903095809.c83b8c0b.akpm@osdl.org>
In-Reply-To: <1157265781.3520.18.camel@raven.themaw.net>
References: <20060831102127.8fb9a24b.akpm@osdl.org>
	<20060830135503.98f57ff3.akpm@osdl.org>
	<20060830125239.6504d71a.akpm@osdl.org>
	<20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	<27414.1156970238@warthog.cambridge.redhat.com>
	<9849.1157018310@warthog.cambridge.redhat.com>
	<9534.1157116114@warthog.cambridge.redhat.com>
	<20060901093451.87aa486d.akpm@osdl.org>
	<1157130044.5632.87.camel@localhost>
	<20060901195009.187af603.akpm@osdl.org>
	<1157170272.3307.5.camel@raven.themaw.net>
	<20060901225853.0171fd29.akpm@osdl.org>
	<1157264490.3520.16.camel@raven.themaw.net>
	<20060902233023.ce544a00.akpm@osdl.org>
	<1157265781.3520.18.camel@raven.themaw.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Sep 2006 14:43:00 +0800
Ian Kent <raven@themaw.net> wrote:

> On Sat, 2006-09-02 at 23:30 -0700, Andrew Morton wrote:
> > On Sun, 03 Sep 2006 14:21:30 +0800
> > Ian Kent <raven@themaw.net> wrote:
> > 
> > > I guess you haven't got the autofs module loaded instead of autofs4 by
> > > mistake.
> > 
> > Nope.
> > 
> > > So I wonder what the different is between the setups?
> > 
> > Beats me.  Maybe cook up a debug patch?
> 
> OK.
> 
> Could you add "--debug" to DAEMONOPTIONS in /etc/sysconfig/autofs and
> post the output so I can get some idea where to put the prints please.
> 

Sep  3 09:56:40 sony automount[18446]: starting automounter version 4.1.4-29, path = /net, maptype = program, mapname = /etc/auto.net
Sep  3 09:56:40 sony kernel: SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
Sep  3 09:56:40 sony automount[18446]: using kernel protocol version 4.00
Sep  3 09:56:40 sony automount[18446]: using timeout 60 seconds; freq 15 secs
Sep  3 09:56:53 sony automount[18446]: attempting to mount entry /net/bix
Sep  3 09:56:53 sony kernel: SELinux: initialized (dev 0:16, type nfs), uses genfs_contexts
Sep  3 09:56:53 sony automount[18453]: mount(nfs): mkdir_path /net/bix/usr/src failed: Permission denied
Sep  3 09:56:53 sony automount[18453]: mount(nfs): mkdir_path /net/bix/mnt/export failed: Permission denied

-- 
VGER BF report: H 0.0383034
