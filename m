Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWCNVqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWCNVqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWCNVp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:45:59 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:1433 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751337AbWCNVp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:45:59 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: does swsusp suck after resume for you? [was Re: Faster resuming of suspend technology.]
Date: Wed, 15 Mar 2006 08:45:14 +1100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       ck@vds.kolivas.org, Jun OKAJIMA <okajima@digitalinfra.co.jp>,
       linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603132303.18758.kernel@kolivas.org> <200603141906.49183.rjw@sisk.pl>
In-Reply-To: <200603141906.49183.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603150845.15153.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 March 2006 05:06, Rafael J. Wysocki wrote:
> On Monday 13 March 2006 13:03, Con Kolivas wrote:
> > @@ -269,5 +270,6 @@ int swsusp_resume(void)
> >  	touch_softlockup_watchdog();
> >  	device_power_up();
> >  	local_irq_enable();
> > +	post_resume_swap_prefetch();
> >  	return error;
> >  }
>
> Hm, this code is only executed if there's an error during resume.  You
> should have placed the post_resume_swap_prefetch() call in
> swsusp_suspend(). :-)

Gee you guys are fussy. You want the code to actually do what it's advertised 
to do?

Anyway perhaps it was ordinary swap prefetch that was making the difference 
after all. I think I'll let the current swap prefetch code settle for a while 
before touching this just yet.

Cheers,
Con
