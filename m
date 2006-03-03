Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWCCVGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWCCVGf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWCCVGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:06:35 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:7866 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932471AbWCCVGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:06:35 -0500
Message-ID: <4408BCAD.8040902@soleranetworks.com>
Date: Fri, 03 Mar 2006 15:01:17 -0700
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: AMD64 Opteron 250 Errors and APIC Issues with DSFS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have ported DSFS to the AMD and IA64 processors.  I am currently 
testing with an AMD64 Opteron 250 2.4 Ghz SMP Processor
with DSFS at 250 megabyte per second through from dual 1 GB Intel 
Adapters.  I am seeing excellent application performance
but sluggish I/O performance. 

Using the 2.4.21 kernels with the AMD was disappointing with the system 
locking up and barfing all over the place.  Since I have
update to unit to 2.4.6-22, the performance has increased dramatically.  
This board is employing an 82489DX emulation of the
Intel IOAPIC architecture, but it is reporting an abnormally high level 
of interrupts.  The I/O scaling is vastly improved on 2.6.X
kernels over 2.4.X, however, the performance is still 15% less overall 
than with equivalent Xeon and 7501/7505 based chipsets.

I am also seeing this message on the screen from the do_softirq handler:

Your time source seems to be instable or some driver is hogging 
interrupts.    rip __do_softirq+0x04d/0xd0.

Are there any other tuning parms for the AMD64 to increase I/O scaling?  
I can rewrite the APIC code underneath and redirect the
spurious interrupt handler and EOI sequences to eliminate the excessive 
interrupts, but is there information on better tuning for these
systems using IOAPIC emulation?

Jeff

