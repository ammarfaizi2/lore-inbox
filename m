Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271388AbRHWJpo>; Thu, 23 Aug 2001 05:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271796AbRHWJpe>; Thu, 23 Aug 2001 05:45:34 -0400
Received: from xilofon.it.uc3m.es ([163.117.139.114]:6272 "EHLO
	xilofon.it.uc3m.es") by vger.kernel.org with ESMTP
	id <S271388AbRHWJpX>; Thu, 23 Aug 2001 05:45:23 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108230945.LAA01478@xilofon.it.uc3m.es>
Subject: Re: Shutdown and power off on a multi-processor machine
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <Pine.GSO.4.30.0108230927440.20823-100000@balu> "from Pozsar Balazs
 at Aug 23, 2001 09:29:40 am"
To: Pozsar Balazs <pozsy@sch.bme.hu>
Date: Thu, 23 Aug 2001 11:45:13 +0200 (CEST)
CC: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Pozsar Balazs wrote:"
> 
> I had the same problems, and the only way i could have a poweroff at
> shutdown was to pass the apm=power-off option to the kernel at boot time.
> (e.g. in lilo.conf, have a append="apm=power-off" line.)

I'm also having problems on all my smp machines. I can't reboot reliably from a shutdown,
not even using the software watchdog daemon to help (killall -STOP watchdog), not even
from "reboot", nor from magic-sysreq (though that seems most reliable to me - maybe 80%).
I am currently using apm=power-off on 2.4.6 with about a 50% success rate overall.

When things go badly, it just sits there at the "rebooting" stage, and needs
the red button to be pressed.

The machine that most annoys me in this regard is the dell poweredge at which I am
sitting ... it's been a long time since I booted 2.2 on it, but I think things
went better.

The bios has no options vis-a-vis apm, etc.

I have been running all kernels 2.4.0 to 2.4.8. I think 2.4.8 may be a bit better,
but it needs time to get a feel for the stats.


> On Wed, 22 Aug 2001, Jordan Breeding wrote:
> 
> > I too am having trouble powering off and rebooting an SMP machine.  It
> > is a Tyan Tiger 230.  I have tried to report this a few times with
> > little to no response.  The last kernel that worked for me in this
> > respect was 2.4.6-ac2.  I have tried linus' and alan's kernels both with
> > no success.  I have tried configuring all kernel with APM soft-power
> > off, real-mode power off (I enable power-off even though the rest of APM
> > is broken on SMP), ACPI (multiple setups), and nothing at all.  None of
> > these kernel/configuration combos allow me to shutdown or reboot my

> > Shawn McGovern wrote:
> > >
> > > I have a need for a headless machine to power off at the end of shutdown,
> > > but cannot get it to work for smp kernels. I tried 2.2.14, and 2.4.9,
> > > built with smp and apm. If there is a way to make this work, I would


Peter
