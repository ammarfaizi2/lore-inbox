Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbULNUIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbULNUIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 15:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbULNUII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 15:08:08 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:49082 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S261587AbULNUIE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 15:08:04 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <20041214132834.GA32390@elte.hu>
References: <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
	 <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu>  <20041214132834.GA32390@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1103054849.12653.102.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Dec 2004 12:07:30 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 05:28, Ingo Molnar wrote:
> i have released the -V0.7.33-0 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> this is mainly a port from -rc2-mm3 to -rc3-mm1. Changes:
> 
> - due to 2.6.10 release work the -mm kernel now is in fixes-mostly mode,
>   but there's one interesting new feature: -rc3-mm1 introduced the
>   ->unlocked_ioctl method which is now an official way to do BKL-less
>   ioctls. I changed the ALSA ->ioctl_bkl changes in -RT to use this
>   facility. The ALSA/sound guys might be interested in these bits. Thus
>   another chunk of -RT could go upstream.

If I build a cvs version of alsa without those patches, will it work on
top of the 0.7.33 kernel? Or do I have to try to isolate the patches and
apply them to current alsa cvs?

-- Fernando


