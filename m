Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317820AbSFSJCX>; Wed, 19 Jun 2002 05:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317821AbSFSJCW>; Wed, 19 Jun 2002 05:02:22 -0400
Received: from revdns.flarg.info ([213.152.47.19]:14539 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S317820AbSFSJCV>;
	Wed, 19 Jun 2002 05:02:21 -0400
Date: Wed, 19 Jun 2002 10:02:48 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: /proc/partitions broken in 2.5.23
Message-ID: <20020619090248.GA8681@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a bug report about an issue with LVM in 2.5.22-dj1, which turns
out to be caused by broken /proc/partitions in mainline.

(davej@mesh:davej)$ cat /proc/partitions 
major minor  #blocks  name

   8     0          0 sda
  22     0 1515870810 hdc
  22    64 1515870810 hdd
   3     0   29316672 hda
   3     1     117400 hda1
   3     2          1 hda2
   3     5     999904 hda5
   3     6    1499872 hda6
   3     7     683392 hda7
   3     8   26015944 hda8
   3    64 1515870810 hdb

Note the huge numbers in hex are 0x5a5a5a5a, so something
seems to be getting poisoned somewhere.

Also, should partitions with 0 blocks be showing up ?
I don't recall that happening with the old-style 2.4 code.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
