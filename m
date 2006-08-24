Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWHXHgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWHXHgR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 03:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWHXHgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 03:36:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12493 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750715AbWHXHgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 03:36:16 -0400
Subject: Re: [PATCH] nfsd: lockdep annotation
From: Arjan van de Ven <arjan@infradead.org>
To: Neil Brown <neilb@suse.de>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <17645.17252.217583.660976@cse.unsw.edu.au>
References: <1156330112.3382.34.camel@twins>
	 <17645.17252.217583.660976@cse.unsw.edu.au>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 24 Aug 2006 09:35:51 +0200
Message-Id: <1156404952.3014.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 16:12 +1000, Neil Brown wrote:
> On Wednesday August 23, a.p.zijlstra@chello.nl wrote:
> > Hi,
> > 
> > while doing a kernel make modules_install install over an NFS mount.
> > (
> > 
> > =============================================
> > [ INFO: possible recursive locking detected ]
> > ---------------------------------------------
> 
> Thanks for the patch.  I had a patch to fix this in my queue, but I
> just hadn't got around to submitting it yet :-(
> Never mind, we'll go with yours and Andrew already has it.
> 
> I had flags the fh_lock in nfsd_setattr a I_MUTEX_CHILD which you
> didn't however I see that isn't needed (Why do we have PARENT and
> CHILD and NORMAL.... you would think that any two would do ??)

for cross directory renames 3 are needed ;(


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

