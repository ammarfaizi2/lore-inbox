Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312076AbSCTT0w>; Wed, 20 Mar 2002 14:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312059AbSCTT0m>; Wed, 20 Mar 2002 14:26:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25362 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312065AbSCTT0Z>;
	Wed, 20 Mar 2002 14:26:25 -0500
Message-ID: <3C98E230.4090403@mandrakesoft.com>
Date: Wed, 20 Mar 2002 14:25:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Linux kernel net-drivers-2.5.7-jg1
Content-Type: multipart/mixed;
 boundary="------------020904020308020708000906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020904020308020708000906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patch at:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.5.7/net-drivers-2.5.7-1.patch.bz2

Changeset and pull info follows.


--------------020904020308020708000906
Content-Type: text/plain;
 name="net-drivers-2.5.7-1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.5.7-1.txt"

Linus and other BK users, please do a

	bk pull http://gkernel.bkbits.net/net-drivers-2.5

This will update the following files:

 Documentation/networking/dl2k.txt  |    6 
 drivers/net/acenic.c               |   49 +--
 drivers/net/acenic.h               |    9 
 drivers/net/de620.c                |   15 -
 drivers/net/dl2k.c                 |  135 ++++++++--
 drivers/net/dl2k.h                 |    5 
 drivers/net/e100/Makefile          |    2 
 drivers/net/e100/e100.h            |   31 ++
 drivers/net/e100/e100_config.c     |   99 +++++++
 drivers/net/e100/e100_config.h     |    7 
 drivers/net/e100/e100_main.c       |  113 ++++++++
 drivers/net/e100/e100_test.c       |  467 +++++++++++++++++++++++++++++++++++++
 drivers/net/epic100.c              |   12 
 drivers/net/wireless/orinoco_plx.c |   25 +
 include/linux/ethtool.h            |   43 ++-
 15 files changed, 917 insertions(+), 101 deletions(-)

through these ChangeSets:

<jgarzik@mandrakesoft.com> (02/03/20 1.545)
   Revert epic100 net driver power sequence "fix", it broke some boards.

<k.kasprzak@box43.pl> (02/03/20 1.544)
   de620 net driver janitor fixes:
   * free_irq on error
   * check request_region error value

<jgarzik@mandrakesoft.com> (02/03/20 1.543)
   Merge orinoco_plx wireless driver pci ids from 2.4.x.

<jgarzik@mandrakesoft.com> (02/03/20 1.542)
   Merge dl2k gigabit ethernet driver update vendor:
   * add rio_timer to watch rx condition
   * move poll initiation to rx refill loop
   * use del_timer_sync to avoid race (me)
   * CodingStyle cleanups (me)

<jgarzik@mandrakesoft.com> (02/03/20 1.541)
   Add support file e100_test to e100 net driver.  Missed in earlier merge.

<jgarzik@mandrakesoft.com> (02/03/20 1.540)
   Merge ethtool initiate-nic-self-test ioctl, and support for it in e100 net drvr.
   
   Contributed by Eli Kupermann @ Intel, modified by me.

<eli.kupermann@intel.com> (02/03/20 1.539)
   e100 net driver update:
   
   1) This patch provides fix for "wake on arp" and "wake on unicast"
   functionality when card is suspended by power management. When e100_suspend
   was called for the device that is in netif_running state the load filter
   command was executed in the asynchronic mode and the order of actions
   required to put device into wake up enabled mode was broken.
   
   The fix enables to execute WOL configure and load filter commands in the
   synchronic mode despite of fact that device is in netif_running state. The
   exec_non_cu_command uses the driver_isolated flag to identify this
   situation. 
   
   2) add EXPORT_NO_SYMBOLS (yay Intel, you have come so far... :))
   
   3) bump version to 2.0.25-pre1

<jes@wildopensource.com> (02/03/15 1.473.4.15)
   acenic net driver update:
   * clean up vlan defines to dramatically reduce number of ifdefs
   * re-optimize private structure across cache line boundaries
   * fix typo(s) in printk/comments


--------------020904020308020708000906--

