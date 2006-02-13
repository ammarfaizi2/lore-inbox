Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWBMCag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWBMCag (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 21:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWBMCag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 21:30:36 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:30220 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751113AbWBMCaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 21:30:35 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andi Kleen <ak@suse.de>
Subject: 2.6.16-rc2, x86-64, CPU hotplug failure
Date: Mon, 13 Feb 2006 02:30:41 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1606
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602130230.41120.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In an attempt to play with ACPI S3 on my Athlon 64 X2 3800+, I recompiled 
2.6.16-rc2 with CPU hotplug and ACPI sleep state support. I experienced 
multiple crashes and oopsen, which I quickly discovered were the result of 
bringing at least one CPU back online.

echo 0 >> /sys/devices/system/cpu/cpu1/online

Works, but then if I try to do:

echo 1 >> /sys/devices/system/cpu/cpu1/online

I get an oops. Unfortunately this board has no serial ports so I've taken a 
digital camera shot of the oops. From dmesg, I'm using the PM timer.

[alistair] 02:13 [~] dmesg | egrep time\.c
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2500.768 MHz processor.
time.c: Using PM based timekeeping.

http://devzero.co.uk/~alistair/oops-20060213/

Find the oops, my config and dmesg for a successful boot at this location.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
