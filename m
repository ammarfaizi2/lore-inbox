Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVCIK6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVCIK6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVCIK5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:57:48 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:11753 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262271AbVCIKyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:54:32 -0500
Date: Wed, 9 Mar 2005 16:34:04 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: aio stress panic on 2.6.11-mm1
Message-ID: <20050309110404.GA4088@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050308170107.231a145c.akpm@osdl.org> <1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com> <18744.1110364438@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18744.1110364438@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Any sense of how costly it is to use spin_lock_irq's vs spin_lock
(across different architectures) ? Isn't rwsem used very widely ?

Regards
Suparna

On Wed, Mar 09, 2005 at 10:33:58AM +0000, David Howells wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > If we want to take the spinlock from interrupt context, the non-interrupt
> > context code needs to do spin_lock_irq(), not spin_lock().
> 
> Yeah. I think I had a patch for that somewhere, but I think Linus turned it
> down. I can't find any emails on that subject though. I'll knock together a
> new patch for it.
> 
> David
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

