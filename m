Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268921AbTBZUoN>; Wed, 26 Feb 2003 15:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268924AbTBZUoN>; Wed, 26 Feb 2003 15:44:13 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:49813 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268921AbTBZUoL>;
	Wed, 26 Feb 2003 15:44:11 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15965.10615.231875.609023@gargle.gargle.HOWL>
Date: Wed, 26 Feb 2003 21:54:15 +0100
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "Rhodes, Tom" <tom.rhodes@hp.com>, jbourne@mtroyal.ab.ca,
       linux-kernel@vger.kernel.org
Subject: Re: lockups with 2.4.20 (tg3? net/core/dev.c|deliver_to_old_ones)
In-Reply-To: <20030226145622.C26604@devserv.devel.redhat.com>
References: <DC900CF28D03B745B2859A0E084F044D043506DD@cceexc19.americas.cpqcorp.net>
	<20030226145622.C26604@devserv.devel.redhat.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev writes:
 > > Date: Wed, 26 Feb 2003 09:29:56 -0600
 > > From: "Rhodes, Tom" <tom.rhodes@hp.com>
 > 
 > > > there is a deadlock: deliver_to_old_ones()attempts to stop all timers
 > 
 > > Until this is fixed, there are a couple work-arounds:
 > > - Put the system behind a NAT firewall. [...]
 > > - Switch to a non-NAPI driver. [...]
 > 
 > I think you are a little late with these workarounds, tg3 1.4c
 > is available for a week already.
 >  http://people.redhat.com/jgarzik/tg3/tg3-1.4c/
 > 
 > People using ancient non-NAPI kernels better upgrade to 2.4.20.
 > If they really, really, really cannot upgrade (and this only
 > happens when they are stuck with binary module crap), they
 > should say "I will quit this tob tomorrow" three times,
 > then use RH AS2.1 driver, only make sure to get tg3 1.2e3
 > from drivers/addon/tg3 in 2.4.9-e.12.

Which non-AS RH8.0 kernel should one use to not get hangs from tg3?
I had to downgrade our Dell PE2650 from 2.4.18-24 to 2.4.18-17 since
2.4.18-24 and -19 caused bi-weekly hangs, while -17 and earlier never
had any problems. -18 seemed Ok, but the box didn't run it very long.

This is a compile server with very light network load: a couple of
ssh sessions, NFS-mounted home dirs, ntpd, nothing else.

/Mikael
