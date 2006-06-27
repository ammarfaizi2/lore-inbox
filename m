Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWF0McN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWF0McN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWF0McN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:32:13 -0400
Received: from [212.33.187.200] ([212.33.187.200]:44039 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932143AbWF0McM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:32:12 -0400
From: Al Boldi <a1426z@gawab.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Incorrect CPU process accounting using CONFIG_HZ=100
Date: Tue, 27 Jun 2006 15:32:33 +0300
User-Agent: KMail/1.5
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
References: <200606211716.01472.a1426z@gawab.com> <200606222036.39908.a1426z@gawab.com> <20060626160239.GA3257@elf.ucw.cz>
In-Reply-To: <20060626160239.GA3257@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200606271532.33368.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Thu 2006-06-22 20:36:39, Al Boldi wrote:
> > Jan Engelhardt wrote:
> > > >Setting CONFIG_HZ=100 results in incorrect CPU process accounting.
> > > >
> > > >This can be seen running top d.1, that shows top, itself, consuming
> > > > 0ms CPUtime.
> > > >
> > > >Will this bug have consequences for sched.c?
> > >
> > > Works for me, somewhat.
> > > TIME+ says 0:00.02 after 70 secs. (Ergo: top is not expensive on this
> > > CPU.)
> >
> > That's what I thought for a long time.  But at closer inspection, top
> > d.1 slows down other apps by about the same amount of time at 1000Hz and
> > 100Hz, only at 1000Hz it is accounted for whereas at 100Hz it is not.
>
> It is not a bug... it is design decision. If you eat "too little" cpu
> time, you'll be accouted 0 msec. That's what happens at 100Hz...

Bummer!

Meanwhile, can't "too little" cpu time be made relative to CONFIG_HZ?

Thanks!

--
Al


