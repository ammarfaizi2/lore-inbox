Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUCLIlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 03:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUCLIlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 03:41:39 -0500
Received: from [193.108.190.253] ([193.108.190.253]:63189 "EHLO
	pluto.linuxkonsulent.dk") by vger.kernel.org with ESMTP
	id S262019AbUCLIli convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 03:41:38 -0500
Subject: Re: UID/GID mapping system
From: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1079034097.5205.37.camel@nidelv.trondhjem.org>
References: <1078775149.23059.25.camel@luke> <04031009285900.02381@tabby>
	 <1078941525.1343.19.camel@homer>  <04031015412900.03270@tabby>
	 <1078958747.1940.80.camel@nidelv.trondhjem.org>
	 <1078993757.1576.41.camel@quaoar>
	 <1079034097.5205.37.camel@nidelv.trondhjem.org>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1079080895.1571.11.camel@quaoar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 09:41:36 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 2004-03-11 kl. 20:41 skrev Trond Myklebust:
> > > If you really need uid/gid mapping for NFSv2/v3 too, why not just build
> > > on the existing v4 upcall/downcall mechanisms?
> > Because that would require changes to both ends of the wire. I want this
> > to:
> > 1. Work for ALL filesystems (NFS, smbfs, ext2(*) etc.)
> > 2. Be transparent for the server.
> No... I said to build on the upcall/downcall mechanism. I said nothing
> about modifying the on-the-wire protocol.

Oh, ok. I just haven't understood the NFSv4 up/down calls, then. There's
a userspace daemon listening for requests to map ID's and such? Does it
map usernames to uid'ss or uid's to uid's? Does it require the usernames
to be the same on the client and the server?

> The only way in which we fail to meet the above requirements are that
> the code to do it is in the NFS/RPC layers. Move it out of there, and it
> could be reused by everybody.
> No need for a third upcall/downcall mechanism that does the same thing.

That makes sense. I'll have to take a look at the nfs code before I do
anything else, though.

-- 
Salu2, Søren.

