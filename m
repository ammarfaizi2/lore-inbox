Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263577AbUDZVKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbUDZVKZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 17:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbUDZVKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 17:10:24 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:63377 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263577AbUDZVKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 17:10:21 -0400
Subject: Re: [PATCH 11/11] nfs-acl
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1082975215.3295.81.camel@winden.suse.de>
References: <1082975215.3295.81.camel@winden.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083013819.15282.56.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Apr 2004 17:10:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-26 at 06:28, Andreas Gruenbacher wrote:
> Client nfsacl support
> 
> Add support for the nfsacl protocol extension to nfs.
> 

Why do we have to allocate an extra socket here? Can't we always assume
that the NFSACL server will listen on port 2049 (the same as the NFS
server)?

If so, we can simply clone the NFS rpc_client in order to share the
socket/security flavours/...

BTW: why does the client side NFS_ACL select QSORT? Can't userland do
all that for us?

Cheers,
  Trond
