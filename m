Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTDJQSF (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 12:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbTDJQSF (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 12:18:05 -0400
Received: from franka.aracnet.com ([216.99.193.44]:26093 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264088AbTDJQSE (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 12:18:04 -0400
Date: Thu, 10 Apr 2003 09:29:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 572] New: Change compile-time option CONFIG_APM_RTS_IS_GMT to sysctl-tunable kernel parameter
Message-ID: <216320000.1049992182@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=572

           Summary: Change compile-time option CONFIG_APM_RTS_IS_GMT to
                    sysctl-tunable kernel parameter
    Kernel Version: 2.5.64-mm6 (and others)
            Status: NEW
          Severity: low
             Owner: apmbugs@rothwell.emu.id.au
         Submitter: om@iki.fi


Distribution: RH8.0
Hardware Environment: Dell Latitude C600 laptop + docking station
Problem Description:
The fact that CONFIG_APM_RTS_IS_GMT is a kernel compile-time flag instead of a
sysctl-tunable parameter (and companies like RedHat deliver kernels compiled
with this flag on) means that you have to recompile the kernel just to be able
to run Linux in environments where the RTC _cannot_ be set to GMT (like when
co-existing with Windows operating systems). Once set up, the kernel parameter
could be set according to /etc/sysconfig/clock setting at boot time, simplifying
life for all. A quick browse of the apm.c source code makes me think this change
would not really require major work, but of course I could be mistaken.
Steps to reproduce:
The usual problems occur when the kernel compile flag setting does not match
with the actual RTC setting, like time zone changes when switching displays via
the APM BIOS.

