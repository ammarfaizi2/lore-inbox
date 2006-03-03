Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWCCVQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWCCVQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWCCVQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:16:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3985 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750732AbWCCVQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:16:56 -0500
Date: Fri, 3 Mar 2006 13:15:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: zippel@linux-m68k.org, anemo@mba.ocn.ne.jp, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org, ak@muc.de
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
Message-Id: <20060303131514.39e01dcb.akpm@osdl.org>
In-Reply-To: <1141417048.9727.60.camel@cog.beaverton.ibm.com>
References: <20060302.230227.25910097.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64.0603021108220.5829@schroedinger.engr.sgi.com>
	<20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
	<20060302190408.1e754f12.akpm@osdl.org>
	<1141417048.9727.60.camel@cog.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> But again, you're concerns are valid, there appears to be a lack of
>  enthusiasm in the community both for and against the changes. And I
>  understand, as I've got lots of other things I need to do as well, and
>  reviewing a large change like this can take some time that I'm sure
>  folks are short on.
> 
>  Maybe I should work on selling it more, I just have been at it for so
>  long with this patch set that I feel I'm boring folks with the constant
>  and repetitive "provides robust behavior in the face of lost ticks and
>  enables other development like high-res timers and realtime" schtick.
>

I'm not particularly worried from the will-it-break-the-kernel POV.  Any
remaining problems will affect a relatively small number of machines and
once the proverbial million monkeys start running it, things will be shaken
out of the current x86 implementation.

So we can do this, but the question is do we _want_ to do it?  If the arch
maintainers can look at it from a high level and say "yup, I can use that
and it'll improve/simplify/speedup/reduce my code" then yes, it's worth
making the effort.

It's a hard one.
