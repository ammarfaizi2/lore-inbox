Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWGYELS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWGYELS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 00:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWGYELS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 00:11:18 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:17815 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932427AbWGYELR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 00:11:17 -0400
Date: Tue, 25 Jul 2006 00:10:59 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 002 of 9] knfsd: knfsd: Remove an unused variable from e_show().
Message-ID: <20060725041059.GA13294@filer.fsl.cs.sunysb.edu>
References: <20060725114207.21779.patches@notabene> <1060725015432.21921@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060725015432.21921@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 11:54:32AM +1000, NeilBrown wrote:
...
> diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
> --- .prev/fs/nfsd/export.c	2006-07-24 14:33:06.000000000 +1000
> +++ ./fs/nfsd/export.c	2006-07-24 14:33:26.000000000 +1000
> @@ -1178,7 +1178,6 @@ static int e_show(struct seq_file *m, vo
...
>  	if (p == (void *)1) {

I'm not an NFS expert, but the above makes me want to puke. Isn't there a
cleaner way of doing whatever needs to be done without:

1) hard-coding a constant
2) comparing a variable to an arbitrary pointer

Josef Sipek.

-- 
If I have trouble installing Linux, something is wrong. Very wrong.
		- Linus Torvalds
