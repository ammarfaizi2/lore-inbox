Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262800AbSJWQpa>; Wed, 23 Oct 2002 12:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbSJWQpa>; Wed, 23 Oct 2002 12:45:30 -0400
Received: from sentry.gw.tislabs.com ([192.94.214.100]:35306 "EHLO
	sentry.gw.tislabs.com") by vger.kernel.org with ESMTP
	id <S262800AbSJWQp3>; Wed, 23 Oct 2002 12:45:29 -0400
Date: Wed, 23 Oct 2002 12:51:08 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
X-X-Sender: <sds@raven>
To: Christoph Hellwig <hch@infradead.org>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Russell Coker <russell@coker.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-security-module@wirex.com>
Subject: Re: [PATCH] remove sys_security
In-Reply-To: <20021023173635.A15896@infradead.org>
Message-ID: <Pine.GSO.4.33.0210231241300.7042-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Oct 2002, Christoph Hellwig wrote:

> Why are you limited to a single fs?  xfs and jfs have xattr support
> out of the box (in 2.4 only jfs is actually in the mainline tree, though)

Most of our users (and we) happen to use ext[23], so there isn't any point
in migrating SELinux to using EAs until EA implementations are merged into
those filesystems.  Also, the EA API lacks support for creating files with
specified security attributes (as opposed to creating and then calling
setxattr to change the attributes, possibly after someone has already
obtained access to the file), so it isn't ideal for our purposes anyway.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




