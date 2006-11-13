Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933085AbWKMVpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933085AbWKMVpH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933086AbWKMVpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:45:06 -0500
Received: from l8r.net ([206.248.172.29]:6083 "EHLO l8r.net")
	by vger.kernel.org with ESMTP id S933085AbWKMVpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:45:05 -0500
Date: Mon, 13 Nov 2006 16:45:07 -0500
From: Brad Barnett <lists@l8r.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: root NFS causes solid lockup, serial console no help, watchdog NMI
 won't function on Dual AMD system
Message-ID: <20061113164507.5a6430e9@be.back.l8r.net>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

I have a couple of dual AMD Opteron system with differing motherboards. 
On both of these differing pieces of hardware, I can not enable the NMI
watchdog timer, with nmi_watchdog=1.  I constantly get:

testing NMI watchdog ... CPU#0: NMI appears to be stuck (0->0)!

This happens when booting with both Debian's packaged kernels, 2.6.17-2
and 2.6.18-2.  According to this page:

http://www.mjmwired.net/kernel/Documentation/nmi_watchdog.txt

nmi_watchdog=2 does not work with AMD systems at this time.

Both boxes, aside from this, boot fine.  They use nfsroot, booting the
kernel off of a local drive, and switching to nfsroot during the bootup. 
They work flawlessly for anywhere from a week to a few days, then lock up
solid.  I can not seem to reproduce this problem unless I am using
nfsroot, and the above kernels seem fine without issue when booting and
running off of a local drive.

I can not get any information from a serial console, and just for fun I
redirected syslog to another box, yet I did not see anything about the
impending doom to come.  The console itself is simply a blank screen, and
the keyboard is dead... 

Does anyone have any suggestions for tracking this bug down?

Thanks

