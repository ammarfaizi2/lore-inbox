Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbUDBIVh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 03:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263360AbUDBIVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 03:21:34 -0500
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:58117 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S263355AbUDBIVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 03:21:32 -0500
Subject: 2.6.5-rc3-as1 patchset, cks5.2, cfq, aa1, and some wli
From: Antony Suter <sutera@internode.on.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1080894085.22675.0.camel@hikaru.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 02 Apr 2004 18:21:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is an update to my tidy set of patches. I was a fan of WLI's
patchset until he discontinued it in the 2.6.0-test era. They were a
small set of patches with performance improvements for laptops and NUMA
machines amongst others... (wish I had a laptop NUMA machine *cough*).
Some of those patches are now in the kernel proper. Some others have
been updated and are found elsewhere, like the objrmap series can be
found in Andrea Archangeli's -aa series. I'm starting to add some of the
other patches from WLI's last release, depending on my abolity to
resolve rejections. The numbers relate directly to those from
linux-2.6.0-test11-wli-1.tar.bz2

Patches were applied in the following order:
- Con Kolivas' new starcase cpu scheduler patch 5.2
- Jens Axboe's cfq io scheduler
- Andrea Archangeli's 2.6.5-rc3-aa2.bz2
< from linux-2.6.0-test11-wli-1 >
- #17 convert copy_strings() to use kmap_atomic() instead of kmap()
- #19 node-local i386 per_cpu areas
- #22 increase static vfs hashtable and VM array sizes
- #24 /proc/ BKL gunk plus page wait hashtable sizing adjustment
- #25 invalidate_inodes() speedup

Linqs:
http://www.users.on.net/sutera/2.6.5-rc3-as1.patch.gz
http://www.users.on.net/sutera/2.6.5-rc3-as1.patch.gz.sign

Note that to use the cfq scheduler to need to add "elevator=cfq" to your
kernel command line. This is usually done in your lilo or grub (or
equivalent) config.

-- 
- Antony Suter  (sutera internode on net)  "Bonta"
- "...through shadows falling, out of memory and time..."

