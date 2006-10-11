Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbWJKJUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbWJKJUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 05:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbWJKJUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 05:20:21 -0400
Received: from mail.suse.de ([195.135.220.2]:14317 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965217AbWJKJUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 05:20:19 -0400
From: Neil Brown <neilb@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Date: Wed, 11 Oct 2006 19:20:07 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17708.46919.675664.178234@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 000 of 4] Introduction
In-Reply-To: message from Ingo Molnar on Wednesday October 11
References: <20061011155522.7915.patches@notabene>
	<20061011085255.GA6051@elte.hu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday October 11, mingo@elte.hu wrote:
> >
> > I say "normally" because if a loop were created in the array->member 
> > hierarchy a deadlock could happen.  However that causes bigger 
> > problems than a deadlock and should be fixed independently.
> 
> ok to me. Sidenote: shouldnt we algorithmically forbid that "loop" 
> scenario from occuring, as that possibility is what causes lockdep to 
> complain about the worst-case scenario?

Yes we should.  Possibly we could use the linkage information set up
by bd_claim_by_kobject.  However I'm afraid that the locking required
to check that linkage safely will look very dead-lock prone to
lockdep.  I suspect that can be worked-around though.

NeilBrown
