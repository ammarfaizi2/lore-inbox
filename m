Return-Path: <linux-kernel-owner+w=401wt.eu-S932078AbWLaAMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWLaAMJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 19:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWLaAMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 19:12:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:11349 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbWLaAMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 19:12:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WQshNiWyPNWWppBk4NVmonDuZGJxwhJ2LDStEGXfZivadCNC2bqSMxr5RnP7tXdWLtR2yf0S9Wl8s3U/ryV+Ujw24XDNTTVPtWIppvqsfg6U2gQb0rb3CUoYgpxvHN3QFWEo82Oc1WmDk9kpRpxaOE+LXbit0MGEm+h9yCcv+yo=
Message-ID: <3aa654a40612301612g4702e2cs4fba5151170183b@mail.gmail.com>
Date: Sat, 30 Dec 2006 16:12:05 -0800
From: "Avuton Olrich" <avuton@gmail.com>
To: LMKL <linux-kernel@vger.kernel.org>
Subject: Device does not have a release() function
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please excuse me if this has already been discussed. Anything else
that's needed please let me know.

kernel: Linux version 2.6.20-rc2 (sbh@rocket) (gcc version 4.1.1
(Gentoo 4.1.1-r3)) #6 SMP PREEMPT Thu Dec 28 21:07:58 PST 2006

Spotted this in the dmesg:

---
Fixed PHY: Registered new driver
driver_bound: device fixed@100:1 already bound
Device 'fixed@100:1' does not have a release() function, it is broken
and must be fixed.
WARNING at /usr/src/linux-stable/drivers/base/core.c:104 device_release()
 [<c027bbf9>] kobject_cleanup+0x49/0x90
 [<c027bc40>] kobject_release+0x0/0x10
 [<c027c8ea>] kref_put+0x2a/0xa0
 [<c05762bc>] fixed_init+0x1bc/0x210
 [<c01003f0>] init+0x70/0x2a0
 [<c0102f82>] ret_from_fork+0x6/0x1c
 [<c0100380>] init+0x0/0x2a0
 [<c0100380>] init+0x0/0x2a0
 [<c0103c73>] kernel_thread_helper+0x7/0x14
 =======================
---

Sorry for all the links, but it's about 80K of info:

http://avuton.googlepages.com/config.txt
http://avuton.googlepages.com/cpuinfo.txt
http://avuton.googlepages.com/dmesg.txt
http://avuton.googlepages.com/lspci-vvv.txt
http://avuton.googlepages.com/proc-iomem.txt
http://avuton.googlepages.com/proc-ioports.txt
http://avuton.googlepages.com/ver_linux.txt
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
