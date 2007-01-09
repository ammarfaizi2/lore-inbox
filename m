Return-Path: <linux-kernel-owner+w=401wt.eu-S1751316AbXAIKnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbXAIKnD (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbXAIKnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:43:01 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:42142 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbXAIKm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:42:59 -0500
Date: Tue, 9 Jan 2007 05:36:59 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Shaya Potter <spotter@cs.columbia.edu>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070109103659.GB25438@filer.fsl.cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu> <1168229596875-git-send-email-jsipek@cs.sunysb.edu> <20070108111852.ee156a90.akpm@osdl.org> <Pine.LNX.4.63.0701081442230.19059@razor.cs.columbia.edu> <20070108131957.cbaf6736.akpm@osdl.org> <20070108232516.GB1269@filer.fsl.cs.sunysb.edu> <20070109094935.GA12406@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109094935.GA12406@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 09:49:35AM +0000, Christoph Hellwig wrote:
> On Mon, Jan 08, 2007 at 06:25:16PM -0500, Josef Sipek wrote:
> > > There's no such problem with bind mounts.  It's surprising to see such a
> > > restriction with union mounts.
> > 
> > Bind mounts are a purely VFS level construct. Unionfs is, as the name
> > implies, a filesystem. Last year at OLS, it seemed that a lot of people
> > agreed that unioning is neither purely a fs construct, nor purely a vfs
> > construct.
> > 
> > I'm using Unionfs (and ecryptfs) as guinea pigs to make linux fs stacking
> > friendly - a topic to be discussed at LSF in about a month.
> 
> And unionfs is the wrong thing do use for this.  Unioning is a complex
> namespace operation and needs to be implemented in the VFS or at least
> needs a lot of help from the VFS.  Getting namespace cache coherency
> and especially locking right is imposisble with out that.

What I meant was that I use them as an example for a linear and fanout
stacking examples. While unioning itself is a complex operation, the general
idea of one set of vfs objects (dentry, inode, etc.) pointing to several
lower ones is very generic and applies to all fan-out stackable fs.

Josef "Jeff" Sipek.

-- 
Linux, n.:
  Generous programmers from around the world all join forces to help
  you shoot yourself in the foot for free. 
