Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbTCZKhP>; Wed, 26 Mar 2003 05:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbTCZKhP>; Wed, 26 Mar 2003 05:37:15 -0500
Received: from fionet.com ([217.172.181.68]:9858 "EHLO service")
	by vger.kernel.org with ESMTP id <S261550AbTCZKhN>;
	Wed, 26 Mar 2003 05:37:13 -0500
Subject: Re: System time warping around real time problem - please help
From: Fionn Behrens <fionn@unix-ag.org>
Reply-To: fionn@unix-ag.org
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1048637613.29944.17.camel@irongate.swansea.linux.org.uk>
References: <1048609931.1601.49.camel@rtfm>
	 <Pine.LNX.4.53.0303251152080.29361@chaos> <1048627013.2348.39.camel@rtfm>
	 <3E80D4CC.4000202@mvista.com>  <1048632934.1355.12.camel@rtfm>
	 <1048637613.29944.17.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: United Fools of Bugaloo
Message-Id: <1048675698.4951.17.camel@rtfm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Mar 2003 11:48:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mit, 2003-03-26 at 01:13, Alan Cox wrote:
> On Tue, 2003-03-25 at 22:55, Fionn Behrens wrote:
> > > This all sounds very much like the TSCs are drifting WRT each other. 
> > > Is it possible that you have some power management code (or hardware) 
> > > that is slowing one cpu and not the other?
> > 
> > The only suspect in that case would be the amd76x_pm.o kernel module
> > which I am admittedly using. It saves about 90Watts of power when the
> > machine is idle...
> 
> If you are using amd76x_pm boot with "notsc", ditto for that matter
> on dual athlons with APM or ACPI in some cases.

I booted without amd76x_pm today and the problems are gone. I tried
notsc yesterday and dmesg said TSC had been deactivated on both CPUs. No
libc6 problems - debian is using the i386 version by default.
Oddly enough the system still crashed on those two for (;;) time(); test
loops posted earlier in this thread. So the only (unsatisfying) solution
I see for now is to keep the CPUs glowing hot for the sake of stability.

Any idea what else could cause the crashes in the absence of TSC usage?

As a yet unresolved side note I am still unable to execute the first
test program with my default user (immediately exits with retval 1).
Being run as root or as the system test user, the program runs as
expected (including crash with amd76x_pm). ldd shows no difference. Same
shell being used.

With kind regards,
		F. Behrens
