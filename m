Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261962AbTCTUbF>; Thu, 20 Mar 2003 15:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261994AbTCTUbF>; Thu, 20 Mar 2003 15:31:05 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:29834 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S261962AbTCTUbE>; Thu, 20 Mar 2003 15:31:04 -0500
Date: Thu, 20 Mar 2003 12:40:41 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@diego.com
Subject: WimMark I report for 2.5.65-mm2 (now with deadline)
Message-ID: <20030320204041.GO2835@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


WimMark I report for 2.5.65-mm2

Runs (antic):  1374.22 1487.19 1437.26
Runs (deadline):  1238.58 1537.36 1513.04

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

"Always give your best, never get discouraged, never be petty; always
 remember, others may hate you.  Those who hate you don't win unless
 you hate them.  And then you destroy yourself."
	- Richard M. Nixon

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
