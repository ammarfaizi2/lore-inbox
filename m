Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264864AbTFQUXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264924AbTFQUXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:23:55 -0400
Received: from franka.aracnet.com ([216.99.193.44]:16285 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264864AbTFQUXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:23:49 -0400
Date: Tue, 17 Jun 2003 13:37:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 819] New: uptime wrong on x86-64 (fwd)
Message-ID: <38850000.1055882259@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: uptime wrong on x86-64
    Kernel Version: 2.5.72
            Status: NEW
          Severity: normal
             Owner: johnstul@us.ibm.com
         Submitter: johnstul@us.ibm.com


Distribution: SLES8  
Hardware Environment: AMD64 Melody box  
Software Environment: 2.5.72  
Problem Description:   
  
uptime reports wrong value after booting  
  
Steps to reproduce:  
jstultz@elm3b31:~/linux-2.5> uptime  
  
Actual result:  
  1:19pm  up 12220 days, 20:19,  1 user,  load average: 0.00, 0.00, 0.00  
  
Expected result:  
  1:19pm  up 15 min,  1 user,  load average: 0.00, 0.01, 0.02  
  
Additional info:  
jstultz@elm3b31:~/linux-2.5> date +%s  
1055881186  
jstultz@elm3b31:~/linux-2.5> cat /proc/stat | grep btime  
btime 1055880294  
  
I've been unable to reproduce the problem on i386, however this has also been  
reported against sparc64 by Daniel Whitener.    
  
I suspect it might have something to do w/ do_posix_clock_monotonic_gettime() on  
these arches.

