Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbTJ2WxH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 17:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTJ2WxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 17:53:07 -0500
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:23424 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261943AbTJ2WxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 17:53:04 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16288.17470.778408.883304@wombat.chubb.wattle.id.au>
Date: Thu, 30 Oct 2003 09:50:38 +1100
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Gabriel Paubert <paubert@iram.es>, john stultz <johnstul@us.ibm.com>,
       Joe Korty <joe.korty@ccur.com>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: gettimeofday resolution seriously degraded in test9
In-Reply-To: <20031029113850.047282c4.shemminger@osdl.org>
References: <20031027234447.GA7417@rudolph.ccur.com>
	<1067300966.1118.378.camel@cog.beaverton.ibm.com>
	<20031027171738.1f962565.shemminger@osdl.org>
	<20031028115558.GA20482@iram.es>
	<20031028102120.01987aa4.shemminger@osdl.org>
	<20031029100745.GA6674@iram.es>
	<20031029113850.047282c4.shemminger@osdl.org>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Stephen" == Stephen Hemminger <shemminger@osdl.org> writes:

Stephen> On Wed, 29 Oct 2003 11:07:45 +0100 Gabriel Paubert
Stephen> <paubert@iram.es> wrote:
>> for example.

Stephen> The suggestion of using time interpolation (like ia64) would
Stephen> make the discontinuities smaller, but still relying on fine
Stephen> grain gettimeofday for controlling servo loops with NTP
Stephen> running seems risky. Perhaps what you want to use is the
Stephen> monotonic_clock which gives better resolution (nanoseconds)
Stephen> and doesn't get hit by NTP.

monotonic_clock:
	-- isn't implemented for most architectures
	-- even for X86 only works for some timing sources
	-- and for the most common case is variable rate because of
	   power management functions changing the TSC clock rate.

As far as I know, there isn't a constant-rate monotonic clock
available at present for all architectures in the linux kernel.  The
nearest thing is scheduler_clock().

Peter C
