Return-Path: <linux-kernel-owner+w=401wt.eu-S965404AbXATWHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965404AbXATWHg (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 17:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965406AbXATWHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 17:07:36 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:59220 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965404AbXATWHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 17:07:35 -0500
Date: Sat, 20 Jan 2007 17:06:24 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       unionfs@filesystems.org
Subject: Re: [-mm patch] fs/unionfs/: possible cleanups
Message-ID: <20070120220624.GC25130@filer.fsl.cs.sunysb.edu>
References: <20070111222627.66bb75ab.akpm@osdl.org> <20070118215554.GG9093@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118215554.GG9093@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 10:55:54PM +0100, Adrian Bunk wrote:
> Let's start with a small exercise:
> 
> Consider sparse tells you about a global function:
>   warning: symbol 'unionfs_d_revalidate_wrap' was not declared. Should 
>   it be static?
 
I ran sparse last week, and cleaned up a few things (not commited to korg
yet). I'll use your patch instead.
 
> This patch contains the following possible cleanups:
> - every function should #include the headers containing the prototypes
>   of it's global functions
> - static functions in C files shouldn't be marked "inline", gcc should 
>   know best when to inline them
> - make needlessly global code static
> - #if 0 the following unused global function:
>   - stale_inode.c: is_stale_inode()
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
 
Thanks.
 
Josef "Jeff" Sipek.

-- 
NT is to UNIX what a doughnut is to a particle accelerator.
