Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbTIJNML (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 09:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTIJNML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 09:12:11 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:31620 "EHLO
	mailrelay01.tugraz.at") by vger.kernel.org with ESMTP
	id S263036AbTIJNMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 09:12:08 -0400
From: Tom Winkler <tom@qwws.net>
Reply-To: tom@qwws.net
To: linux-kernel@vger.kernel.org
Subject: BugReport: USB (ACPI), E100, SWSUSP problems (test5 vs. test3)
Date: Wed, 10 Sep 2003 15:11:26 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309101511.26593.tom@qwws.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently updated my kernel on my laptop (Sony Vaio FX403, i815 chipset, PIII 
1GHz CPU) from 2.6.0test3 to 2.6.0test5 (I skipped test4). I used the same 
.config for test5 as for test3.

test5 (or already test4) introduced some problems that were not there in 
test3:

- USB is totally dead
  This notebook has some IRQ routing problems and requires ACPI to get it 
right. When using older 2.4 Kernels I always had to apply the ACPI patches to 
get USB working. Because of that I suspect that the problems with test5 might 
be ACPI related as well.

- The e100 driver seems to be broken
  The NIC is detected correctly and ifconfig shows eth0 as usually. But for 
some reason not a single Byte seems to go over the NIC. 

- SWSUSP
  In test5 there is no /proc/acpi/sleep
  In test3 suspend to disk (and resume) works in "console only" mode. 
Suspending from X11 works too but resuming hangs. The last message that gets 
displayed is "Waiting for DMAs to settle down...". At this point the machine 
seems to freeze completely.
Remark: I had SWSUSP working on this very same machine with older 2.4 kernels 
and seperat SWSUSP patches. It never worked with 2.6 so far.

full dmesg:   http://www.wnk.at/tmp/test5/dmesg-2.6.0test5.txt
.config used building the kernel:   http://www.wnk.at/tmp/test5/config.txt

Since I'm not subscribed to LKM please CC me on replys.

Thanks,
-- 
Tom Winkler
e-mail: tom@qwws.net

