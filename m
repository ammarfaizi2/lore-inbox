Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbTC2WqG>; Sat, 29 Mar 2003 17:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261314AbTC2WqG>; Sat, 29 Mar 2003 17:46:06 -0500
Received: from 011.065.dsl.concepts.nl ([213.197.11.65]:63496 "EHLO
	d594e05b.dsl.concepts.nl") by vger.kernel.org with ESMTP
	id <S261296AbTC2WqF>; Sat, 29 Mar 2003 17:46:05 -0500
Subject: [patch/2.5.66] update of unified zoran driver
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, kraxel@bytesex.org
Content-Type: text/plain
Organization: 
Message-Id: <1048984516.1316.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 30 Mar 2003 01:35:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

http://mjpeg.sourceforge.net/driver-zoran/linux-zoran-driver.patch.gz
contains an update of the zoran driver to the current version in kernel
2.5.66. Changes (globally) to current kernel driver:

* support for video4linux2
* support for new videodev interface
* support for new i2c interface
* support for pinnacle/miro dc30/dc30+
* support for linux media labs lml33r10
* many bugfixes, additions, new features, bla, etc.
* this one actually compiles

Basically, it's quite uptodate to current kernel standards, as far as I
know (well, definately better than the zoran driver in the current
kernel, which doesn't even compile). A group of users has been testing
and improving it for some time now (on the mjpeg mailinglists), so I'm
quite happy with its current state. Supported cards:

* Iomega Buz
* Pinnacle/Miro DC10/DC10+
* Pinnacle/Miro DC30/DC30+
* Linux Media Labs LML33
* Linux Media Labs LML33R10

Unzipped patch is 720kB, the gzipped patch is 160kB (MD5SUM:
974db61765547c811d3298a284ed8221). Yeah, I know it's huge, the problem
(...) is that it contains a huge number of i2c client drivers and three
different codec modules. For each of these, it contains an update or a
completely new version (for the previously unsupported cards). All in
all, this makes the patch quite large. It basically only touches code
that was previously owned by our old driver too, though, apart from the
saa7110.c driver (owned by the also-broken zr36120 driver which still
needs updating to the new i2c stuff). Lastly, it touches some (unused)
I2C IDs (VPX32XX and ADV717X) and renames these to VPX3220 and ADV7175
to prevent naming confusion with the VPX3224 (module not finished yet,
so not in the patch) and ADV7170 (also in patch).

Anyone willing to take this beast? Gerd? Alan?

Thanks,

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

