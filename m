Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWGQO7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWGQO7S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWGQO7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:59:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:47692 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750818AbWGQO7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:59:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=up/NUmPS8H5R5ThRh9n24FNS9v2LQkLC/a5D621M92dBIvka6I5VE2E9sYj6mCjvi1Rap0L9bej34WBExVrFqClt/ubv7tUnbTWfnGZUCDV6OrXGIicGWe6/RXWCgfYj7pyjgI17u89WaS1WQPkMci4lkWeMQEhlpQ7nsVTnw0Y=
Message-ID: <f96157c40607170759p1ab37abdi88d178c3503fb2e1@mail.gmail.com>
Date: Mon, 17 Jul 2006 14:59:15 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Re: i686 hang on boot in userspace
In-Reply-To: <Pine.LNX.4.64.0607171605500.6761@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060714150418.120680@gmx.net>
	 <Pine.LNX.4.64.0607171242440.6761@scrub.home>
	 <20060717133809.150390@gmx.net>
	 <Pine.LNX.4.64.0607171605500.6761@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/06, Roman Zippel <zippel@linux-m68k.org> wrote:
> Hi,
>
> On Mon, 17 Jul 2006, Uwe Bugla wrote:
>
> > I have compared 18-rc1-mm1 and 18-rc1-mm2.
> > mm2 contains a patch for timer.c owning almost twice as many hunks than mm1.
> > In so far I was sure it was a timer.c issue.
>
> You're still guessing, a lot more things changed between 18-rc1-mm1 and
> 18-rc1-mm2. It's rather unlikely that the timer changes fixed your
> problem. You might want to try to revert
> ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/broken-out/improve-timekeeping-resume-robustness.patch
> to see whether the problem is back afterwards.

I was preparing a post to lkml about a similar hang which happens
during init. I also saw an error while ntpdate tried to set the
time/get the time. this only happens after I've enabled the NX bit on
the dual 32bit Xeons installed in the HP Proliant Server. it works
flawlessly with 2.6.17.6 (CONFIG_X86_PAE and CONFIG_HIGHMEM_64) but
since 2.6.18-rc2-git4 (including 2.6.18-rc2) it hangs late in the init
process.

could this be related?
