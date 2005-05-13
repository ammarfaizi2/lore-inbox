Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVEMXAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVEMXAE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVEMW5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:57:49 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:1452 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262611AbVEMW4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:56:36 -0400
Subject: Re: [discuss] Re: [PATCH] adjust x86-64 watchdog tick calculation
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, Alexander Nyberg <alexn@telia.com>,
       Jan Beulich <JBeulich@novell.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050513225127.GB2016@elf.ucw.cz>
References: <s2832159.057@emea1-mh.id2.novell.com>
	 <1115892008.918.7.camel@localhost.localdomain>
	 <20050512142920.GA7079@openzaurus.ucw.cz>
	 <20050513113023.GD15755@wotan.suse.de> <20050513195215.GC3135@elf.ucw.cz>
	 <1116019676.6380.37.camel@mindpipe>  <20050513225127.GB2016@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 13 May 2005 18:56:33 -0400
Message-Id: <1116024993.6380.47.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-14 at 00:51 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > Because it kills machine when interrupt latency gets too high?
> > > > > Like reading battery status using i2c...
> > > > 
> > > > That's a bug in the I2C reader then. Don't shot the messenger for bad news.
> > > 
> > > Disagreed.
> > > 
> > > Linux is not real time OS. Perhaps some real-time constraints "may not
> > > spend > 100msec with interrupts disabled" would be healthy
> >              ^^^^
> > You mean "microseconds", right?  100ms will be perceived by the user as,
> > well, their machine freezing for 100ms...
> 
> I did mean miliseconds. IIRC current watchdog is at one second and it
> still triggers even in cases when operation just takes too long.

I thought there was an understanding that 1 ms would be the target for
desktop responsiveness.  So yes, disabling interrupts for more than 1ms
is considered a bug.

Why do you need to disable interrupts for 100ms to read the battery
status exactly?

Lee

