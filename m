Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756772AbWKSQpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756772AbWKSQpU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 11:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756773AbWKSQpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 11:45:20 -0500
Received: from isilmar.linta.de ([213.239.214.66]:448 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1756772AbWKSQpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 11:45:19 -0500
Date: Sun, 19 Nov 2006 11:34:27 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: [git pull] PCMCIA fixes for 2.6.19-rc6
Message-ID: <20061119163427.GA2924@dominikbrodowski.de>
Mail-Followup-To: torvalds@osdl.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hej Linus,

Please pull from

	git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-fixes-2.6.git/

The diffstat and list of changes follows; the patches will be sent out to
the linux-pcmcia list and other relevant subsystem lists, if applicable.

Thanks,
	Dominik

----
 drivers/ata/pata_pcmcia.c       |    2 
 drivers/char/pcmcia/cm4000_cs.c |    6 -
 drivers/char/pcmcia/cm4040_cs.c |    6 -
 drivers/ide/legacy/ide-cs.c     |    2 
 drivers/pcmcia/cs.c             |    7 -
 drivers/pcmcia/cs_internal.h    |    2 
 drivers/pcmcia/ds.c             |  165 +++++++++++++++++++++++-----------------
 drivers/pcmcia/pcmcia_ioctl.c   |    7 +
 drivers/pcmcia/pd6729.c         |    8 -
 drivers/pcmcia/socket_sysfs.c   |    4 
 include/pcmcia/ss.h             |    5 -
 11 files changed, 125 insertions(+), 89 deletions(-)
----
Akinobu Mita (1):
      cm4000_cs: fix return value check

Dominik Brodowski (4):
      pcmcia: start over after CIS override
      pcmcia: multifunction card handling fixes
      pcmcia: fix 'rmmod pcmcia' with leftover devices
      pcmcia: handle __copy_from_user() return value in ioctl

Komuro (1):
      pcmcia: allow shared IRQs on pd6729 sockets

Marcin Juszkiewicz (1):
      pcmcia: yet another IDE ID

Matt Reimer (1):
      pcmcia: Add an id to ide-cs.c

