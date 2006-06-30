Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWF3USA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWF3USA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 16:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWF3USA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 16:18:00 -0400
Received: from isilmar.linta.de ([213.239.214.66]:39328 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750923AbWF3UR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 16:17:59 -0400
Date: Fri, 30 Jun 2006 22:17:52 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org
Subject: [git pull] PCMCIA updates and fixes for 2.6.18
Message-ID: <20060630201752.GA9978@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[fwd to linux-kernel]

Linus,

The PCMCIA updates for 2.6.18 are available at

	git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-2.6/

Please pull from that location. The diffstat and list of changes follows,
the individual diffs are sent (at least) to the linux-pcmcia list.

Thanks,
	Dominik

----
 Documentation/pcmcia/crc32hash.c        |   32 ++++++++++++
 Documentation/pcmcia/devicetable.txt    |   36 +------------
 drivers/char/pcmcia/cm4000_cs.c         |    7 --
 drivers/ide/legacy/ide-cs.c             |   81 +++++++++++++++++++++++++++----
 drivers/net/pcmcia/com20020_cs.c        |    5 +
 drivers/net/wireless/hostap/hostap_cs.c |    2 
 drivers/pcmcia/at91_cf.c                |   75 ++++++++++++++++++++++------
 drivers/pcmcia/au1000_db1x00.c          |    2 
 drivers/pcmcia/cs.c                     |   29 ++++++-----
 drivers/pcmcia/pcmcia_resource.c        |   27 ++++++----
 drivers/pcmcia/ti113x.h                 |    1 
 drivers/pcmcia/yenta_socket.c           |   83 +++++++++++++++++++++++++++++++-
 drivers/serial/serial_cs.c              |    1 
 include/linux/pci_ids.h                 |    1 
 14 files changed, 291 insertions(+), 91 deletions(-)
----
Al Viro:
      kill open-coded offsetof in cm4000_cs.c ZERO_DEV()

Alan Cox:
      pcmcia: warn if driver requests exclusive, but gets a shared IRQ

Alex Williamson:
      pcmcia: TI PCIxx12 CardBus controller support

Arjan van de Ven:
      pcmcia: fix deadlock in pcmcia_parse_events

Bernhard Kaindl:
      yenta: fix hidden PCI bus numbers

Daniel Ritz:
      yenta: do power-up only after socket is configured

David Brownell:
      pcmcia: at91_cf suspend/resume/wakeup

Domen Puncer:
      au1xxx: pcmcia: fix __init called from non-init

Dominik Brodowski:
      pcmcia: another ID for serial_cs.c

Komuro:
      pcmcia: hostap_cs.c - 0xc00f,0x0000 conflicts with pcnet_cs

Marc Sowen:
      com20020_cs: more device support

Randy Dunlap:
      pcmcia: expose tool in pcmcia/Documentation/pcmcia/
      pcmcia: fix kernel-doc function name

Serge E. Hallyn:
      pcmcia: convert pcmcia_cs to kthread

Thomas Kleffel:
      pcmcia: Make ide_cs work with the memory space of CF-Cards if IO space is not available

