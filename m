Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267523AbTAGUhS>; Tue, 7 Jan 2003 15:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbTAGUgQ>; Tue, 7 Jan 2003 15:36:16 -0500
Received: from franka.aracnet.com ([216.99.193.44]:24530 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267505AbTAGUgC>; Tue, 7 Jan 2003 15:36:02 -0500
Date: Tue, 07 Jan 2003 12:44:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (0/7) Finish moving NUMA-Q into subarch, cleanup
Message-ID: <616650000.1041972277@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; FORMAT=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oops --- the original of this went to Linus, but not LKML, sorry.

------------------------------------

The following sequence of patches finishes the move of NUMA-Q into
subarch, and cleans up some of the mess I made when I put it in
originally. clustered_apic_mode, CONFIG_CLUSTERED_APIC and smpboot.h
all die by the end of the sequence.

There are some topology changes in here, which are needed as a precursor
to the cpu<->apicid mapping cleanups, which are needed to make Summit work.
I've tried hard to break everything out into small readable chunks, and
it's designed to be a complete no-op on standard machines.

Tested on UP, standard SMP, Crusader, NUMA-Q, and Summit (x440).
Test-compiled on UP+IO/APIC. No new compiler warnings are introduced.
Removes more lines of code than it adds, according to diffstat.
This is the last of the stuff for moving NUMA-Q into subarch.

Please apply,

Thanks,

Martin.
