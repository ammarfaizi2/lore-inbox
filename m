Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTEGXy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264408AbTEGXwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:52:32 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:12445 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S264407AbTEGXvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:51:00 -0400
Date: Wed, 7 May 2003 17:02:30 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org
Subject: WimMark I report for 2.5.69-mm1
Message-ID: <20030508000229.GC3989@ca-server1.us.oracle.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WimMark I report for 2.5.69-mm1

Runs (anticipatory):  540.90 438.91 409.40
Runs (deadline):  1043.80 1153.82 1259.83

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

"I don't even butter my bread; I consider that cooking."
         - Katherine Cebrian

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
