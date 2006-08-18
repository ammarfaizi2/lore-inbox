Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWHRUyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWHRUyP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 16:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWHRUyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 16:54:15 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:57039 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932337AbWHRUyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 16:54:14 -0400
Subject: Re: Serial issue
From: Lee Revell <rlrevell@joe-job.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: markh@compro.net, Paul Fulghum <paulkf@microgate.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060818203410.GJ21101@flint.arm.linux.org.uk>
References: <1155862076.24907.5.camel@mindpipe>
	 <1155915851.3426.4.camel@amdx2.microgate.com>
	 <1155923734.2924.16.camel@mindpipe> <44E602C8.3030805@microgate.com>
	 <1155925024.2924.22.camel@mindpipe>
	 <Pine.LNX.4.61.0608181512520.19876@chaos.analogic.com>
	 <1155928885.2924.40.camel@mindpipe>
	 <Pine.LNX.4.61.0608181551510.19978@chaos.analogic.com>
	 <44E6221D.4040008@compro.net> <1155932916.2924.47.camel@mindpipe>
	 <20060818203410.GJ21101@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 16:54:13 -0400
Message-Id: <1155934453.2924.56.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 21:34 +0100, Russell King wrote:
> On Fri, Aug 18, 2006 at 04:28:36PM -0400, Lee Revell wrote:
> > On Fri, 2006-08-18 at 16:25 -0400, Mark Hounschell wrote:
> > > Take it from someone who actually still uses dumb terminals every day,
> > > any thing over 9600 baud still requires some kind of flow control for
> > > reliable consistent operation. Software (Xon/Xoff) and or hardware
> > > (RTS/RTS/DTE) flow control.
> > > 
> > 
> > Any idea why the serial console does not work at all with flow control
> > enabled (regardless of whether the host runs Linux or another OS)?
> 
> I use serial console with flow control and haven't seen any problems.
> 
> Can you describe your issue with more detail?
> 
> What actions are required to get this "does not work at all" state?
> 
> Are you passing a kernel parameter to enable flow control?
> 
> Are you saying that you get kernel messages if flow control is disabled,
> but if you subsequently enable flow control, and provoke a kernel message,
> you don't see any messages?  When you re-disable flow control, you do?
> 

I believe the flow control problem is due to my cable.

Anyway I don't want to confuse the issue: the problem that I want to
solve (or at least explain) is that while the serial console works with
the host serial port in both interrupt and polled mode, kermit file
transfers only work in polled mode ("setserial /dev/ttyS0 irq 0").

It's not a showstopper, it just seems weird, and I thought it might
indicate a kernel bug.

Lee

