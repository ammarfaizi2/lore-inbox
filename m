Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVBFOFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVBFOFj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 09:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVBFOFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 09:05:39 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:24501 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261234AbVBFOFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 09:05:01 -0500
Date: Sun, 6 Feb 2005 15:03:05 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] ide-2.6 update
Message-ID: <Pine.GSO.4.58.0502061456470.18367@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This time two small bugfixes and removal of drivers/ide/pci/*.h.

Bartlomiej

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/pci/aec62xx.h      |  122 ----------
 drivers/ide/pci/cmd64x.h       |   95 --------
 drivers/ide/pci/cy82c693.h     |   83 -------
 drivers/ide/pci/generic.h      |  120 ----------
 drivers/ide/pci/hpt366.h       |  483 -----------------------------------------
 drivers/ide/pci/it8172.h       |   31 --
 drivers/ide/pci/opti621.h      |   28 --
 drivers/ide/pci/pdc202xx_new.h |  118 ----------
 drivers/ide/pci/pdc202xx_old.h |  144 ------------
 drivers/ide/pci/piix.h         |   62 -----
 drivers/ide/pci/serverworks.h  |   69 -----
 drivers/ide/ide-lib.c          |    3
 drivers/ide/ide-probe.c        |    3
 drivers/ide/pci/aec62xx.c      |  104 ++++++++
 drivers/ide/pci/cmd64x.c       |   84 +++++++
 drivers/ide/pci/cy82c693.c     |   71 +++++-
 drivers/ide/pci/generic.c      |   90 +++++++
 drivers/ide/pci/hpt366.c       |  435 ++++++++++++++++++++++++++++++++++++
 drivers/ide/pci/it8172.c       |   14 +
 drivers/ide/pci/opti621.c      |   20 +
 drivers/ide/pci/pdc202xx_new.c |  106 ++++++++
 drivers/ide/pci/pdc202xx_old.c |  129 ++++++++++
 drivers/ide/pci/piix.c         |   48 +++-
 drivers/ide/pci/serverworks.c  |   51 ++++
 include/linux/ide.h            |   14 -
 25 files changed, 1131 insertions(+), 1396 deletions(-)

through these ChangeSets:

<tj@home-tj.org> (05/02/06 1.2136)
   [ide] remove unused pkt_task_t definition from ide.h

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2135)
   [ide serverworks] merge serverworks.h into serverworks.c

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2134)
   [ide serverworks] remove unused SVWKS_DEBUG_DRIVE_INFO

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2133)
   [ide piix] merge piix.h into piix.c

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/02/06 1.2132)
   [ide piix] remove useless comment

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2131)
   [ide pdc202xx_old] merge pdc202xx_old.h into pdc202xx_old.c

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2130)
   [ide pdc202xx_old] remove SPLIT_BYTE() macro

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2129)
   [ide pdc202xx_new] merge pdc202xx_new.h into pdc202xx_new.c

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2128)
   [ide opti621] merge opti621.h into opti621.c

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2127)
   [ide it8172] merge it8172.h into it8172.c

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2126)
   [ide hpt366] merge hpt366.h into hpt366.c

   bart: while at it do whitespace cleanup and add missing FIXME

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/02/06 1.2125)
   [ide hpt366] remove dead fifty_base_hpt374[] table

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2124)
   [ide pci generic] merge generic.h into generic.c

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/02/06 1.2123)
   [ide pci generic] remove dummy init_chipset_generic()

   ->init_chipset is optional

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/02/06 1.2122)
   [ide pci generic] remove dead unknown_chipset[] table from generic.h

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2121)
   [ide cy82c693] merge cy82c693.h into cy82c693.c

   bart: do small whitespace cleanup while at it

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2120)
   [ide cmd64x] merge cmd64x.h into cmd64x.c

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2119)
   [ide aec62xx] merge aec62xx.h into aec62xx.c

   bart: s/byte/u8/

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/06 1.2118)
   [ide aec62xx] remove SPLIT_BYTE() and MAKE_WORD() macros

   bart: leave BUSCLOCK() alone for now

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<viro@parcelfarce.linux.theplanet.co.uk> (05/02/06 1.2117)
   [ide] fix ide_dump_atapi_status()

   From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

   On Fri, 4 Feb 2005, Al Viro wrote:

   > BTW, ide-lib.c code that triggers the ICE happens to be completely broken.
   > Jens, it's your patch from September 2002 - what used to be
   >        if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
   > became
   >        if ((status.all & (status.b.bsy|status.b.check)) == status.b.check) {
   > and that's *not* an equivalent transformation.  Fixing it doesn't get rid
   > of ICE, but it certainly deserves fixing.

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<khali@linux-fr.org> (05/02/06 1.2116)
   [ide] fix hwif_init() to not return error for "empty" interfaces

   Return success if no device is connected to the interface.

   Signed-off-by: Jean Delvare <khali@linux-fr.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

