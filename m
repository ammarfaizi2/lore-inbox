Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262980AbUJ1Lmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbUJ1Lmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUJ1LlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:41:05 -0400
Received: from colin2.muc.de ([193.149.48.15]:25361 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262980AbUJ1Lhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:37:48 -0400
Date: 28 Oct 2004 13:37:44 +0200
Date: Thu, 28 Oct 2004 13:37:44 +0200
From: Andi Kleen <ak@muc.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com,
       dprobes@www-124.southbury.usf.ibm.com
Subject: Re: [0/3] PATCH Kprobes for x86_64- 2.6.9-final
Message-ID: <20041028113744.GA82042@muc.de>
References: <20041028113208.GA11182@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028113208.GA11182@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 05:02:08PM +0530, Prasanna S Panchamukhi wrote:
> Hi,
> 
> Below are the Kprobes patches ported to x86_64 architecture.
> I have updated these patches with suggestions from Andi Kleen.
> Thanks Andi for reviewing and providing your feedback.
> These patches can be applied over 2.6.9-final. Please
> see the description in the individual patches.
> 
> Please review and provide your feedback.

The patch is not ready to be applied yet. You didn't address
some issues from the last review.

Like I still would like to have the page fault notifier
completely moved out of the fast path into no_context 
(that i386 has it there is also wrong). Adding kprobe_runn 
doesn't make a difference.

And the jprobe_return_end change is wrong, my suggestion
was to move it into the inline assembler statement. Adding asmlinkage 
doesn't help at all 
(I think i386 gets this wrong too) 

-Andi
