Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVAGTTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVAGTTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVAGTSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:18:03 -0500
Received: from [202.141.25.89] ([202.141.25.89]:29077 "EHLO
	pridns.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261536AbVAGTQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:16:52 -0500
Subject: SCHED_BATCH not stopped (swsusp fails)
From: Rajsekar <raj--cutme--sekar@cse.iDELTHISitm.ernet.in>
To: linux-kernel@vger.kernel.org
Date: Sat, 08 Jan 2005 00:46:09 +0530
Message-ID: <m3oeg1uk1y.fsf@rajsekar.pc>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SCHED_BATCH processes dont seem to heed the `stop' request (order?) by
swsusp.  I run httpd and mysqld (for my wiki page) with SCHED_BATCH (so
that I can work on my computer even if the load is very high) but when I
try to suspend the system, it tries to stop the tasks and simply returns.
Here is the dmesg output (paritial)

#dmesg
....
....
Stopping tasks: =======================================
 stopping tasks failed (20 tasks remaining)
Restarting tasks...<6> Strange, mysqld not stopped
 Strange, mysqld not stopped
 Strange, mysqld not stopped
 Strange, mysqld not stopped
 Strange, mysqld not stopped
 Strange, mysqld not stopped
 Strange, mysqld not stopped
 Strange, mysqld not stopped
 Strange, mysqld not stopped
 Strange, httpd not stopped
 Strange, httpd not stopped
 Strange, httpd not stopped
 Strange, httpd not stopped
 Strange, httpd not stopped
 Strange, httpd not stopped
 Strange, httpd not stopped
 Strange, httpd not stopped
 Strange, httpd not stopped
 Strange, httpd not stopped
 Strange, httpd not stopped
 done
===================


-- 
    Rajsekar

