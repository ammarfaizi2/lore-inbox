Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWICTpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWICTpc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 15:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWICTpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 15:45:32 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:19630 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932150AbWICTpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 15:45:31 -0400
Date: Sun, 3 Sep 2006 15:44:56 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification Filesystem
Message-ID: <20060903194456.GA4977@filer.fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901115327.80554494.sfr@canb.auug.org.au> <20060901172310.GA2622@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0609031941210.12800@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609031941210.12800@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2006 at 07:42:53PM +0200, Jan Engelhardt wrote:
> >> > This set of patches constitutes Unionfs version 2.0. We are presenting it to
> >> > be reviewed and considered for inclusion into the kernel.
> >> 
> >> Small nit: is it possible to order these patches so that the kernel
> >> builds at each intermediate point (so we can use git bisect).  The
> >> easiest way to achieve this would be to do the Kconfig and Makefile
> >> updates last.
> >
> >Ideally, when Unionfs is commited into git, the whole thing would be one
> >commit - what's the point of having half of a filesystem?
> 
> So that you can eliminate e.g. locking bugs by searching in less code.

I think you misunderstood my comment. What I meant to say was that there is
_no way_ you can compile a filesystem that has only dentry ops but not
superblock ops - this would happen if you tried to bisect and you landed
half way in the series of commits for the filesystem. For the _initial_
commit one cset makes sense. For subsequent fixes one commit per fix is the
only logical thing to do.

Josef "Jeff" Sipek.

-- 
Bad pun of the week: The formula 1 control computer suffered from a race
condition

-- 
VGER BF report: H 7.95683e-07
