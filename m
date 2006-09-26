Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWIZWCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWIZWCy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWIZWCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:02:54 -0400
Received: from mailout1-1.pacific.net.au ([61.8.2.208]:35775 "EHLO
	mailout1.pacific.net.au") by vger.kernel.org with ESMTP
	id S932290AbWIZWCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:02:53 -0400
Date: Wed, 27 Sep 2006 08:02:45 +1000
From: Greg Schafer <gschafer@zip.com.au>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       James Puthukattukaran <James.Puthukattukaran@Sun.COM>,
       Michael Obster <lkm@obster.org>,
       =?iso-8859-1?B?Uy7HYT8/bGFy?= Onur <caglar@pardus.org.tr>
Subject: Re: 2.6.18 Nasty Lockup
Message-ID: <20060926220245.GA7883@tigers.local>
References: <20060926123640.GA7826@tigers.local> <1159301752.17071.0.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <1159301752.17071.0.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 26, 2006 at 01:15:51PM -0700, john stultz wrote:
> On Tue, 2006-09-26 at 22:36 +1000, Greg Schafer wrote:
> > This is a _hard_ lockup. No oops, no magic sysrq, no nuthin, just a
> > completely dead machine with only option the reset button. Usually happens
> > within a couple of minutes of desktop use but is 100% reproducible. Problem
> > is still there in a fresh checkout of current Linus git tree (post 2.6.18).
> > 
> > Dual Athlon-MP 2200's on a Tyan S2466 Tiger MPX. Config attached.
> > 
> > I used git-bisect and arrived at the apparent culprit below. Anything else I
> > should do to gather more info?
> 
> Quick test: Does enabling CONFIG_ACPI change the behavior?

Yes. It doesn't lockup now, at least it hasn't yet. Should I always
configure with CONFIG_ACPI? I've usually avoided it.


On Tue, Sep 26, 2006 at 11:18:02AM -0700, john stultz wrote:
> Thanks for narrowing this down. Could you send me full dmesg output?

Sure, attached (non CONFIG_ACPI case).


On Tue, Sep 26, 2006 at 01:20:54PM -0400, James Puthukattukaran wrote:
> Did you try asserting an NMI via "nmi_watchdog" kernel boot argument?

I gave it a try on your advice (added nmi_watchdog=1 to boot args). No dice
I'm afraid (no oops data). But I did notice in the dmesg output something
possibly strange:

Testing NMI watchdog ... CPU#0: NMI appears to be stuck (0->0)!


On Tue, Sep 26, 2006 at 03:56:46PM +0200, Michael Obster wrote:
> what do you mean with desktop use? X11-System? Then please add also your
> used grafic card and the X11 driver. I see this behaviour with lots of
> binary only driver like from NVIDIA or ATI (perhaps they have problems
> with the new 2.6.18 kernel).

No binary-only drivers here. Matrox card. In fact, the lockup sometimes
happens before X is even loaded (I suspect ntpdate in my bootscripts).


Regards
Greg

--cWoXeonUoKmBZSoM
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="dmesg.out.gz"
Content-Transfer-Encoding: base64

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
ClKvg7X/AkGCxTdCIQAA

--cWoXeonUoKmBZSoM--
