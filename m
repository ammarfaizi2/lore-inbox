Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTDROwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 10:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbTDROwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 10:52:45 -0400
Received: from franka.aracnet.com ([216.99.193.44]:41401 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263062AbTDROwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 10:52:44 -0400
Date: Fri, 18 Apr 2003 07:30:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 600] New: File locking memory leak
Message-ID: <23360000.1050676254@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll forward this one out as a plea for more information / testers ;-)

M.

---------- Forwarded Message ----------

http://bugme.osdl.org/show_bug.cgi?id=600

           Summary: File locking memory leak
    Kernel Version: many
            Status: NEW
          Severity: high
             Owner: willy@debian.org
         Submitter: willy@debian.org


Problem Description:

Some people have reported to me that the file_lock_cache grows virtually
without bound.  I haven't been able to reproduce the problem yet.  I'm
filing this bug here to track the problem.

I suspect it depends on workload.  First problem will be to track down what
type of lock it is; that'll give me some clue as to which of the three
independent implementations in the file locking code is leaking locks.

Steps to reproduce:

