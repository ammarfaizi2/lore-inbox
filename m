Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbQLDF67>; Mon, 4 Dec 2000 00:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130546AbQLDF6t>; Mon, 4 Dec 2000 00:58:49 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:8713 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S129908AbQLDF6c>; Mon, 4 Dec 2000 00:58:32 -0500
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: Re: negative NFS cookies: bad C library or bad kernel?
In-Reply-To: <vbaaeae2joz.fsf@mozart.stat.wisc.edu>
	<14890.19197.796098.104054@charged.uio.no>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Trond Myklebust's message of "Sun, 3 Dec 2000 14:30:37 +0100 (CET)"
Date: 03 Dec 2000 23:28:02 -0600
Message-ID: <vbaelzo21st.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> 
> The problem then arises that lseek tries to cram both a returned
> offset and an error value into the return values.

Oops.  You're right; I didn't think of this.

So, I guess the best short-term solution is to fix the C library so it
always uses llseek for directories and never tries something stupid
like a SEEK_CUR.  Then, at least it'll always work for NFSv2.  I'll
file a bug report.

At the same time, a patch for CFS to use "small" (from a little-endian
perspective) cookies couldn't hurt, so I'll do that, too.

Thanks for the help.

Kevin <buhr@stat.wisc.edu>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
