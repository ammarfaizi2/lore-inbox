Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130292AbRBZOeb>; Mon, 26 Feb 2001 09:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130257AbRBZOcZ>; Mon, 26 Feb 2001 09:32:25 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130230AbRBZO3e>;
	Mon, 26 Feb 2001 09:29:34 -0500
Date: Mon, 26 Feb 2001 10:54:02 +0100 (MET)
From: Lennert Buytenhek <buytenh@math.leidenuniv.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>, David Fries <dfries@umr.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Stale NFS handles on 2.4.2
In-Reply-To: <shsvgpyual0.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.30.0102261052520.16700-100000@page.math.leidenuniv.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 Feb 2001, Trond Myklebust wrote:

>      > I was hopping to avoid unmounting, as I would have to shut
>      > about everything down to do that.
>
> It looks as if you'll have to do that. 'mount -oremount' does not
> really cause the root filehandle to get updated. The only thing it
> does at the moment is allow you to change from a read-only to a
> read-write filesystem.

A trick that works for me is mounting the NFS filesystem on another mount
point and unmounting it there. This usually makes the mount on the
original mount point magically work again.


cheers,
Lennert

