Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWELO7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWELO7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWELO7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:59:04 -0400
Received: from dvhart.com ([64.146.134.43]:42725 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932110AbWELO7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:59:02 -0400
Message-ID: <4464A2AE.9080905@mbligh.org>
Date: Fri, 12 May 2006 07:58:54 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: bill@crowellsystems.com
Subject: [Bug 6537] New: #ifdef CONFIG_PM causes MPT to not compile
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugzilla.kernel.org/show_bug.cgi?id=6537

            Summary: #ifdef CONFIG_PM causes MPT to not compile
     Kernel Version: 2.6.17-rc4
             Status: NEW
           Severity: blocking
              Owner: io_other@kernel-bugs.osdl.org
          Submitter: bill@crowellsystems.com


Most recent kernel where this bug did not occur: 2.6.17-rc3
Distribution: slack
Hardware Environment: i386
Software Environment: gcc 3.3
Problem Description: /drivers/message/fusion/mpt* using #ifdef CONFIG_PM 
are not
exporting the mpt_suspend mpt_resume. I do not know why we would want to
exercise power management on high-performance scsi controllers in the first
place. LSI controllers are server devices.

Steps to reproduce: compile the kernel. causes a kernel compilation failure.

Steps to fix:
comment out the #ifdef CONFIG_pm and corresponding #endif to disable this
compilation flag. recompile and the world is happy.

