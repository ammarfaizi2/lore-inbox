Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTJRUYw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 16:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTJRUYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 16:24:52 -0400
Received: from pop.gmx.de ([213.165.64.20]:55427 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261786AbTJRUYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 16:24:51 -0400
X-Authenticated: #295886
From: "Howard The Duck" <h.t.d@gmx.de>
Organization: privat
To: linux-kernel@vger.kernel.org
Date: Sat, 18 Oct 2003 22:25:03 +0200
MIME-Version: 1.0
Subject: "Disabling IRQ #18" when mounting cdrom with SATA on 2.6.0beta7/8?
Message-ID: <3F91BDBF.14789.17CDF8A@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I had troubles with the 2.6 series using devfs and my SATA drive, i got the "Disabling 
irq #18" message on boot. I removed devfs support and the machine worked flawless, 
until i mounted a cdrom. I very seldom need to access cdroms or dvds that's why i 
never saw this happening within the last few month of kernel installing (starting with 
2.5.74 in June because 2.4.21 and 2.4.22 wouldn't boot at all).

When i do not mount cdroms or enable devfs support in the kernel the system is 
running very stable and fast. My troubles with devfs are described here 
http://www.ussg.iu.edu/hypermail/linux/kernel/0310.1/0874.html

My current setup has no devfs support, but i get the  "Disabling IRQ #18" message 
right after the moment i mounted a cdrom/dvd with my dvd-drive or a cdrom with the 
cd-writer. Accessing the PATA harddrives seems to have no negative effect, although i 
can only test them by reading data because they are NTFS partitions and mounted 
read-only. Even when i unmount the CDrom the "Disabling IRQ #18" message keeps 
on appearing. It slows down my system to unusable speed (e.g.: it takes approx 4 
minutes to shut the system down).

I think the devfs thingy triggers the "Disabling IRQ #18" problem when it tests for 
"existing" optical media drives on boot. I think so because the same message appears 
when i access cdroms manually.

I have no access to a second system with SATA support to verify or reproduce that 
behaviour, can anybody else do that on another machine? Also i'd be interested in how 
this problem could be tracked down to its root. I reproduced that with 2.6.0beta7 and 
beta8, the only kernels currently left on my machine ;)

thanks in advance for any hints
 HTD

p.s.: i'm not subscribed to lkml, please send me a CC when answering.

