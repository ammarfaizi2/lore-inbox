Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293379AbSCSArP>; Mon, 18 Mar 2002 19:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293390AbSCSArF>; Mon, 18 Mar 2002 19:47:05 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:42758 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S293379AbSCSAqv>;
	Mon, 18 Mar 2002 19:46:51 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15510.32200.595707.145452@argo.ozlabs.ibm.com>
Date: Tue, 19 Mar 2002 10:52:40 +1100 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203181446200.10517-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Oh, you're cycle timer is too slow to be interesting, apparently ;(

The G4 has 4 performance monitor counters that you can set up to
measure things like ITLB misses, DTLB misses, cycles spent doing
tablewalks for ITLB misses and DTLB misses, etc.  I hacked up a
measurement of the misses and total cycles doing tablewalks during a
kernel compile and got an average of 36 cycles per DTLB miss and 40
cycles per ITLB miss on a 500MHz G4 machine.  What I need to do now is
to put some better infrastructure for using those counters in place
and try your program using those counters instead of the timebase.

Paul.
