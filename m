Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263459AbUJ3DXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbUJ3DXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 23:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUJ3DXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 23:23:04 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:53493 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263459AbUJ3DW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 23:22:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TtXDoTUl6i8Sx7YamXiMmq2akkCZ/ixWRvoheAYmPTRJze419Ip9F902/e18z1+cZAkVZxUGpMrP+Polsn+B9+Yq0H/KZpkMUSJ9aGWdQYzIjlyBJ46NwpZXmb3RrZOO4BWwXjo0FTavzR9Rqxn6ILBIxU1aqU85zqakn/gPpPw=
Message-ID: <d4757e6004102920223105d74d@mail.gmail.com>
Date: Fri, 29 Oct 2004 23:22:56 -0400
From: Joe <joecool1029@gmail.com>
Reply-To: Joe <joecool1029@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Cc: Florian Schmidt <mista.tapas@gmx.net>, Rui Nuno Capela <rncbc@rncbc.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
In-Reply-To: <1099105764.1504.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <5225.195.245.190.94.1098880980.squirrel@195.245.190.94>
	 <33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
	 <20041028063630.GD9781@elte.hu>
	 <20668.195.245.190.93.1098952275.squirrel@195.245.190.93>
	 <20041028085656.GA21535@elte.hu>
	 <26253.195.245.190.93.1098955051.squirrel@195.245.190.93>
	 <20041028093215.GA27694@elte.hu>
	 <43163.195.245.190.94.1098981230.squirrel@195.245.190.94>
	 <20041029163135.1886d67f@mango.fruits.de>
	 <1099105764.1504.4.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 23:09:24 -0400, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2004-10-29 at 16:31 +0200, Florian Schmidt wrote:
> > i tried a V0.5.2 with PREEMPT_REALTIME and all debugging off (config
> > attached). I cannot reproduce your results. I have experienced around 30
> > xruns in 10 minutes. And big ones, too (> 5ms). I don't know exactly what
> > kind of load triggers them. Here's a bit of qjackctl message window (btw:
> > jackd was idle, no clients connected, except for qjackctl):
> >
> 
> I am seeing the same behavior, about 30 xruns in 10 minutes.  It seems
> to be triggered by display activity, among other things.  This cannot be
> a jackd issue, because with an earlier version (T3) I can run for 24
> hours without a single xrun.
> 
> There has to be a bug somewhere in the RT preempt patch.
> 
> Lee

There is, this has been a well-known issue with many versions of
real-time voluntary preemption, which is also a main reason as to why
I avoid it, voluntary preemption performs flawlessly however RT has
been horrendous.  Hopefully the bugs will get smoothed out.
