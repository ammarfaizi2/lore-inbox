Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967021AbWKZAOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967021AbWKZAOM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 19:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935216AbWKZAOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 19:14:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47374 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S935213AbWKZAOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 19:14:10 -0500
Date: Sun, 26 Nov 2006 01:14:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.34-rc1
Message-ID: <20061126001413.GA15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New drivers since 2.6.16.33:
- Echoaudio sound drivers
- driver for HighPoint RocketRAID 3xxx Controllers
- AdvanSys SCSI driver (actually the semi-working driver that was
                        previously marked as broken)


Patch location:
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/linux-2.6.16.y/testing/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.33:

Adrian Bunk (2):
      update the OBSOLETE_OSS_DRIVER help text
      Linux 2.6.16.34-rc1

Al Viro (1):
      [IPX]: Annotate and fix IPX checksum

Alan Stern (1):
      USB: UHCI: Increase port-reset completion delay for HP controllers

Alexey Dobriyan (2):
      i2c-ixp4xx: fix ") != 0))" typo
      [IPX]: Correct return type of ipx_map_frame_type().

Christoph Hellwig (1):
      [SCSI] hptiop: backout ioctl mess

Dave Jones (1):
      [SCSI] advansys pci tweaks.

David L Stevens (1):
      [IGMP]: Fix IGMPV3_EXP() normalization bit shift value.

David S. Miller (1):
      [IPX]: Fix typo, ipxhdr() --> ipx_hdr()

Giuliano Pochini pochini@shiny.it (1):
      [ALSA] Add echoaudio sound drivers

Hidetoshi Seto (1):
      sysfs: remove duplicated dput in sysfs_update_file

HighPoint Linux Team (3):
      [SCSI] hptiop: HighPoint RocketRAID 3xxx controller driver
      [SCSI] hptiop: HighPoint RocketRAID 3xxx controller driver
      [SCSI] hptiop: wrong register used in hptiop_reset_hba()

James Bottomley (1):
      [SCSI] hptiop: don't use cmnd->bufflen

Jean Delvare (1):
      Fix i2c-ixp4xx compilation breakage

Kirill Korotaev (1):
      fix sys_getppid oopses on debug kernel

Linus Torvalds (1):
      [SCSI] advansys driver: limp along on x86

Mark M. Hoffman (1):
      i2c: Handle i2c_add_adapter failure in i2c algorithm drivers

Randy Dunlap (1):
      advansys section fixes

Stephen Hemminger (2):
      [IPX]: Header length validation needed
      [IPX]: Another nonlinear receive fix

Steve French (1):
      CIFS: report rename failure when target file is locked by Windows

Takashi Iwai (3):
      [ALSA] Fix a typo in echoaudio/midi.c
      [ALSA] echoaudio - Fix Makefile
      [ALSA] echoaudio - Remove kfree_nocheck()


 Documentation/scsi/hptiop.txt                   |   92 
 Documentation/sound/alsa/ALSA-Configuration.txt |   96 
 MAINTAINERS                                     |    6 
 Makefile                                        |    2 
 drivers/i2c/algos/i2c-algo-bit.c                |    3 
 drivers/i2c/algos/i2c-algo-ite.c                |    4 
 drivers/i2c/algos/i2c-algo-pca.c                |    6 
 drivers/i2c/algos/i2c-algo-pcf.c                |    8 
 drivers/i2c/algos/i2c-algo-sibyte.c             |    4 
 drivers/i2c/busses/i2c-ixp4xx.c                 |    3 
 drivers/scsi/Kconfig                            |   14 
 drivers/scsi/Makefile                           |    1 
 drivers/scsi/advansys.c                         |   98 
 drivers/scsi/hptiop.c                           |  943 ++++++
 drivers/scsi/hptiop.h                           |  465 +++
 drivers/usb/host/uhci-hub.c                     |   21 
 fs/cifs/inode.c                                 |   14 
 fs/sysfs/file.c                                 |    5 
 include/linux/igmp.h                            |    2 
 include/net/ipx.h                               |    4 
 kernel/timer.c                                  |   41 
 net/ipx/af_ipx.c                                |   45 
 net/ipx/ipx_route.c                             |    4 
 sound/oss/Kconfig                               |    7 
 sound/pci/Kconfig                               |  137 
 sound/pci/Makefile                              |    1 
 sound/pci/echoaudio/Makefile                    |   30 
 sound/pci/echoaudio/darla20.c                   |   99 
 sound/pci/echoaudio/darla20_dsp.c               |  125 
 sound/pci/echoaudio/darla24.c                   |  106 
 sound/pci/echoaudio/darla24_dsp.c               |  156 +
 sound/pci/echoaudio/echo3g.c                    |  118 
 sound/pci/echoaudio/echo3g_dsp.c                |  131 
 sound/pci/echoaudio/echoaudio.c                 | 2196 ++++++++++++++++
 sound/pci/echoaudio/echoaudio.h                 |  590 ++++
 sound/pci/echoaudio/echoaudio_3g.c              |  431 +++
 sound/pci/echoaudio/echoaudio_dsp.c             | 1125 ++++++++
 sound/pci/echoaudio/echoaudio_dsp.h             |  694 +++++
 sound/pci/echoaudio/echoaudio_gml.c             |  198 +
 sound/pci/echoaudio/gina20.c                    |  103 
 sound/pci/echoaudio/gina20_dsp.c                |  215 +
 sound/pci/echoaudio/gina24.c                    |  123 
 sound/pci/echoaudio/gina24_dsp.c                |  346 ++
 sound/pci/echoaudio/indigo.c                    |  104 
 sound/pci/echoaudio/indigo_dsp.c                |  170 +
 sound/pci/echoaudio/indigodj.c                  |  104 
 sound/pci/echoaudio/indigodj_dsp.c              |  170 +
 sound/pci/echoaudio/indigoio.c                  |  105 
 sound/pci/echoaudio/indigoio_dsp.c              |  141 +
 sound/pci/echoaudio/layla20.c                   |  112 
 sound/pci/echoaudio/layla20_dsp.c               |  290 ++
 sound/pci/echoaudio/layla24.c                   |  121 
 sound/pci/echoaudio/layla24_dsp.c               |  394 ++
 sound/pci/echoaudio/mia.c                       |  117 
 sound/pci/echoaudio/mia_dsp.c                   |  229 +
 sound/pci/echoaudio/midi.c                      |  327 ++
 sound/pci/echoaudio/mona.c                      |  129 
 sound/pci/echoaudio/mona_dsp.c                  |  428 +++
 58 files changed, 11619 insertions(+), 134 deletions(-)
