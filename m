Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUCZB2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 20:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbUCZB2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 20:28:03 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:18026 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263858AbUCZBYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 20:24:52 -0500
Date: Thu, 25 Mar 2004 19:20:56 -0600
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Large memory application exhuasts buffers during write.
Message-ID: <20040326012056.GB19152@lnx-holt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a large memory application which is being killed by the OOM
killer.

This is a 2.4 based kernel with many of the redhat patches applied.
Before the application is started, there is approx 350GB of memory
free according to top.  When the app starts, it mallocs a 300GB
buffer, initializes it, does computations into it, and then starts
to write it to a disk file.

What we see happen is the first approx 30GBs gets written and then
swap starts getting utilized.  Once swap has been heavily utilized,
the OOM killer kicks in and kills the job.

The application is a vendor provided app and probably cannot be
modified.  Does anybody have any suggestion on possible changes
to make to the kernel to eliminate or significantly reduce the
likelihood that the job gets terminated.

Thanks,
Robin Holt
