Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265732AbUF2MHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUF2MHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 08:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbUF2MHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 08:07:43 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:34200 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S265732AbUF2MHi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 08:07:38 -0400
Date: Tue, 29 Jun 2004 14:07:36 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Frederic Krueger <spamalltheway@bigfoot.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: io apic + tsc = slowdown (bugreport + possible fix)
In-Reply-To: <1088467569.1944.10.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.55.0406291358010.31801@jurand.ds.pg.gda.pl>
References: <40DFC853.20803@bigfoot.com> <1088467569.1944.10.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004, john stultz wrote:

> Looking closer at the proposed workaround by Maciej posted here:
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/3174.html
> 
> Why exactly are we using cpu_has_tsc to switch this? I'm not sure I'm
> following how this is TSC dependent. Additionally the comment change
> looks to be from the 2.4 era. 

 One of the two users of timer_ack is do_slow_gettimeoffset().  When the
TSC is selected for use as a high-precision timer do_fast_gettimeoffset()
is used instead.

 Please folks do read the sources sometimes -- I've been repeatedly
clarifying these bits while they are all documented in the sources,
sigh...

  Maciej
