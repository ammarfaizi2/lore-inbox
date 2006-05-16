Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWEPVjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWEPVjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWEPVjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:39:15 -0400
Received: from ns1.suse.de ([195.135.220.2]:40398 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932138AbWEPVjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:39:13 -0400
Date: Tue, 16 May 2006 14:37:16 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] SPI patches for 2.6.17-rc4
Message-ID: <20060516213716.GA7972@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some patches for 2.6.17-rc4 for the SPI subsystem that have
been sitting langushing way too long in my tree and in the -mm tree.
They are all self-contained and fix some SPI issues and add a new SPI
driver.

They also name David Brownell as the SPI maintainer, and he'll handle
getting patches to you from now on (either through Andrew or directly,
they will work that out.)

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spi-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/spi-2.6.git/

The full patches will be sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 Documentation/spi/pxa2xx              |  234 +++++
 Documentation/spi/spi-summary         |   34 
 MAINTAINERS                           |    6 
 drivers/spi/Kconfig                   |    8 
 drivers/spi/Makefile                  |    1 
 drivers/spi/pxa2xx_spi.c              | 1467 ++++++++++++++++++++++++++++++++++
 drivers/spi/spi.c                     |    7 
 drivers/spi/spi_bitbang.c             |  104 +-
 include/asm-arm/arch-pxa/pxa2xx_spi.h |   68 +
 include/linux/spi/spi.h               |   45 -
 include/linux/spi/spi_bitbang.h       |    8 
 11 files changed, 1941 insertions(+), 41 deletions(-)

---------------

David Brownell:
      SPI: spi whitespace fixes
      SPI: spi bounce buffer has a minimum length
      SPI: devices can require LSB-first encodings
      SPI: busnum == 0 needs to work
      SPI: spi_bitbang: clocking fixes

Imre Deak:
      SPI: per-transfer overrides for wordsize and clocking

Kumar Gala:
      SPI: Add David as the SPI subsystem maintainer
      SPI: Renamed bitbang_transfer_setup to spi_bitbang_setup_transfer and export it

Stephen Street:
      SPI: add PXA2xx SSP SPI Driver
      spi: Update to PXA2xx SPI Driver

