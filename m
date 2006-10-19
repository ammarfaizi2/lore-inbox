Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946170AbWJSQGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946170AbWJSQGl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946159AbWJSQGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:06:39 -0400
Received: from webserve.ca ([69.90.47.180]:49082 "EHLO computersmith.org")
	by vger.kernel.org with ESMTP id S1946156AbWJSQGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:06:30 -0400
Message-ID: <4537A25D.6070205@wintersgift.com>
Date: Thu, 19 Oct 2006 09:05:49 -0700
From: teunis <teunis@wintersgift.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: various laptop nagles - any suggestions?   (note: 2.6.19-rc2-mm1
 but applies to multiple kernels)
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Setting the internal clock to 100 Hz stablizes the laptop - and the
synaptics touchpad stops "crashing"  (when "crashed" the pad reads out
all kinds of seemingly random values).   I would suspect the driver
needs adjusting for the variable clock.   Also - it's definitely nicer
on the laptop power use as far as I can tell - should this be in the
documentation?

I'm very grateful that compact flash-based booting on a SATA system
works well.   It hasn't been so reliable in 2.6.19-rc2-mm1 for IDE/CF
adaptors but I haven't yet solved why.   (tested with various laptops)

resume from "suspend to ram" (ACPI S3 mode) - the keyboard and mouse do
not recover on 945G chipset.   Note that otherwise the chipset works
well in 2.6.19-rc2-mm1 - and this is the first kernel that does work well).

LVM2 - when adding and removing physical volumes (again, on Compact
Flash cards via USB and Firewire adaptors) - it doesn't always remove
the volume properly (pvremove /dev/sda or equiv) from the device-mapper.
 This leaves me unable to plug in another.   I suspect this to be an
LVM2 problem (no hotplug?) rather than a compact flash or SCSI problem.

I would debug - but I'm not yet sure where to begin.   Feel free to
offer suggestions (to my mailbox directly - I've waited for two weeks to
post as I don't want to add noise to the kernel list)

oh - my job involves working with these systems
Thank you for everything!
	- Teunis Peters
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFN6JcbFT/SAfwLKMRAkDeAJ94FC1Zy0mS+y4jXpNHGSPIpGvc2QCfYl+D
oxLqfgqj0GUKOD/7iRXUPfs=
=6Gjc
-----END PGP SIGNATURE-----
