Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263148AbUJ2Cna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbUJ2Cna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 22:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbUJ2CdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 22:33:05 -0400
Received: from colin2.muc.de ([193.149.48.15]:11026 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263147AbUJ1XmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:42:18 -0400
Date: 29 Oct 2004 01:42:17 +0200
Date: Fri, 29 Oct 2004 01:42:17 +0200
From: Andi Kleen <ak@muc.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com,
       dprobes@www-124.southbury.usf.ibm.com
Subject: Re: [0/3] PATCH Kprobes for x86_64- 2.6.9-final
Message-ID: <20041028234217.GC80511@muc.de>
References: <20041028113208.GA11182@in.ibm.com> <20041028113744.GA82042@muc.de> <20041028155359.GB11182@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028155359.GB11182@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 09:23:59PM +0530, Prasanna S Panchamukhi wrote:
> 
> On Thu, Oct 28, 2004 at 01:37:44PM +0200, Andi Kleen wrote:
> > 
> > Like I still would like to have the page fault notifier
> > completely moved out of the fast path into no_context 
> > (that i386 has it there is also wrong). Adding kprobe_runn 
> > doesn't make a difference.
> 
>     The kprobes fault handler is called if an exception is 
> generated for any instruction within the fault-handler or when 
> Kprobes single-steps the probed instruction.
> AFAIK kprobes does not handle page faults in the above case and just returns
> immediately resuming the normal execution. 

Ok. It's ugly, but ok. Can you remove the bogus kprobes_running()
then please, it's unnecessary?  

With that change it would be ok to merge from my side.

-Andi
