Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314213AbSDRBWC>; Wed, 17 Apr 2002 21:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314214AbSDRBWB>; Wed, 17 Apr 2002 21:22:01 -0400
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:18702 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S314213AbSDRBWB>; Wed, 17 Apr 2002 21:22:01 -0400
Date: Wed, 17 Apr 2002 19:21:55 -0600 (MDT)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: RE: Hyperthreading
In-Reply-To: <1844830000.1019083728@flay>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
        "'Robert Love'" <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.44.0204171856420.28706-100000@skuld.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Martin J. Bligh wrote:

> > I've seen some Intel bench's and they are specing an increase of 0% to 30%
> 
> I think I'd be less cynical about benchmark results that didn't come from the
> people trying to sell  the product ;-)
> 
[...]
> Real world benchmarks from people other than Intel should make interesting
> reading .... I think we need some more smarts in the OS to take real advantage
> of this (eg using the NUMA scheduling mods to create cpu pools of 2 "procs"
> for each pair, etc) ... will be fun ;-)

Well, here I have some.

The tests involved kernel compiled (2.4.18) from a make mrproper, single
nbench, and unixbench (likely the most useful).

The output from tests can be found at http://www.hardrock.org/HT-results/

Results consist of (all with hyperthreading on and off):
o timed make bzImage and make modules using -j2 -j4 and -j6.
o BYTEmark output (single run)
o BYTE UNIX Benchmarks (Version 4.1.0) log, report, and times
o output from /proc/cpu
o output from /proc/interrupts
o output from dmesg (sorry, one of them has the top clipped).
o output from lspci -v

>From the results what I see is that if you are running a system with
many concurrent tasks then hyperthreading makes sense.  Many
concurrent systems (the -j4 and -j6 kernel compiles for example)
do see improvements.  Although this is not a very analytical test, I don't
have time for 10 iterations of each to get a better set of numbers.

Thanks to all and regards,
James Bourne


> 
> M.
> 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************

