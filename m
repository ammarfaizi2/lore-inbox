Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265003AbRGIOZ1>; Mon, 9 Jul 2001 10:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267037AbRGIOZR>; Mon, 9 Jul 2001 10:25:17 -0400
Received: from muedi6-212-144-153-063.arcor-ip.net ([212.144.153.63]:20465
	"EHLO merv") by vger.kernel.org with ESMTP id <S265003AbRGIOY5>;
	Mon, 9 Jul 2001 10:24:57 -0400
Date: Mon, 9 Jul 2001 16:24:51 +0200
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: >128 MB RAM stability problems (again)
Message-ID: <20010709162451.A2187@bombe.modem.informatik.tu-muenchen.de>
Reply-To: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Mail-Followup-To: Ronald Bultje <rbultje@ronald.bitfreak.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <994442162.1047.0.camel@tux>
User-Agent: Mutt/1.3.18i
From: Andreas Bombe <andreas@bombe.modem.informatik.tu-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2001 at 07:55:50PM +0200, Ronald Bultje wrote:
> So, basically, my bios must have loaded the wrong options for my memory
> which must run above it's limits which causes data corruption... Then,
> my stupid question, why doesn't memtest86 detect that?

Because it's a memory tester and not real work load.  It tries special
access patterns to find hard memory errors (i.e. memory cells that are
damaged).  Timing and configuration errors are harder to find.  For one
thing, these might depend on temperature, and memtest86 won't stress the
CPU into generating as much heat as real work will do.

> Anyway, I'll go look at the bios settings of the computers, look at the
> CAS/RAS/clock timing settings like two people suggested (thanks :-) )
> and hope to be happy and have a stable machine after that.

According to your posts, you are using no-name SDRAMs, and two different
ones.  I have already posted that, their configuration data is often
incomplete or just erronous and the BIOS will be confused or has just
errors itself (like configuring all SDRAMs to the values of the first
one).

The German computer magazine c't has some time ago bought no-name
and branded SDRAMs and tested them extensively (checked config ROM data,
put them in a lended $500000 memory tester).  Results were that no-names
were on average pretty crappy.  The branded ones weren't perfect, but
much better.  A month after that article pretty much every computer
store here had brand SDRAMs in addition to the cheap no-name stuff.

If you can get hold of the timing values for your RAM (might be hard
with no-name, use conservative values otherwise) then it's better to set
these directly instead of letting the BIOS go around playing with that
stuff.

>From what I've read, some manufacturers even simply gave up on
autodetection, left it out of the BIOS and require the user to configure
it themselves if they want some performance.

-- 
Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
