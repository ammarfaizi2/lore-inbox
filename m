Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267336AbUG1X0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267336AbUG1X0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUG1XXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:23:33 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:28420 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267330AbUG1XWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:22:07 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: ncunningham@linuxmail.org
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091054194.8867.26.camel@laptop.cunninghams>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040728142026.79860177.akpm@osdl.org>
	 <1091053822.1844.4.camel@teapot.felipe-alfaro.com>
	 <1091054194.8867.26.camel@laptop.cunninghams>
Content-Type: text/plain
Date: Thu, 29 Jul 2004 01:21:56 +0200
Message-Id: <1091056916.1844.14.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 08:36 +1000, Nigel Cunningham wrote:
> Hi again.
> 
> On Thu, 2004-07-29 at 08:30, Felipe Alfaro Solana wrote:
> > On Wed, 2004-07-28 at 14:20 -0700, Andrew Morton wrote:
> > 
> > > wrt your "Add missing refrigerator support" patch: I'll suck that up, but
> > > be aware that there's a big i2o patch in -mm which basically rips out the
> > > driver which you just fixed up.  Perhaps you can send Markus Lidel
> > > <Markus.Lidel@shadowconnect.com> and I a fix for that version of the driver
> > > sometime?
> > 
> > BTW, the "Add missing refrigerator support" breaks ACPI S3 and S4
> > support for me (2.6.8-rc2-bk7) and my laptop (NEC Chrom@). When
> > resuming, my 3c59x CardBus NIC is not powered up forcing me to eject it,
> > then plug it again.
> 
> Looking again at the patch, I'm not sure which diff would be relevant to
> you. When the card is running, do you have a kIrDAd thread?

kirdad? No... That sounds like Infrared which my laptop does not have.
Here is a digest of ps -axf:

  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:00 init [5]
    2 ?        S<     0:03 [irqd/0]
    3 ?        S<     0:00 [events/0]
    4 ?        S<     0:00  \_ [khelper]
    5 ?        S<     0:00  \_ [kacpid]
   22 ?        S<     0:00  \_ [kblockd/0]
   32 ?        S      0:00  \_ [pdflush]
   33 ?        S      0:00  \_ [pdflush]
   35 ?        S<     0:00  \_ [aio/0]
   36 ?        S<     0:00  \_ [xfslogd/0]
   37 ?        S<     0:00  \_ [xfsdatad/0]
   34 ?        S      0:00 [kswapd0]
   38 ?        S      0:00 [xfsbufd]
  120 ?        S      0:00 [kseriod]
  125 ?        S      0:00 [xfssyncd]
  273 ?        Ss     0:00 minilogd
  286 ?        S      0:00 [xfssyncd]
  287 ?        S      0:00 [xfssyncd]
  567 ?        S      0:00 [khubd]
  871 ?        S      0:00 [pccardd]
  877 ?        S      0:00 [pccardd]

Anything else? :-)

