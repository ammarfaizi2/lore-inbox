Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264185AbTKTBpY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 20:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbTKTBpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 20:45:24 -0500
Received: from jupiter.loonybin.net ([208.248.0.98]:1297 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S264185AbTKTBpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 20:45:20 -0500
Date: Wed, 19 Nov 2003 19:45:14 -0600
From: Zinx Verituse <zinx@epicsol.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] cuecat serio driver for linux 2.6.0-test9
Message-ID: <20031120014514.GA4573@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, my cuecat driver is ready for testing.

http://zinx.xmms.org/cuecat/cuecat-2.6-0.0.2.tar.gz

It does not use the same output format as the driver floating around
for 2.2.x/2.4.x kernels.

It currently requires a patch which changes the order serio drivers
are searched in (the newest driver is searched first now), and adds
a function to walk through the serio port list.

I'm hoping the patch will be included in to the kernel at some point
in time -- It's available separately at:
	http://zinx.xmms.org/cuecat/linux-2.6.0-test9-serio.diff

The driver has some pitfalls, such as standing between -all- serio
devices capable of supporting a cuecat, and not just the ones with
a cuecat on them (And it has no way to specify which ports to use),
but hopefully I'll think of a good way to fix that before 0.0.3.

The major number is dynamicly allocated -- If you aren't using devfs,
check /proc/devices.
The minor number for reading all cuecats is 0, and the minor number
for individual cuecats is their [driver-assigned] index plus 1.
Recommended names are:
	/dev/cuecat/cuecats
	/dev/cuecat/0
	/dev/cuecat/1
and so on.

Questions, comments, patches, and even some flames are welcome.

-- 
Zinx Verituse
