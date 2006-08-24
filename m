Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWHXGNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWHXGNH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWHXGNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:13:07 -0400
Received: from ns2.suse.de ([195.135.220.15]:46511 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030323AbWHXGNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:13:04 -0400
From: Neil Brown <neilb@suse.de>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Thu, 24 Aug 2006 16:12:52 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17645.17252.217583.660976@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       arjan <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] nfsd: lockdep annotation
In-Reply-To: message from Peter Zijlstra on Wednesday August 23
References: <1156330112.3382.34.camel@twins>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 23, a.p.zijlstra@chello.nl wrote:
> Hi,
> 
> while doing a kernel make modules_install install over an NFS mount.
> (
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------

Thanks for the patch.  I had a patch to fix this in my queue, but I
just hadn't got around to submitting it yet :-(
Never mind, we'll go with yours and Andrew already has it.

I had flags the fh_lock in nfsd_setattr a I_MUTEX_CHILD which you
didn't however I see that isn't needed (Why do we have PARENT and
CHILD and NORMAL.... you would think that any two would do ??)

However there is a bit missing: the fh_lock in nfsd_proc_create
in nfsproc.c needs I_MUTEX_PARENT - I'll send a separate patch to fix
that.

Thanks,
NeilBrown

