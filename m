Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbTEWUgh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbTEWUgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:36:37 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:34241 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S264182AbTEWUge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:36:34 -0400
Date: Fri, 23 May 2003 13:47:59 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org
Subject: WimMark I report for 2.5.69-mm8
Message-ID: <20030523204759.GE32128@ca-server1.us.oracle.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WimMark I report for 2.5.69-mm8

Runs (deadline): 1087.95 1053.95 1043.80 1086.53 1049.23 1097.63
Runs (anticipatory):  670.52 967.77 977.69

	WimMark I is a rough benchmark we have been running
here at Oracle against various kernels.  Each run tests an OLTP
workload on the Oracle database with somewhat restrictive memory
conditions.  This reduces in-memory buffering of data, allowing for
more I/O.  The I/O is read and sync write, random and seek-laden.  The
runs all do ramp-up work to populate caches and the like.
	The benchmark is called "WimMark I" because it has no
official standing and is only a relative benchmark useful for comparing
kernel changes.  The benchmark is normalized an arbitrary kernel, which
scores 1000.0.  All other numbers are relative to this.  A bigger number
is a better number.  All things being equal, a delta <50 is close to
unimportant, and a delta < 20 is very identical.
	This benchmark is sensitive to random system events.  I run
three runs because of this.  If two runs are nearly identical and the
remaining run is way off, that run should probably be ignored (it is
often a low number, signifying that something on the system impacted
the benchmark).
	The machine in question is a 4 way 700 MHz Xeon machine with 2GB
of RAM.  CONFIG_HIGHMEM4GB is selected.  The disk accessed for data is a
10K RPM U2W SCSI of similar vintage.  The data files are living on an
ext3 filesystem.  Unless mentioned, all runs are
on this machine (variation in hardware would indeed change the
benchmark).
	WimMark I run results are archived at
http://oss.oracle.com/~jlbec/wimmark/wimmark_I.html


-- 

"One of the symptoms of an approaching nervous breakdown is the
 belief that one's work is terribly important."
         - Bertrand Russell 

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
