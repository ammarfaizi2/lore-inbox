Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTEJOZx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 10:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTEJOZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 10:25:52 -0400
Received: from franka.aracnet.com ([216.99.193.44]:13713 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264252AbTEJOZv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 10:25:51 -0400
Date: Sat, 10 May 2003 05:24:12 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 699] New: i386 SMP : IRQ routing problems (fwd)
Message-ID: <1620000.1052569452@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=699

           Summary: i386 SMP : IRQ routing problems
    Kernel Version: 2.5.68
            Status: NEW
          Severity: blocking
             Owner: mbligh@aracnet.com
         Submitter: josh@stack.nl


Distribution: Mandrake 9.1
Hardware Environment: Dual PII 333 on Intel 440 LX SMP mainboard
Software Environment: Bare shell after kernel boot
Problem Description: CPU 1 stops accepting interrupts, APIC IRQ rerouting
doesn't work. As a result, only CPU 0 receives timer interrupts (and thus I got
practically an UP system), and my devices don't work when IRQ rerouting (MPS 1.4
in my BIOS) is enabled, for they claim the wrong (read: the one before
rerouting) interrupt line.

NOTE: both bugs also occur in the 2.4.21 kernel that Mandrake 9.1 ships, but as
this is a Mandrake-hack you might not really care. Other 2.4 kernels untested at
this moment.

Steps to reproduce:
Check /proc/interrupts after booting.

To check whether it is a Mandrake thing, I cleared the lilo append options,
removed the Mandrake initrd, and performed a sulogin first thing after entering
rc.sysinit. This didn't affect the problems.

On the URL : http://www.stack.nl/~josh/linux/ you should be able to find all
files / output that might be useful in solving this.

