Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVAGNiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVAGNiD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 08:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVAGNhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 08:37:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64744 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261409AbVAGNha convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 08:37:30 -0500
Date: Fri, 7 Jan 2005 08:49:13 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.29-rc1
Message-ID: <20050107104913.GD29176@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the first release canditate of v2.4.29.

This time it contains a SATA update, bunch of network drivers updates, amongst
others.

More importantly it fixes a sys_uselib() vulnerability discovered by Paul Starzetz:

CAN-2004-1235
http://isec.pl/vulnerabilities/isec-0021-uselib.txt

Upgrade is recommended for users of v2.4.x mainline, distros should be releasing 
their updates real soon now.

Summary of changes from v2.4.29-pre3 to v2.4.29-rc1
============================================

<a.pugachev:pcs-net.net>:
  o drivers/net/appletalk/Config.in depends on CONFIG_ATALK

<albertcc:tw.ibm.com>:
  o [libata] use PIO mode for request sense
  o [libata] PIO error handling improvement
  o [libata] verify ATAPI DMA for a given request is OK

<gortan:tttech.com>:
  o 8139cp: support for TTTech MC322

<jason.d.gaston:intel.com>:
  o SATA support for Intel ICH7

<mbellon:mvista.com>:
  o 32 bit ltrace oops when tracing 64 bit executable [X86_64]

<mhw:wittsend.com>:
  o Computone driver update

<penguin:muskoka.com>:
  o 8390 Tx fix for non i386

<stkn:gentoo.org>:
  o [libata] add #include (fixes 2.4 alpha build)

Don Fry:
  o pcnet32: added pci_disable_device

Ganesh Venkatesan:
  o e1000: ITR does not default correctly on 2.4.x kernels
  o e1000: Fix for kernel panic when the interface is brought down while the NAPI enabled driver is under stress
  o e1000: Fix ethtool diagnostics -- specifically for blade server implementations
  o e1000: Enabling NETIF_F_SG without checksum offload is illegal
  o e1000: remove a redundant assignment to a local nr_frags in e1000_xmit_frame
  o e1000: Synchronizing multicast table setup with transmit path - ak@suse.de
  o e1000: fix tx resource cleanup logic
  o e1000: {set, get}_wol is now symmetric for 82545EM adapters
  o e1000: Sparse cleanup - shemminger@osdl.org
  o e1000: Added workaround to prevent inadvertent gigabit waveform to be sent out on the wire due to init-time operations on the IGP phy.
  o e1000:  Applied eeprom fix where it was possible to read/write
  o e1000:  Applied smart speed fix where the code was forcing smart speed on all the time.  Now it will honor the setting defined in the eeprom.
  o e1000: Driver version number, white spaces, comments, device id & other changes
  o e1000: Documentation/networking/e1000.txt update

Ian Kent:
  o autofs4 add missing compat ioctls

Jean Delvare:
  o I2C: Cleanup a couple media/video drivers

Jeff Garzik:
  o [libata sata_nv] fix dev detect by removing sata-reset flag
  o [libata sata_uli] add 5281 support, fix SATA phy setup for others

Marcelo Tosatti:
  o Changed VERSION to 2.4.29-rc1
  o Paul Starzetz: sys_uselib() race vulnerability  (CAN-2004-1235)

Margit Schubert-While:
  o prism54 sync with 2.6
  o prism54 fix resume processing
  o prism54 sparse fixes

Paul Mackerras:
  o PPC64 signal code cleanup

Pete Zaitcev:
  o USB: Add user defined IDs to ftdi

Ralf Bächle:
  o MIPS network drivers
  o NE2000 on Toshiba RBTX4927 fixes

Solar Designer:
  o Check for zero program header on load_elf_interp()

