Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVAWJ11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVAWJ11 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 04:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVAWJ11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 04:27:27 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:64427 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261254AbVAWJ1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 04:27:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DbWPaFtTWi6D80alf/Gl1vvHNo9DLHzFz7hnQ1+y7vfPilheuymIp+r6LyfJuga1KX1Sfe0THnJ5t0Plq+VPmoJpu770YtayB0JkMCHLUDK+aOTAdRCtxBX7NYwSeFVxeHM3Py5cErSd2aJFfdidzxwNfdPDBfFni1xiVSCxzag=
Message-ID: <aad1205e05012301271de3e365@mail.gmail.com>
Date: Sun, 23 Jan 2005 17:27:21 +0800
From: andyliu <liudeyan@gmail.com>
Reply-To: andyliu <liudeyan@gmail.com>
To: mingo@elte.hu
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-00
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200501221622.24273.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041122005411.GA19363@elte.hu> <20050115133454.GA8748@elte.hu>
	 <20050122122915.GA7098@elte.hu>
	 <200501221622.24273.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi , ingo

i am trying to understand your patch,but the patch file is so long and complex.
i am wondering is there some documents about your patch?

:)

thanks very much for your patch and your work.


On Sat, 22 Jan 2005 16:22:24 -0500, Gene Heskett
<gene.heskett@verizon.net> wrote:
> On Saturday 22 January 2005 07:29, Ingo Molnar wrote:
> >i have released the -V0.7.36-00 Real-Time Preemption patch, which
> > can be downloaded from the usual place:
> >
> >  http://redhat.com/~mingo/realtime-preempt/
> >
> >this is mainly a merge to 2.6.11-rc2.
> 
> Humm, by the time I went after the patch it was up to -02.
> 
> And I'm getting a couple of error exits:
> -------------------
> net/sched/sch_generic.c: In function `qdisc_restart':
> net/sched/sch_generic.c:128: error: label `requeue' used but not
> defined
>   CC      drivers/pci/setup-bus.o
> make[2]: *** [net/sched/sch_generic.o] Error 1
> make[1]: *** [net/sched] Error 2
> make[1]: *** Waiting for unfinished jobs....
> -------------------
> 
> And
> -------------------
>   LD      net/sunrpc/built-in.o
> make: *** [net] Error 2
> make: *** Waiting for unfinished jobs....
> -------------------
> So obviously I'm not running it. :-)
> 
> One other item I don't think is related, in the last version (35-01) I
> had svn'd a new ieee1396 sub-directory from that ieee1394.org site
> into the drivers tree, and since it was less than a week old and
> worked right well, I just copied it over into the new kernel tree &
> reran the configs after renameing the existing ieee1394 to
> ieee1394-orig.
> 
> >There was alot of merging to be done due to Thomas Gleixner's
> >spinlock/rwlock cleanups making it into upstream and due to the
> > upstream spinlock changes, and there were some networking related
> > conflicts as well, so these areas might introduce new regressions.
> >
> >the patch includes a fix that should resolve the microcode-update
> >related boot-time crash reported by K.R. Foley. It also includes a
> >verify_mm_writelocked() fix from Daniel Walker.
> >
> >to create a -V0.7.36-00 tree from scratch, the patching order is:
> >
> >  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2
> >
> > http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.11-rc2.bz
> >2
> > http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.11-r
> >c2-V0.7.36-00
> >
> > Ingo
> 
> --
> Cheers, Gene
> "There are four boxes to be used in defense of liberty:
>  soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author)
> 99.32% setiathome rank, not too shabby for a WV hillbilly
> Yahoo.com attorneys please note, additions to this message
> by Gene Heskett are:
> Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Yours andyliu
