Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965421AbWI1NbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965421AbWI1NbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWI1NbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:31:23 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:38630 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751888AbWI1NbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:31:22 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 0/4] More atmel_serial updates
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 28 Sep 2006 15:31:38 +0200
Message-Id: <11594503023218-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now that Andrew Victor seems to be happy about the renaming (thanks
a lot for reviewing, Andrew), here are a few more patches to make
atmel_serial usable for AVR32, as well as a general bugfix.

I've dropped the break fix for now, as it doesn't seem to work on
my AT91RM9200-EK board. I'll see if I can fix it properly later --
it's not really a showstopper, for me anyway.

There's also a pure AVR32 patch in this set. Feel free to ignore it,
but I thought I'd include it so that you can see the whole picture.

Shortlog and diffstat for the whole series follows.

Haavard

Haavard Skinnemoen:
      atmel_serial: Pass fixed register mappings through platform_data
      atmel_serial: Support AVR32
      AVR32: Allow renumbering of serial devices
      atmel_serial: Fix roundoff error in atmel_console_get_options

 arch/arm/mach-at91rm9200/devices.c      |    1 +
 arch/avr32/boards/atstk1000/atstk1002.c |   16 ++++++++-
 arch/avr32/kernel/setup.c               |    1 +
 arch/avr32/mach-at32ap/at32ap.c         |    3 --
 arch/avr32/mach-at32ap/at32ap7000.c     |   53 +++++++++++++++++++++----------
 drivers/serial/Kconfig                  |   24 +++++++-------
 drivers/serial/atmel_serial.c           |   17 ++++++++--
 include/asm-arm/arch-at91rm9200/board.h |    1 +
 include/asm-avr32/arch-at32ap/board.h   |    6 ++++
 include/asm-avr32/arch-at32ap/init.h    |    1 +
 10 files changed, 85 insertions(+), 38 deletions(-)
