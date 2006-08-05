Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422769AbWHEJIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbWHEJIz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 05:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422772AbWHEJIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 05:08:55 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:63420 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422769AbWHEJIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 05:08:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Suspend on Dell D420
Date: Sat, 5 Aug 2006 11:08:00 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060804162300.GA26148@uio.no> <200608050126.57060.rjw@sisk.pl> <20060805082321.GB27129@uio.no>
In-Reply-To: <20060805082321.GB27129@uio.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608051108.01180.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 August 2006 10:23, Steinar H. Gunderson wrote:
> On Sat, Aug 05, 2006 at 01:26:56AM +0200, Rafael J. Wysocki wrote:
> > Because the non-boot CPUs are taken off early, before anything else, and the
> > system is effectively non-SMP during the entire suspend-resume cycle
> > (well, almost).  If SMP-related things go wrong during the suspend, CPU
> > hotplug is the first suspect. ;-)
> 
> Well, it seems to work fine during the suspend phase, at least, and it also
> seems to work well during normal use:
> 
> fugl:~# echo 0 > /sys/devices/system/cpu/cpu1/online 
> fugl:~# echo 1 > /sys/devices/system/cpu/cpu1/online 
> 
> FWIW, there is an error in dmesg afterwards, though:
> 
> ===
> CPU 1 is now offline
> SMP alternatives: switching to UP code
> SMP alternatives: switching to SMP code
> Booting processor 1/1 eip 3000
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 2394.85 BogoMIPS (lpj=4789709)
> CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
> CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
> monitor/mwait feature present.
> CPU: L1 I cache: 32K, L1 D cache: 32K
> CPU: L2 cache: 2048K
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 1
> CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#1.
> CPU1: Intel Genuine Intel(R) CPU           U2500  @ 1.20GHz stepping 08
> APIC error on CPU1: 00(40)
> ===
> 
> No idea whether it's related. FWIW, resume didn't work with maxcpus=1 on boot
> either, so I'm not really sure how related it is.

Hm, could you please try it with a non-SMP kernel?

Rafael
