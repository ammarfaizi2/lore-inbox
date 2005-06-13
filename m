Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVFMEDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVFMEDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 00:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVFMEDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 00:03:07 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:41188 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261362AbVFMEDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 00:03:03 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: linux-kernel@vger.kernel.org
Subject: Odd IDE performance drop 2.4 vs 2.6?
Date: Mon, 13 Jun 2005 14:03:01 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <ac0qa19omlt7bsh8mcfsfr2uhshk338f0c@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

A new 'old' box, with near 3:1 hdparm -Tt /dev/hda performance drop 
comparing 2.4.31 with 2.6.11.12. pII/266 on 440LX chipset. HDD set 
to udma2 (max for h/w) with manuf. utility.  Single master on ribbon.
CDROM on other ribbon.  Two runs each via ssh login soon after boot:

Linux 2.4.31-si.
root@silly:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   344 MB in  1.99 seconds = 172.86 MB/sec
 Timing buffered disk reads:   68 MB in  3.02 seconds =  22.52 MB/sec
root@silly:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   356 MB in  2.00 seconds = 178.00 MB/sec
 Timing buffered disk reads:   68 MB in  3.04 seconds =  22.37 MB/sec
root@silly:~#

Linux 2.6.11.12a.
root@silly:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   340 MB in  2.01 seconds = 168.76 MB/sec
 Timing buffered disk reads:   26 MB in  3.02 seconds =   8.60 MB/sec
root@silly:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   340 MB in  2.01 seconds = 169.26 MB/sec
 Timing buffered disk reads:   26 MB in  3.02 seconds =   8.61 MB/sec
root@silly:~#

Hardware info, configs, etc at http://scatter.mine.nu/test/boxen/silly/
--Grant.

