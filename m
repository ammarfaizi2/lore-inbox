Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272252AbTHDVqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272244AbTHDVqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:46:47 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:49030 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272235AbTHDVpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:45:46 -0400
Message-ID: <3F2ED387.6030402@redhat.com>
Date: Mon, 04 Aug 2003 17:43:35 -0400
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Convert utime, stime, cutime, cstime to struct timeval
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've converted the task struct items mentioned in $subject to struct 
timeval and converted all the core code that I found that touched it to 
the appropriate conversions.  This is a prerequisite patch for forward 
porting the process timing patch I've written for 2.4 kernels.  The 
process timing patch uses the tsc on x86 machines to give much more 
accurate process timing instead of the current statistical process 
timing.  I've attempted to make sure that this won't break arches other 
than x86 (and I know it's sufficient for the ppc64, ppc, ia64, and 
x86_64 in addition to x86 under the 2.4 kernel, but I might have missed 
something under 2.6).

Patch is available at 
http://xsintricity.com/dledford/struct_timeval.patch (it's a bit large 
to be attached) or can be retrieved from bk://linux-scsi.bkbits.net/dledford

-- 
   Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
            Red Hat, Inc.
            1801 Varsity Dr.
            Raleigh, NC 27606


