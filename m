Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbTDOPyK (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 11:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbTDOPyK 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 11:54:10 -0400
Received: from franka.aracnet.com ([216.99.193.44]:45761 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261707AbTDOPyI 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 11:54:08 -0400
Date: Tue, 15 Apr 2003 09:05:57 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 589] New: rtc won't compile because expect return from void
 function
Message-ID: <75850000.1050422757@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=589

           Summary: rtc won't compile because expect return from void
                    function
    Kernel Version: 2.5.67
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: jstrand1@rochester.rr.com


Distribution:  Debian
Hardware Environment:  P4
Software Environment:  gcc 2.95.3
Problem Description:  

rtc fails to compile because of this line in drivers/char/genrtc.c (in
gen_rtc_proc_output, ca line 453):

flags = get_rtc_time(&tm);

get_rtc_time is a void function.  Also, though it will compile, just setting
flags to '0' would result in proc output not being accurate, since flags is
ANDed to various items.


