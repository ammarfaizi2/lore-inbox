Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTJAOT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTJAOT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:19:56 -0400
Received: from web40406.mail.yahoo.com ([66.218.78.103]:42514 "HELO
	web40406.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262208AbTJAOTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:19:21 -0400
Message-ID: <20031001141921.67144.qmail@web40406.mail.yahoo.com>
Date: Wed, 1 Oct 2003 07:19:21 -0700 (PDT)
From: Joshua Weage <weage98@yahoo.com>
Subject: More NFS client problems with 2.4.20
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to the previous post on NFS client problems with
the RedHat 2.4.18 - 2.4.20 kernels.

After 3 weeks of no problems, the problem showed up again on a
different cluster node.  Four out of 12 nodes have now shown this
problem, but it seems to affect nodes randomly.  It always occurs
during heavy NFS writes.  A job running on the problem node stops,
waiting for NFS read/writes.  All of the other nodes continue to see
the NFS server just fine.  If I try to do an ls on the NFS mount point
on the problem node, the shell locks up.

Checking nfsstat, retrans is not going up, however, getattr is
increasing about 2 per sec.  Also, the stuck processes always show a
WCHAN of "end".

Any ideas what is going wrong?

Thanks,

Joshua Weage

=====


__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
