Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSHIRgO>; Fri, 9 Aug 2002 13:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSHIRgO>; Fri, 9 Aug 2002 13:36:14 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:30481 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315257AbSHIRgN>; Fri, 9 Aug 2002 13:36:13 -0400
Date: Fri, 9 Aug 2002 13:32:37 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Andre Hedrick <andre@linux-ide.org>, Nick Orlov <nick.orlov@mail.ru>,
       B.Zolnierkiewicz@elka.pw.edu.pl,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Part 2: Re: [PATCH] pdc20265 problem.
In-Reply-To: <17337971375@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.3.96.1020809132835.23512B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Petr Vandrovec wrote:
> Maybe you did not notice that Linux can boot of /dev/hde, it does not 
> have to boot from /dev/hda. Just tell to LILO where /dev/hde lives (and 
> there are patches for EDD support, but adding two lines into /etc/lilo.conf 
> is easier than patching support for EDD structure, which is broken in 50% 
> of BIOSes I know anyway).

You can tell LILO anything you want, but the system will "boot off"
whichever drive the BIOS chooses for reading the MBR. In other words,
unless you diddle the BIOS settings, the LILO MBR (1st level boot) must go
on hda, regardless of where the root filesystem lives.

Yes, I know you can install LILO in a partition, but then you have to
trust whatever MBR the BIOS runs to find it.

This was intended as a clarification of the process, I don't think I am
disagreeing with what you said.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

