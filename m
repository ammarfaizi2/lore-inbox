Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbTLHRHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265471AbTLHRHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:07:18 -0500
Received: from aun.it.uu.se ([130.238.12.36]:49073 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265468AbTLHRHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:07:15 -0500
Date: Mon, 8 Dec 2003 18:07:11 +0100 (MET)
Message-Id: <200312081707.hB8H7B85014403@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, nemesis-lists@icequake.net
Subject: Re: APIC support on Slot-A Athlon, K6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003 05:58:59 -0600, Ryan Underwood wrote:
>> Furthermore, I/O-APIC usage requires (in hardware) that the
>> processor has a local APIC.
>
>What can the APIC support alone accomplish, without an I/O-APIC?
>Just NMI watchdog and related things? (looking at CONFIG_APIC help)
>Looks like I/O-APIC is the real desired feature, but a functioning local
>APIC, though not very useful by itself, is a prerequisite for it.

Local APIC gives you:
- using the local APIC timer instead of the mobo's legacy timer
- thermal management interrupts on P4s (dunno about K7s/K8s)
- performance counter interrupts, which can be used as an NMI
  source (watchdog, profiling) or for performance analysis

I/O-APIC gives you:
- more interrupt vectors ==> less IRQ sharing ==> improved
  stability and performance
- lower-overhead interrupt management
- I/O-APIC NMI watchdog (another timer with NMI delivery mode)
