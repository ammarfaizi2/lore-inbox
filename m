Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbULQRFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbULQRFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 12:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbULQRFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 12:05:52 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:25751 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262078AbULQRDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 12:03:48 -0500
Subject: Re: 2.6.10-rc3-mm1-V0.7.33-03 and NVidia wierdness, with
	workaround...
From: Steven Rostedt <rostedt@goodmis.org>
To: Valdis.Kletnieks@vt.edu
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1103300362.12664.53.camel@localhost.localdomain>
References: <200412161626.iBGGQ5CI020770@turing-police.cc.vt.edu>
	 <1103300362.12664.53.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 17 Dec 2004 12:03:31 -0500
Message-Id: <1103303011.12664.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-17 at 11:19 -0500, Steven Rostedt wrote:
> On Thu, 2004-12-16 at 11:26 -0500, Valdis.Kletnieks@vt.edu wrote:
> > (Yes, I know NVidia is evil and all that.. If you're not Ingo or NVidia,
> > consider this "documenting the workaround" ;)
> > 
> > For reasons I can't explain, the NVidia module won't initialize
> > correctly with V0-0.7.33-03 if built with CONFIG_SPINLOCK_BKL.  It however
> > works fine with CONFIG_PREEMPT_BKL, changing nothing else in the config.
> > It also works fine with 2.6.10-rc3-mm1 without Ingo's patch.
> 
> You were able to get the NVidia driver to work? Most of my machines have
> the NVidia card (yes evil, but I like them) and I haven't been able to
> get them to work on the rc3-mm1 (and a few earlier). Grant you, I didn't
> try hard, but I did try a little on V0.7.33-0, and gave up later. 
> 

Update: I just tried some of my fixes to the rc3-mm1 kernel, and that
worked without a problem.  But I still didn't get by the sleep problem
in Ingo's RT patch.  Did you get further, and did you make fixes to both
the nvidia module as well as the kernel?


> How did you get by the...
> 
> 1) pgd_offset_k_is_obsolete (not too hard, just a few patches for me)
> 2) class_simple_create and friends going to GPL (I just removed the GPL
> from my code)
> 3) for Ingo's patches only, the might_sleep in the os_interface section.
> having interrupts turned off. (here's where mine failed, I tried saving
> and restoring them, turning them on that is, backwards from the normal
> local_irq_save, and it would just be unstable here).
> 
> Do you have it working for the 2.6.10-rc3-mm1 without Ingo's patches?
> 
> Thanks,
> 
> -- Steve
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

