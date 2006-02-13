Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWBMUgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWBMUgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWBMUgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:36:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964860AbWBMUgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:36:46 -0500
Date: Mon, 13 Feb 2006 12:35:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: mingo@elte.hu, tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
Message-Id: <20060213123547.41af78c4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0602131649560.30994@scrub.home>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
	<1139830116.2480.464.camel@localhost.localdomain>
	<Pine.LNX.4.61.0602131235180.30994@scrub.home>
	<20060213114612.GA30500@elte.hu>
	<Pine.LNX.4.61.0602131649560.30994@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> Hi,
> 
> On Mon, 13 Feb 2006, Ingo Molnar wrote:
> 
> > your patch makes code larger on gcc3. Please investigate why.
> 
> Ok, I checked with 3.3.6 and 3.4.5 and adding const to ktime_divns/ 
> posix_cpu_nsleep fixes the problem (actually the kernel becomes even 
> smaller because posix_cpu_clock_getres is better off without const), both 
> are complex and noncritical functions.
> Andrew, I'd really prefer to keep the patch and I'll send a patch to add 
> the const where it's actually an improvement.
> 

There's been enough churn here that it'll be counterproductive for me to
continue to munge on your patches.  I'll drop the lot and will await rev
#2.

I don't think any of this was critical for 2.6.16.  If there's something
which you really do think needs to be in 2.6.16 then please carefully
describe the reasons for that, and make sure that the most critical
patches are staged at the head of the series.

