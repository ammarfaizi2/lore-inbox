Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262603AbTDAPTZ>; Tue, 1 Apr 2003 10:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262606AbTDAPTY>; Tue, 1 Apr 2003 10:19:24 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:33949 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S262603AbTDAPTX>;
	Tue, 1 Apr 2003 10:19:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16009.45219.834358.139761@gargle.gargle.HOWL>
Date: Tue, 1 Apr 2003 17:30:43 +0200
From: mikpe@csd.uu.se
To: Dave Jones <davej@codemonkey.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, simon@mtds.com
Subject: Re: New: SSE2 enabled by default on Celeron (P4 based)
In-Reply-To: <20030401151640.GB28635@suse.de>
References: <17080000.1049207466@[10.10.2.4]>
	<16009.43013.754047.36875@gargle.gargle.HOWL>
	<20030401151640.GB28635@suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:
 > On Tue, Apr 01, 2003 at 04:53:57PM +0200, Mikael Pettersson wrote:
 > 
 >  >  > Steps to reproduce: Compile kernel choosing *any* Celeron option
 >  >  > 
 >  >  > /proc/cpuinfo:-
 >  >  > processor       : 0
 >  >  > vendor_id       : GenuineIntel
 >  >  > cpu family      : 6
 >  >  > model           : 11
 >  > 
 >  > This is NOT a P4-based Celeron. It's a P6 Tualatin Celeron, and as such,
 >  > it does not support SSE2.
 >  > 
 >  > This CPU needs a kernel configured for a Pentium III or less.
 > 
 > The *any* part of the bug report doesn't make much sense.
 > That indicates that we're doing the wrong thing on the Pentium
 > III/Celeron option too.

I checked with 2.5.66. I couldn't find any bug. Plain "Celeron" can't
be chosen -- you have to specify processor generation, and SSE2 is
only set if PENTIUM4 is set. Downgrading from a P4 config to PIII
correctly removes SSE2.

/Mikael
