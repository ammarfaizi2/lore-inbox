Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWF3J0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWF3J0b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWF3J0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:26:30 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:26292 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751676AbWF3J0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:26:30 -0400
Date: Fri, 30 Jun 2006 11:26:14 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Hamish <hamish@travellingkiwi.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA hangs...
Message-ID: <20060630112614.51bf0c96@localhost>
In-Reply-To: <200606292253.50409.hamish@travellingkiwi.com>
References: <200606232134.42231.hamish@travellingkiwi.com>
	<20060624100957.73fff572@localhost>
	<200606242330.48248.hamish@travellingkiwi.com>
	<200606292253.50409.hamish@travellingkiwi.com>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

re-added Jeff to CC (since you probably left him out by mistake)

On Thu, 29 Jun 2006 22:53:46 +0100
Hamish <hamish@travellingkiwi.com> wrote:

> On Saturday 24 June 2006 23:30, you wrote:
> > On Saturday 24 June 2006 09:09, you wrote:
> > > On Sat, 24 Jun 2006 09:36:59 +0200
> > >
> > > Paolo Ornati <ornati@fastwebnet.it> wrote:
> > > > > > I'm having problems with a SATA drive on an ASUS A8V deluxe
> > > > > > motherboard under kernel 2.6.17... In fact it's happened under
> > > > > > every (Vanilla) kernel I've ever run on this server (Back to
> > > > > > 2.6.14). (It's just over a year old. It didn't used to experience
> > > > > > the same load as it does now, so I'm currently assuming it's load
> > > > > > related...
> > > >
> > > > I think I've hit something similar yesterday, with 2.6.17.1...
> > >
> > > I was thinking that I've recently enabled CONFIG_PREEMPT (usually I
> > > was just using CONFIG_PREEMPT_VOLUNTARY).
> > >
> > > Maybe is totally unrelated but... for Hamish: what is/was your PREEMPT
> > > config?
> >
> > Hmm...
> >
> > damned stats # gzip -dc /proc/config.gz |grep -i preempt
> > # CONFIG_PREEMPT_NONE is not set
> > # CONFIG_PREEMPT_VOLUNTARY is not set
> > CONFIG_PREEMPT=y
> > CONFIG_PREEMPT_BKL=y
> > CONFIG_DEBUG_PREEMPT=y
> > damned stats #
> >
> > I also tried 2.6.17-mm but that dies in reiserfs claiming a bug in bitmap.c
> >
> > I'll try a re-compile of 2.7.17.1 vanilla with no pre-empt & see how it
> > goes.
> >
> 
> Well, I turned off pre-empt, and haven't struck a problem since in almost a 
> week.
> 
> H


# for Jeff (in case you haven't read the other mails on the list): I've
possibly seen the same problem but I'm not sure.

Disabling preemtion seems to have fixed the problem for hamish, while I
haven't seen it anymore after a "cleanup":
http://lkml.org/lkml/2006/6/28/333


# for Hamish: I suggest to keep running without preemption and maybe to
load the machine on purpose. If it survive for another week then
reenable preemption and see how it goes.

But maybe Jeff has some other suggestions :)

-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64
