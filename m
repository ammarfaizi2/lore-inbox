Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbUCKI3X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 03:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbUCKI3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 03:29:23 -0500
Received: from [193.108.190.253] ([193.108.190.253]:1438 "EHLO
	pluto.linuxkonsulent.dk") by vger.kernel.org with ESMTP
	id S262892AbUCKI3T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 03:29:19 -0500
Subject: Re: UID/GID mapping system
From: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1078958747.1940.80.camel@nidelv.trondhjem.org>
References: <1078775149.23059.25.camel@luke> <04031009285900.02381@tabby>
	 <1078941525.1343.19.camel@homer>  <04031015412900.03270@tabby>
	 <1078958747.1940.80.camel@nidelv.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1078993757.1576.41.camel@quaoar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 09:29:17 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons, 2004-03-10 kl. 23:45 skrev Trond Myklebust:
> The NFSv4 client and server already do uid/gid mapping. That is
> *mandatory* in the NFSv4 protocol, which dictates that you are only
> allowed to send strings of the form user@domain on the wire.

Clever! 

> If you really need uid/gid mapping for NFSv2/v3 too, why not just build
> on the existing v4 upcall/downcall mechanisms?

Because that would require changes to both ends of the wire. I want this
to:
1. Work for ALL filesystems (NFS, smbfs, ext2(*) etc.)
2. Be transparent for the server.

*: For ext2, this could come in handy if you are moving disks between
systems.

-- 
Salu2, Søren.

