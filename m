Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262105AbSJDPqI>; Fri, 4 Oct 2002 11:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262106AbSJDPqI>; Fri, 4 Oct 2002 11:46:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27520 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262105AbSJDPqG>; Fri, 4 Oct 2002 11:46:06 -0400
Date: Fri, 4 Oct 2002 11:51:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Meelis Roos <mroos@linux.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre9: floating point in tda7432 module
In-Reply-To: <Pine.GSO.4.44.0210041817000.12474-100000@math.ut.ee>
Message-ID: <Pine.LNX.3.95.1021004114136.1805A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2002, Meelis Roos wrote:

> Most of the unresolved module symbols are now fixed on PPC but one
> brokenmodule remains (with my config):
> 
> depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre9/kernel/drivers/media/video/tda7432.o
> depmod:         __fixdfsi
> depmod:         __floatsidf
> depmod:         __divdf3
> depmod:         __muldf3
> depmod:         __subdf3
> 
> Looks like the tda7432 module tries to use some floating point in the
> kernel... bad.
> 
> -- 

The tda7432 module of linux version 2.4.18 does not use floating point
anywhere and a cursory review of the code shows no place that any
reasonable person should have substituted anything in later versions.

The (CONFIG_VIDEO_BT848) also includes msp3400.c. This source-file
defines a macro that uses floating-point to convert a constant. It's
possible that your gcc is "saving" the conversion to run-time, which
it shouldn't.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

