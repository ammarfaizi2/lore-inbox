Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVJDJ0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVJDJ0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 05:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVJDJ0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 05:26:49 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:54240 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751199AbVJDJ0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 05:26:48 -0400
Message-ID: <43424AD8.2020508@anagramm.de>
Date: Tue, 04 Oct 2005 11:26:48 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.2 crash on shutdown on SMP machine
References: <433A747E.3070705@anagramm.de> <Pine.LNX.4.61.0509280812250.1684@montezuma.fsmlabs.com> <433BDC11.7070407@anagramm.de> <Pine.LNX.4.61.0509291243440.1684@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0509291243440.1684@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Zwane!

You wrote:
> memtest and repeated multijob kernel/gcc builds seems to do a very good 
> job. Let me know how the new kernel goes, i'm going to try and see if any 
> of my systems can trigger it.

Okay, I've tried the latest linux' git tree from friday last week:
2.6.14-rc3-something, but the

c010fdd5    send_IPI_mask_bitmask+0x65/0x70
c0110236    smp_send_reschedule+0x16/0x20 

still occurs when I want to do a "shutdown -h now".
A reboot or "shutdown -r now" seems to work without any errors (or at least
I cannot see any until the graphcs card get re-initialized)!

All that is on a Tyan Tomcat IIID (S1563D) machine, w/ the latest BIOS (4.02)
APM and ACPI are currently disabled...

Unfortunately, I have had a severe two-at-a-time hard-disk crash on another
machine, which kept me quite busy the last days. :-(
Hopefully, by the end of this week, I will be able to debug into that more...
Can you give me a pointer to some code, where the kernel actually splits
up in between rebooting and halting the system?

Thanks,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
