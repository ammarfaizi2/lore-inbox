Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265441AbTFZHHr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 03:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265446AbTFZHHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 03:07:47 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:27804 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S265441AbTFZHHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 03:07:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16122.40719.122816.392066@gargle.gargle.HOWL>
Date: Thu, 26 Jun 2003 09:21:51 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Ed L Cashin <ecashin@uga.edu>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: compile error in drivers/perfctr/x86.c (Re: 2..5.73-osdl2)
In-Reply-To: <20030625224707.A15559@atlas.cs.uga.edu>
References: <20030625174048.221471a0.shemminger@osdl.org>
	<20030625224707.A15559@atlas.cs.uga.edu>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed L Cashin writes:
 > On Wed, Jun 25, 2003 at 05:40:48PM -0700, Stephen Hemminger wrote:
 > > http://developer.osdl.org/shemminger/patches/patch-2.5.73-osdl2.bz2
 > 
 > Hi.  I'm getting a compile error:
 > 
 >   CC      drivers/perfctr/x86_setup.o
 >   CC      drivers/perfctr/x86.o
 > drivers/perfctr/x86.c: In function `unregister_nmi_pmdev':
 > drivers/perfctr/x86.c:1484: `nmi_pmdev' undeclared (first use in this function)
 > drivers/perfctr/x86.c:1484: (Each undeclared identifier is reported only once
 > drivers/perfctr/x86.c:1484: for each function it appears in.)
 > drivers/perfctr/x86.c:1485: warning: implicit declaration of function `apic_pm_unregister'
 > drivers/perfctr/x86.c: In function `x86_pm_init':
 > drivers/perfctr/x86.c:1500: warning: implicit declaration of function `apic_pm_register'
 > drivers/perfctr/x86.c:1500: warning: assignment makes pointer from integer without a cast
 > make[2]: *** [drivers/perfctr/x86.o] Error 1
 > make[1]: *** [drivers/perfctr] Error 2
 > make: *** [drivers] Error 2

It looks a lot like OSDL includes an old obsolete version of perfctr.
The PM code you're getting errors in is for kernels older than 2.5.68.
The current release of perfctr knows that current 2.5 kernels use the
driver model for local APIC and NMI watchdog power management.

Unfortunately, the -osdl kernel announcements don't state _which_ release
of perfctr they're including. I was assuming they got new releases off
the download site on a regular basis, but perhaps they don't.

/Mikael
