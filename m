Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUDQCHR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 22:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUDQCHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 22:07:17 -0400
Received: from web12821.mail.yahoo.com ([216.136.174.202]:53135 "HELO
	web12821.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261210AbUDQCHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 22:07:14 -0400
Message-ID: <20040417020713.16619.qmail@web12821.mail.yahoo.com>
Date: Fri, 16 Apr 2004 19:07:13 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Process hang with 2.6.6-rc1
To: Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been experiencing process hangs since upgrading
to 2.6.6-rc1.  The system is usually able to stay up
for a day before the hang.  But it is quite consistent
in that it always hangs.  I experienced the same hang
with 2.6.5-bk1 as well.  In the thread traces, it
looks as though the mmap_sem of pid 3960 (pan) is not
being released preventing any other process from
locking the address space.  This is readily apparent
from the hung "ps" command.  It is trying to read
"/proc/3960/stat".
Any clues would be appreciated as I have not been able
to make any headway in debugging this.  My hardware
information is below and I have attached the sysrq-t
output and .config.

Thanks,
Shantanu

Kernel version: 2.6.6-rc1 SMP
Hardware Info: Dell PE1600SC with 2x2Ghz Xeon CPUs

D




	
		
__________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online by April 15th
http://taxes.yahoo.com/filing.html
