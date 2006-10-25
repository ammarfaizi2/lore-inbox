Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423203AbWJYKUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423203AbWJYKUn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 06:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423204AbWJYKUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 06:20:43 -0400
Received: from attila.bofh.it ([213.92.8.2]:11978 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S1423203AbWJYKUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 06:20:42 -0400
Date: Wed, 25 Oct 2006 12:20:30 +0200
To: linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Cc: Greg KH <greg@kroah.com>
Subject: major 442
Message-ID: <20061025102030.GA5790@wonderland.linux.it>
Mail-Followup-To: md@Linux.IT, linux-kernel@vger.kernel.org,
	debian-kernel@lists.debian.org, Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed the Debian 2.6.18 kernel package and I noticed that it
repeatedly tries to load a major 442 module alias, which appears to be
used by the usb_endpoint devices.
Does anybody know why? I am not even using the USB ports.

md@bongo:~$uname -a
Linux bongo 2.6.18-1-686 #1 SMP Sat Oct 21 17:21:28 UTC 2006 i686 GNU/Linux
md@bongo:~$while sleep 0.1; do ps axf|grep modprob[e]; done
 6424 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442_2049
 6429 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442_2049
 6438 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442
 6447 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442_2048
 6460 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442
 6473 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442_8192
 6487 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442
 6500 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442_0
 6517 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442
 6557 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442_4096
 6562 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442_4096
 6571 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442
 6582 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442
 6595 ?        R<     0:00      \_ /sbin/modprobe -q -- char_major_442_2051
[...]

-- 
ciao,
Marco
