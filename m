Return-Path: <linux-kernel-owner+w=401wt.eu-S965258AbWLOWFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258AbWLOWFj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 17:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965254AbWLOWFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 17:05:39 -0500
Received: from smtp.saahbs.net ([70.235.213.234]:34734 "HELO smtp.saahbs.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965259AbWLOWFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 17:05:39 -0500
Date: Fri, 15 Dec 2006 16:05:37 -0600
From: Michal Sabala <lkml@saahbs.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 mmap hangs unrelated apps
Message-ID: <20061215220537.GC16106@prosiaczek>
Reply-To: Michael Sabala <lkml@saahbs.net>
References: <20061215023014.GC2721@prosiaczek> <1166199855.5761.34.camel@lade.trondhjem.org> <20061215175030.GG6220@prosiaczek> <1166211884.5761.49.camel@lade.trondhjem.org> <20061215210642.GI6220@prosiaczek> <1166219054.5761.56.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1166219054.5761.56.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006/12/15 at 15:44:14 Trond Myklebust <trond.myklebust@fys.uio.no> wrote
> On Fri, 2006-12-15 at 15:06 -0600, Michal Sabala wrote:
> > Could this be related to the fact that the nfs mmaped file is unlinked
> > before it is ummaped? The .nfsXXXXXXX file disappears from the NFS
> > server as soon as test-mmap.c exits.
> 
> That shouldn't normally matter. The file won't be deleted until after
> the last user has stopped referencing it. However it is true that the
> trace you sent indicated that XFree86 was hanging in iput().
> 
> > What nfs_debug information would be useful in tracking this
> > problem? Is there any other information I can provide you?
> 
> Could you just out of interest try 2.6.20-rc1?

Trond,

I'll try 2.6.20-rc1 on Monday and post results to the list.

Thanks,
Michal

-- 
Michal "Saahbs" Sabala
