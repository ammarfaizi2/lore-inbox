Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268937AbUHMBwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268937AbUHMBwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 21:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268938AbUHMBwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 21:52:10 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:33670 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268937AbUHMBwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 21:52:05 -0400
Message-ID: <411C1EC0.3010302@embeddedintelligence.com>
Date: Thu, 12 Aug 2004 21:52:00 -0400
From: Stephen Glow <sglow@embeddedintelligence.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040726
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to generate hotplug events in drivers?
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I'm in the process of porting a device driver from the 2.4 kernel to the
2.6 kernel.  In the older version of the drivers I was using the devfs
system to create the device files.  I've decided to rip this out and
move everything to udev since this seems to be the preferred method now.

The problem I'm having with this port is that I can't get the udev
system to create a device file when I install the module.  As far as I
can tell, no hotplug events are being generated when I insmod the device
driver.  In other respects the driver seems to be loading correctly;
I'm able to request the PCI regions, enable, and start the PCI device,
and allocate a dynamic device major number.  I can also see an entry
create in the /sys/bus/pci/drivers directory.

The device in question is a PCI card of my own design.  Since my system
doesn't actually support hot plugging of PCI cards the card will be in
place from system boot.  Technically then, there is no hot plugging of a
new piece of hardware when I install the driver, the board has been
there since boot time.  Still, the device number has just been
allocated, so it's hard to see how a device file could have been created
before that time.

Should a hotplug event be generated when a new driver is installed for
an existing piece of hardware?

Is there something I need to do in my driver to explicitly generate a
hotplug event?

Please copy my e-mail address with responses.

Thanks,

Steve
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBHB7ADMBOo/wgA5QRApErAJ0TQMkGEQ9PmyAm1w5uxdFp30PIYACgyVqB
CzQz88Oy7P2vvK5n4SgOhUs=
=xEbx
-----END PGP SIGNATURE-----
