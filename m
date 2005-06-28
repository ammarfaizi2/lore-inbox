Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVF1GaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVF1GaO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVF1G3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:29:07 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:10218 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261645AbVF1GJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:09:55 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 28 Jun 2005 16:09:44 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17088.59816.277303.588185@cse.unsw.edu.au>
Cc: earny@net4u.de, linux-kernel@vger.kernel.org
Subject: Re: dirty md raid5 slab bio leak
In-Reply-To: message from Andrew Morton on Monday June 27
References: <200506272222.51993.list-lkml@net4u.de>
	<17088.41384.864708.23860@cse.unsw.edu.au>
	<17088.52861.78252.726904@cse.unsw.edu.au>
	<20050627212511.11402fd1.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
X-CSE-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	note.orchestra.cse.unsw.EDU.AU
X-CSE-Spam-Level: 
X-CSE-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 27, akpm@osdl.org wrote:
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> >
> > It's OK, I found it.  The bio leaks when writing the md superblock.
> > 
> 
> Thanks.
> 
> >  insert a missing bio_put when writting the md superblock.
> 
> Does 2.6.12.x need this?

Hmmm.. probably, though it isn't Ooopsable, and isn't a security
problem.  Just a slow leak with a trivial patch...  

Is there a web-page somewhere that lists the acceptance criterea? I
didn't save the mail message.

Do I just mail the patch to stable@kernel.org ??

NeilBrown
