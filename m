Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263268AbSJJGqS>; Thu, 10 Oct 2002 02:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbSJJGqS>; Thu, 10 Oct 2002 02:46:18 -0400
Received: from [64.76.155.18] ([64.76.155.18]:44478 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S263268AbSJJGqR>;
	Thu, 10 Oct 2002 02:46:17 -0400
Date: Thu, 10 Oct 2002 02:51:59 -0400 (CLT)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: linux-kernel@vger.kernel.org
cc: kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH][CALL FOR TESTERS] [const] char declarations, 2.5.41 update
Message-ID: <Pine.LNX.4.44.0210100246190.19850-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've put another version of the patch for replacing *foo for foo[], it's 
located at: <http://alumno.inacap.cl/~rmaureira/chardef-2.5.41.diff>

Here is the diffstat

 arch/alpha/kernel/sys_nautilus.c           |   12 ++++++------
 arch/cris/drivers/axisflashmap.c           |    2 +-
 arch/cris/drivers/ethernet.c               |    2 +-
 arch/cris/drivers/lpslave/e100lpslavenet.c |    2 +-
 arch/cris/drivers/serial.c                 |    6 +++---
 arch/cris/drivers/usb-host.c               |    2 +-
 arch/ia64/tools/print_offsets.c            |    2 +-
 drivers/cdrom/sbpcd.c                      |   20 ++++++++++----------
 drivers/char/keyboard.c                    |    6 +++---
 drivers/hotplug/pci_hotplug_core.c         |    2 +-
 drivers/ide/ide.c                          |    4 ++--
 drivers/isdn/hisax/amd7930.c               |    2 +-
 drivers/isdn/hisax/asuscom.c               |    2 +-
 drivers/isdn/hisax/avm_a1.c                |    2 +-
 drivers/isdn/hisax/avm_a1p.c               |    2 +-
 drivers/isdn/hisax/avm_pci.c               |    2 +-
 drivers/isdn/hisax/bkm_a4t.c               |    2 +-
 drivers/isdn/hisax/callc.c                 |    2 +-
 drivers/isdn/hisax/diva.c                  |    2 +-
 drivers/isdn/hisax/elsa.c                  |    2 +-
 drivers/isdn/hisax/enternow_pci.c          |    2 +-
 drivers/isdn/hisax/gazel.c                 |    2 +-
 drivers/isdn/hisax/hfc_pci.c               |    2 +-
 drivers/isdn/hisax/hfc_sx.c                |    2 +-
 drivers/isdn/hisax/hfcscard.c              |    2 +-
 drivers/isdn/hisax/isdnl1.c                |    2 +-
 drivers/isdn/hisax/isdnl2.c                |    2 +-
 drivers/isdn/hisax/isdnl3.c                |    2 +-
 drivers/isdn/hisax/isurf.c                 |    2 +-
 drivers/isdn/hisax/ix1_micro.c             |    2 +-
 drivers/isdn/hisax/l3_1tr6.c               |    2 +-
 drivers/isdn/hisax/l3dss1.c                |    2 +-
 drivers/isdn/hisax/l3ni1.c                 |    2 +-
 drivers/isdn/hisax/mic.c                   |    2 +-
 drivers/isdn/hisax/netjet.c                |    2 +-
 drivers/isdn/hisax/niccy.c                 |    2 +-
 drivers/isdn/hisax/nj_s.c                  |    2 +-
 drivers/isdn/hisax/nj_u.c                  |    2 +-
 drivers/isdn/hisax/s0box.c                 |    2 +-
 drivers/isdn/hisax/sedlbauer.c             |    2 +-
 drivers/isdn/hisax/sportster.c             |    2 +-
 drivers/isdn/hisax/tei.c                   |    2 +-
 drivers/isdn/hisax/teleint.c               |    2 +-
 drivers/isdn/hisax/teles0.c                |    2 +-
 drivers/isdn/hisax/teles3.c                |    2 +-
 drivers/isdn/hisax/telespci.c              |    2 +-
 drivers/isdn/hisax/w6692.c                 |    2 +-
 drivers/md/multipath.c                     |    2 +-
 drivers/md/raid1.c                         |    2 +-
 drivers/md/raid5.c                         |    2 +-
 drivers/message/fusion/mptscsih.c          |    6 +++---
 drivers/net/appletalk/cops.c               |    2 +-
 drivers/net/e100/e100_main.c               |    2 +-
 drivers/net/irda/smc-ircc.c                |    2 +-
 drivers/net/irda/toshoboe.c                |    2 +-
 drivers/net/isa-skeleton.c                 |    2 +-
 drivers/net/ne2.c                          |    4 ++--
 drivers/net/ni5010.c                       |    4 ++--
 drivers/net/oaknet.c                       |    2 +-
 drivers/net/smc-ultra32.c                  |    2 +-
 drivers/net/tc35815.c                      |    2 +-
 drivers/net/tulip/de4x5.c                  |    2 +-
 drivers/net/wan/c101.c                     |    4 ++--
 drivers/net/wan/hdlc_generic.c             |    2 +-
 drivers/net/wan/n2.c                       |    4 ++--
 drivers/net/wan/sdla.c                     |    4 ++--
 drivers/pcmcia/cs.c                        |    4 ++--
 drivers/pnp/pnpbios_core.c                 |    2 +-
 drivers/s390/net/lcs.c                     |    2 +-
 drivers/s390/qdio.c                        |    2 +-
 drivers/sbus/char/bpp.c                    |    2 +-
 drivers/scsi/dmx3191d.c                    |    2 +-
 drivers/scsi/eata.c                        |    2 +-
 drivers/scsi/nsp32.c                       |    2 +-
 drivers/scsi/osst.c                        |    4 ++--
 drivers/scsi/scsi_debug.c                  |   10 +++++-----
 drivers/scsi/u14-34f.c                     |    2 +-
 drivers/usb/misc/speedtouch.c              |    2 +-
 drivers/usb/net/cdc-ether.c                |    2 +-
 drivers/video/aty128fb.c                   |    2 +-
 drivers/video/clgenfb.c                    |    2 +-
 drivers/video/fbcon.c                      |    2 +-
 drivers/video/promcon.c                    |    2 +-
 fs/ntfs/super.c                            |   10 +++++-----
 fs/reiserfs/procfs.c                       |    2 +-
 mm/slab.c                                  |    2 +-
 86 files changed, 122 insertions, 122 deletions

Again, I'll wait until weekend for breakage reports before starting to 
feed the small bits to the respective maintainers.

Best regards
-- 
Robinson Maureira Castillo
Asesor DAI
INACAP

