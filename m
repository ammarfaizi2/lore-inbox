Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWCaUfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWCaUfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWCaUfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:35:22 -0500
Received: from isilmar.linta.de ([213.239.214.66]:24535 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751410AbWCaUfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:35:07 -0500
Date: Fri, 31 Mar 2006 21:58:52 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [git pull] PCMCIA updates for 2.6.17
Message-ID: <20060331195852.GB27888@dominikbrodowski.de>
Mail-Followup-To: torvalds@osdl.org, akpm@osdl.org,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please pull from

	http://www.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git/

The diffstat and list of changes follows:

----
 Documentation/pcmcia/driver-changes.txt    |    6 
 drivers/bluetooth/bluecard_cs.c            |  119 ++-------
 drivers/bluetooth/bt3c_cs.c                |  130 +++-------
 drivers/bluetooth/btuart_cs.c              |  130 +++-------
 drivers/bluetooth/dtl1_cs.c                |  120 ++-------
 drivers/char/pcmcia/cm4000_cs.c            |  121 +++------
 drivers/char/pcmcia/cm4040_cs.c            |  133 +++-------
 drivers/char/pcmcia/synclink_cs.c          |  116 +++------
 drivers/ide/legacy/ide-cs.c                |  127 +++-------
 drivers/isdn/hardware/avm/avm_cs.c         |  185 ++++----------
 drivers/isdn/hisax/avma1_cs.c              |  182 ++++----------
 drivers/isdn/hisax/elsa_cs.c               |  110 +++-----
 drivers/isdn/hisax/sedlbauer_cs.c          |  143 +++--------
 drivers/isdn/hisax/teles_cs.c              |  119 +++------
 drivers/mtd/maps/pcmciamtd.c               |  115 +++------
 drivers/net/pcmcia/3c574_cs.c              |  115 +++------
 drivers/net/pcmcia/3c589_cs.c              |  122 +++------
 drivers/net/pcmcia/axnet_cs.c              |  126 +++-------
 drivers/net/pcmcia/com20020_cs.c           |  127 +++-------
 drivers/net/pcmcia/fmvj18x_cs.c            |  166 +++++--------
 drivers/net/pcmcia/ibmtr_cs.c              |  121 +++------
 drivers/net/pcmcia/nmclan_cs.c             |  126 +++-------
 drivers/net/pcmcia/pcnet_cs.c              |  161 +++++-------
 drivers/net/pcmcia/smc91c92_cs.c           |  235 ++++++++----------
 drivers/net/pcmcia/xirc2ps_cs.c            |  185 ++++++--------
 drivers/net/wireless/airo_cs.c             |  158 +++---------
 drivers/net/wireless/atmel_cs.c            |  162 ++++--------
 drivers/net/wireless/hostap/hostap_cs.c    |  200 ++++++---------
 drivers/net/wireless/netwave_cs.c          |  127 +++-------
 drivers/net/wireless/orinoco_cs.c          |  189 +++++----------
 drivers/net/wireless/ray_cs.c              |  277 ++++++++--------------
 drivers/net/wireless/ray_cs.h              |    2 
 drivers/net/wireless/spectrum_cs.c         |  173 +++++--------
 drivers/net/wireless/wavelan_cs.c          |  189 +++++----------
 drivers/net/wireless/wavelan_cs.p.h        |    6 
 drivers/net/wireless/wl3501.h              |    1 
 drivers/net/wireless/wl3501_cs.c           |  178 ++++----------
 drivers/parport/parport_cs.c               |  129 ++--------
 drivers/pcmcia/Kconfig                     |    7 
 drivers/pcmcia/Makefile                    |    3 
 drivers/pcmcia/at91_cf.c                   |  365 +++++++++++++++++++++++++++++
 drivers/pcmcia/cistpl.c                    |    1 
 drivers/pcmcia/cs.c                        |   43 +--
 drivers/pcmcia/cs_internal.h               |   19 -
 drivers/pcmcia/ds.c                        |  249 ++++++++++++-------
 drivers/pcmcia/ds_internal.h               |    4 
 drivers/pcmcia/i82092.c                    |    1 
 drivers/pcmcia/i82365.c                    |    1 
 drivers/pcmcia/pcmcia_compat.c             |   65 -----
 drivers/pcmcia/pcmcia_ioctl.c              |   81 ++++--
 drivers/pcmcia/pcmcia_resource.c           |  224 +++++++++--------
 drivers/pcmcia/pd6729.c                    |    1 
 drivers/pcmcia/rsrc_mgr.c                  |    5 
 drivers/pcmcia/rsrc_nonstatic.c            |   41 +--
 drivers/pcmcia/sa1100_cerf.c               |    1 
 drivers/pcmcia/socket_sysfs.c              |   10 
 drivers/pcmcia/ti113x.h                    |    1 
 drivers/scsi/pcmcia/aha152x_stub.c         |  112 ++------
 drivers/scsi/pcmcia/fdomain_stub.c         |  149 ++++-------
 drivers/scsi/pcmcia/nsp_cs.c               |  136 +++-------
 drivers/scsi/pcmcia/nsp_cs.h               |    8 
 drivers/scsi/pcmcia/qlogic_stub.c          |  127 +++-------
 drivers/scsi/pcmcia/sym53c500_cs.c         |  124 +++------
 drivers/serial/serial_cs.c                 |  229 ++++++++----------
 drivers/telephony/ixj_pcmcia.c             |  119 ++-------
 drivers/usb/host/sl811_cs.c                |  119 ++-------
 include/asm-arm/arch-at91rm9200/hardware.h |    3 
 include/pcmcia/bulkmem.h                   |    4 
 include/pcmcia/ciscode.h                   |    5 
 include/pcmcia/cistpl.h                    |   21 +
 include/pcmcia/cs.h                        |   34 +-
 include/pcmcia/ds.h                        |   80 +++---
 include/pcmcia/ss.h                        |   11 
 sound/pcmcia/pdaudiocf/pdaudiocf.c         |   86 +-----
 sound/pcmcia/pdaudiocf/pdaudiocf.h         |    2 
 sound/pcmcia/vx/vxpocket.c                 |   94 ++-----
 sound/pcmcia/vx/vxpocket.h                 |    2 
 77 files changed, 3150 insertions(+), 4568 deletions(-)


----
Adrian Bunk:
      pcmcia: make pcmcia_release_{io,irq} static

Andrew Victor:
      pcmcia: AT91RM9200 Compact Flash driver

Domen Puncer:
      serial_cs: add Merlin U630 IDs

Dominik Brodowski:
      pcmcia: remove unused field Present from config_t
      pcmcia: access config_t using pointer instead of array
      pcmcia: always use device pointer to config_t
      pcmcia: make config_t independent, add reference counting
      pcmcia: remove unused defines
      pcmcia: use mutexes instead of semaphores
      pcmcia: remove include of config.h
      pcmcia: remove pcmcia_compat.c
      pcmcia: size reduction if ioctl isn't compiled
      pcmcia: remove duplicate fields in io_window_t
      parport_cs: don't play games with resources
      pcmcia: socket.functions starts with 1
      pcmcia: add pcmcia_disable_device
      pcmcia: convert remaining users of pcmcia_release_io and _irq
      pcmcia: default suspend and resume handling
      pcmcia: remove export of pcmcia_release_configuration
      pcmcia: remove unneeded Vcc pseudo setting
      pcmcia: rename pcmcia_device.state
      pcmcia: embed dev_link_t into struct pcmcia_device
      pcmcia: remove dev_link_t and client_handle_t indirection
      pcmcia: add return value to _config() functions
      pcmcia: remove unused p_dev->state flags
      pcmcia: use bitfield instead of p_state and state
      pcmcia: convert DEV_OK to pcmcia_dev_present
      pcmcia: pseudo device handling update

Hugh Dickins:
      pcmcia: fix pcmcia_device_remove oops

Janos Farkas:
      pcmcia: permit single-character identifiers

Komuro:
      pcmcia: remove wrong comment in ciscode.h

Marcelo Tosatti:
      pcmcia: declare pccard_iodyn_ops (fix m8xx_pcmcia.c compilation error)

Petr Vandrovec:
      pcmcia: Add support for Possio GCC AKA PCMCIA Siemens MC45


All patches are available using the git web interface at
http://kernel.org/git/ and all but the largest ones (19, 21, 23, 24, 25
and 28) will be posted to the linux-pcmcia mailing list; all patches
affecting other subsystems or drivers will be sent to the specific lists or
(at least) to lkml.

	Dominik
