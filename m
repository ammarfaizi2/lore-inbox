Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbTJUSBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 14:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbTJUSBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 14:01:44 -0400
Received: from data.iemw.tuwien.ac.at ([128.131.70.3]:31360 "EHLO
	data.iemw.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S263211AbTJUSBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 14:01:42 -0400
Message-ID: <3F95748E.8020202@tuwien.ac.at>
Date: Tue, 21 Oct 2003 20:01:50 +0200
From: Samuel Kvasnica <samuel.kvasnica@tuwien.ac.at>
Organization: IEMW TU-Wien
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, de-at, cs
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nforce2 random lockups - still no solution ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Last few weeks I spent quite much time trying to get working two nforce2 
chipset based motherboards with latest linux 2.4.22 - ASUS A7N8 Deluxe 
2.0 and
MSI K7N2 Delta. Althought the latest kernel version already detects 
correctly all the nforce2 stuff and APIC seems to run work as well,
some random lockups still remain. At the very beginning I believed I 
could get rid of lockups by setting lower udma mode on IDE (hdparm -X 
udma3).
In the fact this only reduced very much the probability of lockups - 
with udma5 I could freeze the system within few minutes e.g. during 
kernel compilation.
with udma3 system is usually stable for several days, but sometimes it 
locks. When it happens, it happens mostly during first 30 mins after boot.
I'm booting with noapic, nolapic and acpi=off, but it doesn't seem to 
have really any effect on lockups.
Unfortunatelly, I can't get any debug info. I've redirected syslog to 
flash-card but didn't get even a bit more of info, it seems to blow-up
the chipset completelly and immediatelly.

Now, in the system with MSI K7N2 motherboard I have a framegrabber 
(Hauppauge PVR-250) installed, using ivtv driver.
I'm able to lock-up the system when streaming uncompressed video (e.g. 
cat /dev/yuv0 >/dev/null) and the lockups are also hard, w/o debug info.
The ivtv driver is using DMA very heavily  but seems to work on other 
chipsets. So these lock-up problems might be rather DMA then APIC related.
Interesting is that I've never had such a lock-up when running WinXP on 
same computer ( :-) seems impossible), even under load and with the 
framegrabber.
I've run memtest on both machines for 24 hours, it shouldn't  be bad 
memory. On both machines I'm using just onboard hardware, except for the 
AGP graphic card
(matrox and nvidia) and the framegrabber. Hard disk is on parallel IDE, 
SATA controller is disabled.

So my conclusion is that the nforce2 lock-ups are still unsolved at the 
moment. Any nforce experts around ?

Please, reply directly using cc:, I'm not on the list.

thanks,

Sam



