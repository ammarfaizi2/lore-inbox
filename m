Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWCTOEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWCTOEq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 09:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWCTOEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 09:04:46 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:21729 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964805AbWCTOEp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 09:04:45 -0500
Date: Mon, 20 Mar 2006 19:35:03 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [3/3 PATCH] Kprobes: User space probes support- single stepping out-of-line
Message-ID: <20060320140503.GB18975@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060320060745.GC31091@in.ibm.com> <20060320060931.GD31091@in.ibm.com> <20060320061014.GE31091@in.ibm.com> <20060320061123.GF31091@in.ibm.com> <20060320030922.4ea9445b.akpm@osdl.org> <1142853841.3114.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142853841.3114.27.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 12:24:01PM +0100, Arjan van de Ven wrote:
> 
> Lines: 16
> 
> > And we'll need to actually *be* in-atomic.  That means we need an
> > open-coded inc_preempt_count() and dec_preempt_count() in there and I don't
> > see them.
> > 
> 
> ..
> 
> > Why is VM_LOCKED being set? (It needs a comment).
> > 
> > Where does it get unset?
> 
> 
> if this is an attempt to make the copy_in_atomic to be atomic, then it
> is a bug; the user can unset this bit after all via mprotect, even from
> another thread, and concurrently. U

You are right, the purpose was to make copy_to_user_inatomic() to suceed. I
need to look at this issue again. Any suggestions?

Thanks
Prasanna
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
