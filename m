Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264037AbTE0SJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbTE0SI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:08:27 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:31753 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S264016AbTE0SGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:06:43 -0400
Date: Tue, 27 May 2003 20:19:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: John Stoffel <stoffel@lucent.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70 compile error
In-Reply-To: <16083.35048.737099.575241@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0305272010550.12110-100000@serv>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
 <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com>
 <200305271729.49047.devilkin-lkml@blindguardian.org> <20030527153619.GJ8978@holomorphy.com>
 <16083.35048.737099.575241@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 May 2003, John Stoffel wrote:

>   *
>   * Processor type and features
>   *
>   Subarchitecture Type (PC-compatible, Voyager (NCR), NUMAQ (IBM/Sequent), Summit/EXA (IBM x440), Support for other sub-arch SMP systems with more than 8 CPUs, SGI 320/540 (Visual Workstation), Generic architecture (Summit, bigsmp, default)) [PC-compatible] (NEW) 
> 
> 
> What the hell am I supposed to enter here?  This is just friggin ugly
> and un-readable.  It should be cleaned up.

I agree and I already fixed this here, so with the next update this will 
look like this:

Subarchitecture Type
> 1. PC-compatible (X86_PC)
  2. Voyager (NCR) (X86_VOYAGER)
  3. NUMAQ (IBM/Sequent) (X86_NUMAQ)
  4. Summit/EXA (IBM x440) (X86_SUMMIT)
  5. Support for other sub-arch SMP systems with more than 8 CPUs (X86_BIGSMP)
  6. SGI 320/540 (Visual Workstation) (X86_VISWS)
  7. Generic architecture (Summit, bigsmp, default) (X86_GENERICARCH) (NEW)
choice[1-7]: 

This has other advantages too, one can see now which options were newly 
added and the individual help texts are accessible.

bye, Roman

