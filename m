Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbULTCqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbULTCqS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 21:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbULTCqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 21:46:18 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:25673 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261398AbULTCqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 21:46:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aLpyOkPZKR/gqescMayN0+ir9mqwNTN6G1fAuLB/TsBOpVbT0ETAIkNGAzOmdWxJlBe+jNwbV10O6elETNg3lNhVweqo6oJBpu2nbhhmiFckummNMyQhufCTwLCPHyo+iwTnFDeVv87Ol3w+b6wAKgkDYj2aPpXyjRq0hUN1uxo=
Message-ID: <d4757e60041219184662648df@mail.gmail.com>
Date: Sun, 19 Dec 2004 21:46:15 -0500
From: Joe <joecool1029@gmail.com>
Reply-To: Joe <joecool1029@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.10-rc3-mm1-V0.7.33-03 and NVidia wierdness, with workaround...
Cc: Valdis.Kletnieks@vt.edu, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1103473203.4143.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412161626.iBGGQ5CI020770@turing-police.cc.vt.edu>
	 <1103300362.12664.53.camel@localhost.localdomain>
	 <1103303011.12664.58.camel@localhost.localdomain>
	 <200412171810.iBHIAQP3026387@turing-police.cc.vt.edu>
	 <1103313861.12664.71.camel@localhost.localdomain>
	 <1103320354.3538.11.camel@localhost.localdomain>
	 <200412172242.iBHMgVav003005@turing-police.cc.vt.edu>
	 <1103473203.4143.9.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Dec 2004 11:20:03 -0500, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 2004-12-17 at 17:42 -0500, Valdis.Kletnieks@vt.edu wrote:
> 
> > Most likely, the fact you have SMP/HT and I'm just on a PREEMPT-UP kernel is
> > what's making the difference.  There's almost certainly a '#ifdef CONFIG_SMP'
> > involved here somehow....
> 
> Yep! I just compiled my system without SMP and I was able to start up X
> with NVidia on my HT laptop (with V0.7.33-04).
> 
> Ingo, do you think this is a bug with NVidia (bad proprietary module) or
> might be with something in the RT SMP side? I'll look a little more on
> Monday, but if you know of something, let me know.  I'm curious to why
> it works fine without RT but will not work with RT (and SMP). I
> shouldn't say NVidia bug, since it only is a problem with the RT SMP, so
> I should say incompatibility w.r.t. RT SMP and NVidia.
> 
> If you are one of those that don't want anything to do with the NVidia
> driver, and don't care less if it works or not, let me know that too.
> That way I won't bother you with this anymore and will only communicate
> with Valdis :-)
> 
> Thanks,
> 
> -- Steve

Nope, I've experianced the same problem without SMP.  It also appears
to be a bug where if make menuconfig is not run after using an old
kernel, for some odd reason CONFIG_SPINLOCK_BKL is set to be on. 
Anyways, I just wanted to reassure you, this is NOT an SMP bug.
