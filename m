Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267757AbTAMCLH>; Sun, 12 Jan 2003 21:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267764AbTAMCLH>; Sun, 12 Jan 2003 21:11:07 -0500
Received: from havoc.daloft.com ([64.213.145.173]:59100 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267757AbTAMCLG>;
	Sun, 12 Jan 2003 21:11:06 -0500
Date: Sun, 12 Jan 2003 21:19:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] Secure user authentication for NFS using RPCSEC_GSS [0/6]
Message-ID: <20030113021951.GE18756@gtf.org>
References: <15906.1154.649765.791797@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15906.1154.649765.791797@charged.uio.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 01:12:50AM +0100, Trond Myklebust wrote:
> Our wish is to provide basic kernel RPC client support for the generic
> RPCSEC_GSS protocol, and for communicating with a userland daemon that
> does the actual the security context negotiation with the RPC server.
> Communication between kernel and userland is done over a set of named
> pipes (in much the same way as the CODA upcall/downcall is done) in a
> private ramfs-like filesystem.

Well, AFS also wants Kerb [but a weird Kerb4 variant IIRC], but,
OTOH why not do all this authentication and stuff in userspace?

Several other projects through the years have done similar things, where
a userspace daemon handles auth and such, and then passes an fd into
the kernel via ioctl [or write(2)ing fd value to a mini-ramfs VFS node].
