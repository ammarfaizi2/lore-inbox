Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279568AbRKFTmJ>; Tue, 6 Nov 2001 14:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280288AbRKFTl7>; Tue, 6 Nov 2001 14:41:59 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:42104 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S279568AbRKFTlq>; Tue, 6 Nov 2001 14:41:46 -0500
Message-ID: <3BE83CB8.2A8C38FB@redhat.com>
Date: Tue, 06 Nov 2001 14:40:40 -0500
From: Bob Matthews <bmatthews@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: 2.4.14-pre8 stress testing
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've been doing some stress testing on 2.4.14-pre8 here.  So far the
results look positive, with the exception of an SMP PAE kernel on one of
our 8-ways.

- A UP kernel with no highmem passed all our tests on 256M/512M and
800M/1600M RAM/Swap combo's.

- An SMP kernel with highmem=4G passed all our tests on two 1G/2G dual
processor configurations.

The problem kernel is statically linked, with HIGHMEM=64G, SMP, NFS
client and server V3, eepro100, and the sym53c8xx driver.  The machine
is an 8xPIII configured as 8G/16G.

The machine ran the test suite for ~17 hours, and then gradually began
to slow down to the point where key presses at a virtual console took
many seconds to echo.  Eventually, the machine became unresponsive.  The
test harness clock is still ticking, and I can change VC's, but that's
about it.  Magic Sysrq doesn't give me anything except the name of the
corresponding command.  The machine does not appear to have generated
any oops output.

If I can provide you with anymore info, please let me know.
-- 
Bob Matthews
Red Hat, Inc.
