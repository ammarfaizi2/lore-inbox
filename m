Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUHDAMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUHDAMk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 20:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUHDAMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 20:12:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11661 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266913AbUHDAMh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 20:12:37 -0400
Date: Tue, 3 Aug 2004 20:42:50 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org
Subject: Linux 2.4.27-rc5
Message-ID: <20040803234250.GB8083@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the fifth release candidate of kernel v2.4.27.

It includes a handful of XFS fixes, a network update (Bluetooth, Netfilter, 
bridge), it revert problematic DVD-RW support for now (should be back in 
2.4.28).

Most importantly this release fixes an exploitable race in file offset handling 
which allows unpriviledged users from potentially reading kernel memory.
This touches several drivers and generic proc code. This issue is covered by 
CAN-2004-0415.
Vendors should be releasing their updates real soon now. 

Here are the most important security issues fixed by the 2.4.27 release:

CAN-2004-0495 (Al Viro sparse fixes)
CAN-2004-0497 (users could modify group ID of arbitrary files on the system)
CAN-2004-0535 (e1000 minor info leak)
CAN-2004-0685 (backported Conectiva usb sparse fixes)
CAN-2004-0415 (file offset pointer handling race)
CAN-2004-0565 (information leak ia64)

-final should be out in a few days if nothing bad shows up. 

For more details please read the detailed changelog.

Summary of changes from v2.4.27-rc4 to v2.4.27-rc5
============================================

Adrian Bunk:
  o [NET]: Update CONFIG_NET_SCH_NETEM Configure.help entry

Chris Wright:
  o ethtool_get_regs copy right number of bytes to user

Eric Sandeen:
  o [XFS] Don't lock down user pages when doing direct IO; this can lead to trouble (double-locking zero page, etc).

Harald Welte:
  o [NETFILTER]: ipt_ULOG fix for packet delay
  o [NETFILTER]: Fix broken debug assertion

Marcel Holtmann:
  o [Bluetooth] Fix kernel panic when device config fails
  o [Bluetooth] Replace BCSP retransmitting message with BT_DBG
  o [Bluetooth] Fix resetting to default filters
  o [Bluetooth] Send HCI_Reset for ISSC USB dongles

Marcelo Tosatti:
  o Revert DVD-RW write support for now: axboe@suse.de|ChangeSet|20040606235035|46544
  o Cset exclude: axboe@suse.de|ChangeSet|20040607195639|57919
  o Remove mm/page_alloc.c debugging
  o Al Viro and others: Fix file offset handling races in several drivers
  o Changed EXTRAVERSION to -rc5
  o update-i386-defconfig.patch

Nathan Scott:
  o [XFS] Fix data loss problem - we no longer update i_size anywhere without holding i_sem for 2.4 as well.
  o [XFS] Fix diotest4 test case issues with direct reads in XFS

Ralf Bächle:
  o Fix non-use of HZ in 6pack.c

Stephen Hemminger:
  o bridge fix
  o [TCP]: Bic tcp congestion calculation timestamp
  o [PKT_SCHED]: netem limit not returned correctly

                                                                                

