Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263133AbTCSSHx>; Wed, 19 Mar 2003 13:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263134AbTCSSHw>; Wed, 19 Mar 2003 13:07:52 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:48854 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S263133AbTCSSHv>; Wed, 19 Mar 2003 13:07:51 -0500
Date: Wed, 19 Mar 2003 10:18:30 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       Andrew Morton <akpm@digeo.com>
Subject: WimMark I report for 2.5.65-mm1
Message-ID: <20030319181829.GE2835@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


WimMark I report for 2.5.65-mm1

Runs (antic):  1559.32 1025.38 1579.98
Runs (deadline):  1554.48 1589.89 1350.37

	WimMark I is a rough benchmark we have been running
here at Oracle against various kernels.  Each run tests an OLTP
workload on the Oracle database with somewhat restrictive memory
conditions.  This reduces in-memory buffering of data, allowing for
more I/O.  The I/O is read and sync write, random and seek-laden.
	The benchmark is called "WimMark I" because it has no
official standing and is only a relative benchmark useful for comparing
kernel changes.  The benchmark is normalized an arbitrary kernel, which
scores 1000.0.  All other numbers are relative to this.
	The machine in question is a 4 way 700 MHz Xeon machine with 2GB
of RAM.  CONFIG_HIGHMEM4GB is selected.  The disk accessed for data is a
10K RPM U2W SCSI of similar vintage.  The data files are living on an
ext3 filesystem.  Unless mentioned, all runs are
on this machine (variation in hardware would indeed change the
benchmark).


-- 

"There are only two ways to live your life. One is as though nothing
 is a miracle. The other is as though everything is a miracle."
        - Albert Einstein

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
