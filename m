Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261273AbTC0Snp>; Thu, 27 Mar 2003 13:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbTC0Snp>; Thu, 27 Mar 2003 13:43:45 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:21495 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S261273AbTC0Sno>; Thu, 27 Mar 2003 13:43:44 -0500
Date: Thu, 27 Mar 2003 10:52:08 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: WimMark I report for 2.5.66-mm1
Message-ID: <20030327185208.GC32000@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	There seem to have been some NFS issues during this run (other
things are on NFS), so take the bad numbers with a grain of salt.  The
best numbers for each run (1119.58 for AS and 1532.29 for DL) are
consistent with earlier kernels, though on the low end.

WimMark I report for 2.5.66-mm1

Runs (as):  1119.58 735.69 879.24
Runs (deadline):  1221.11 1376.93 1532.29

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

Life's Little Instruction Book #510

	"Count your blessings."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
