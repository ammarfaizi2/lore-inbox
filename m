Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTCJX3E>; Mon, 10 Mar 2003 18:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTCJX3E>; Mon, 10 Mar 2003 18:29:04 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:18856 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261900AbTCJX3D>; Mon, 10 Mar 2003 18:29:03 -0500
Date: Mon, 10 Mar 2003 15:39:36 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org
Subject: WimMark I for 2.5.64-mm4
Message-ID: <20030310233936.GP2835@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WimMark I report for 2.5.64-mm4

Runs with anticipatory scheduler:  1066.70 1291.23
Runs with deadline scheduler:  1655.77 1594.73 1610.91

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

"You cannot bring about prosperity by discouraging thrift. You cannot
 strengthen the weak by weakening the strong. You cannot help the wage
 earner by pulling down the wage payer. You cannot further the
 brotherhood of man by encouraging class hatred. You cannot help the
 poor by destroying the rich. You cannot build character and courage by
 taking away a man's initiative and independence. You cannot help men
 permanently by doing for them what they could and should do for themselves."
	- Abraham Lincoln 


Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
