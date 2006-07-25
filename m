Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWGYEU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWGYEU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 00:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWGYEU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 00:20:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:37306 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932431AbWGYEUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 00:20:55 -0400
From: Neil Brown <neilb@suse.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Date: Tue, 25 Jul 2006 14:20:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17605.39934.963857.665398@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 002 of 9] knfsd: knfsd: Remove an unused variable from e_show().
In-Reply-To: message from Josef Sipek on Tuesday July 25
References: <20060725114207.21779.patches@notabene>
	<1060725015432.21921@suse.de>
	<20060725041059.GA13294@filer.fsl.cs.sunysb.edu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 25, jsipek@fsl.cs.sunysb.edu wrote:
> On Tue, Jul 25, 2006 at 11:54:32AM +1000, NeilBrown wrote:
> ...
> > diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
> > --- .prev/fs/nfsd/export.c	2006-07-24 14:33:06.000000000 +1000
> > +++ ./fs/nfsd/export.c	2006-07-24 14:33:26.000000000 +1000
> > @@ -1178,7 +1178,6 @@ static int e_show(struct seq_file *m, vo
> ...
> >  	if (p == (void *)1) {
> 
> I'm not an NFS expert, but the above makes me want to puke. Isn't there a
> cleaner way of doing whatever needs to be done without:
> 
> 1) hard-coding a constant
> 2) comparing a variable to an arbitrary pointer
> 

Probably.  We just need a pointer value that is definitely not a
pointer to a valid cache_head object, and is not NULL.
(void*)1 seems a reasonable choice, but maybe #defineing something
would help.

Patches welcome.

NeilBrown
