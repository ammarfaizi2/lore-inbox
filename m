Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289366AbSAJKAI>; Thu, 10 Jan 2002 05:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289368AbSAJJ76>; Thu, 10 Jan 2002 04:59:58 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:21266 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S289366AbSAJJ7x>; Thu, 10 Jan 2002 04:59:53 -0500
Date: Thu, 10 Jan 2002 03:59:44 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020110035944.E25474@asooo.flowerfire.com>
In-Reply-To: <20020108173254.B9318@asooo.flowerfire.com> <E16O6KE-00087x-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16O6KE-00087x-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 09, 2002 at 12:10:38AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 12:10:38AM +0000, Alan Cox wrote:
| That is generally not true. Pe-emption is used in user space to prevent
| applications doing very stupid things. Pre-emption in a trusted environment
| can often be most efficient if done by the programs themselves.
| Userspace is not a trusted environment

That's true, but at some point in the future I think the work involved
in making sure all new additional kernel code and all new intra-kernel
interactions are "tuned" becomes larger than going preemptive all the
way down.

Apple had its arguments for cooperative, along the same lines as what
you've mentioned I believe.  And while I agree that the kernel is a much
_more_ trusted environment, I think the possibilities easily remain for
abuse given that there are A) more and more people contributing kernel
code every day, and B) countless unspeakably evil modules out there.

And the preempt tunability that has been mentioned sounds like it would
go a long way.

| Andrew's patches give you 1mS worst case latency for normal situations, that
| is below human perception, and below scheduling granularity. In other words
| without the efficiency loss and the debugging problems you can place the
| far enough latency below other effects that it isnt worth attacking any more.

It sounds like the LL patches are easier and less prone to locking
issues with a lot of the benefit.  But I can't help but feel that it's
not using the right tool for the job.  I think the end result of
stabilizing a preemptive kernel (in 2.5?) is worth the price, IMHO.
-- 
Ken.
brownfld@irridia.com
