Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318898AbSHSOqb>; Mon, 19 Aug 2002 10:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318904AbSHSOqb>; Mon, 19 Aug 2002 10:46:31 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:31700 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318898AbSHSOqa>; Mon, 19 Aug 2002 10:46:30 -0400
Subject: LTP-Nightly bk test
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net,
       ltp-results <ltp-results@lists.sourceforge.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Aug 2002 09:42:36 -0500
Message-Id: <1029768156.2582.113.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 8/17 run of the nightly bk testing I'm doing turned up a lot of page
allocation failures in the dmesg and eventually an oops in swap.c:85
(uncaptured, will try to reproduce on current).  Unfortunatly this meant
the test did not run after that.  This morning I rebooted the machine
and ran it against the current bk tree and with a single test was able
to produce a LOT of these messages:

page allocation failure. order:0, mode:0x50

The test was: 'mtest01 -p80 -w' which will essentially allocate up to
80% of the memory and write to it.  I'll keep pounding on it with LTP to
see if I can reproduce the swap.c:80 oops.

Thanks,
Paul Larson
Linux Test Project

