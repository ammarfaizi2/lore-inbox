Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271727AbTGRHIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 03:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271729AbTGRHIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 03:08:41 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45706
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S271727AbTGRHIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 03:08:39 -0400
Date: Fri, 18 Jul 2003 09:23:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22pre6aa2
Message-ID: <20030718072331.GC3928@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22pre6aa2.gz

changelog diff between 2.4.22pre6aa1 and 2.4.22pre6aa2:

Only in 2.4.22pre6aa1: 00_extraversion-26
Only in 2.4.22pre6aa2: 00_extraversion-27
Only in 2.4.22pre6aa1: 9900_aio-21-ppc-1
Only in 2.4.22pre6aa2: 9903_aio-22-ppc-1
Only in 2.4.22pre6aa1: 9999_sched_yield_scale-5
Only in 2.4.22pre6aa2: 9999_sched_yield_scale-6

	Rediffed.

Only in 2.4.22pre6aa1: 05_vm_23_per-cpu-pages-2
Only in 2.4.22pre6aa2: 05_vm_23_per-cpu-pages-3

	Minor cleanup.

Only in 2.4.22pre6aa1: 9900_aio-21.gz
Only in 2.4.22pre6aa2: 9900_aio-22.gz

	Add KM_SOFTIRQ0/1 so crypto can compile.

Only in 2.4.22pre6aa2: 9902_aio-poll-1

	Added the AIO polling functionality. NOTE: the ABI
	is IOCB_CMD_POLL = 5. IMHO rather than moving poll
	into aio, aio should be moved on top of epoll. using poll should always
	be avoided, but apps already uses aio poll, so at least
	for the short term it'll be useful. the better approch I suggested is
	to hook the iocb somehow into an epoll fd. that epoll
	feature is missing right now AFIK, but it shouldn't be hard to add and
	it will give persistence to the polling too. The efficient point to
	sleep is epoll, not io_getevents/poll (io_getevents is optimal only
	for waiting for I/O [be it storage or network or pipe I/O of course]).

Only in 2.4.22pre6aa1: 9999900_desktop-2
Only in 2.4.22pre6aa2: 9999900_desktop-3

	Convert max-timeslice/min-timeslice to usecs units
	(the day we'll be interested to schedule more frequently than 1 time
	per usec, I guess we'll be very happy to break this interface with
	userspace ;).

Only in 2.4.22pre6aa1: 9999900_ecc-20020904-1.gz
Only in 2.4.22pre6aa2: 9999900_ecc-20020904-2.gz

	Merged more recent updates from Chip.

Andrea
