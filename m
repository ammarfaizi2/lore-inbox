Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbTIAMYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 08:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbTIAMYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 08:24:14 -0400
Received: from sun3.sammy.net ([68.162.198.6]:43791 "HELO sun3.sammy.net")
	by vger.kernel.org with SMTP id S262849AbTIAMYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 08:24:09 -0400
Date: Mon, 1 Sep 2003 08:23:59 -0400 (EDT)
From: Sam Creasey <sammy@sammy.net>
X-X-Sender: sammy@sun3
To: Jamie Lokier <jamie@shareable.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <20030901104836.GA2202@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.40.0309010814250.19846-100000@sun3>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Sep 2003, Jamie Lokier wrote:

> Sam Creasey wrote:
>
> > bash-2.03# time ./jamie-test2
> > (2048) [10000,10000,0] Test separation: 8192 bytes: pass
>
> Mighty suspicious gettimeofday() you have there.
>
> > real    1m34.330s
> > user    1m30.030s
> > sys     0m4.070s
>
> Indeed, on other systems the test completes in a few seconds at most,
> not because of CPU speed, but because gettimeofday() returns high
> resolution time on them.
>
> Isn't there a way to read high resolution time on the 68020 Sun-3?

AFAICT, no.  I've dug through the datasheets for the intersil RTC used, as
well as the NetBSD code, and SunOS headers, and it seems that we're stuck
with 1/100th second accuracy.  Bummer.

-- Sam

