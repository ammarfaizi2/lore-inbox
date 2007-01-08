Return-Path: <linux-kernel-owner+w=401wt.eu-S1750734AbXAHX35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbXAHX35 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbXAHX35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:29:57 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:52230 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbXAHX34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:29:56 -0500
Date: Mon, 8 Jan 2007 18:25:16 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: Shaya Potter <spotter@cs.columbia.edu>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070108232516.GB1269@filer.fsl.cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu> <1168229596875-git-send-email-jsipek@cs.sunysb.edu> <20070108111852.ee156a90.akpm@osdl.org> <Pine.LNX.4.63.0701081442230.19059@razor.cs.columbia.edu> <20070108131957.cbaf6736.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108131957.cbaf6736.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 01:19:57PM -0800, Andrew Morton wrote:
... 
> If it's not in the changelog or the documentation, it doesn't exist.

Good point. I'll add it for next time.

> >  It's the same thing as modifying a block 
> > device while a file system is using it.  Now, when unionfs gets confused, 
> > it shouldn't oops, but would one expect ext3 to allow one to modify its 
> > backing store while its using it?
> 
> There's no such problem with bind mounts.  It's surprising to see such a
> restriction with union mounts.

Bind mounts are a purely VFS level construct. Unionfs is, as the name
implies, a filesystem. Last year at OLS, it seemed that a lot of people
agreed that unioning is neither purely a fs construct, nor purely a vfs
construct.

I'm using Unionfs (and ecryptfs) as guinea pigs to make linux fs stacking
friendly - a topic to be discussed at LSF in about a month.

Josef "Jeff" Sipek.

-- 
Computer Science is no more about computers than astronomy is about
telescopes.
		- Edsger Dijkstra
