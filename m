Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWI0Q6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWI0Q6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWI0Q6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:58:04 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:14559 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751214AbWI0Q6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:58:02 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       hskinnemoen@atmel.com
Subject: [PATCH 0/8] Rename at91_serial driver as atmel_serial
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Wed, 27 Sep 2006 18:57:57 +0200
Message-Id: <1159376285670-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's the big at91_serial rename I've been talking about before. It
turned out to be quite big on its own, so I'm sending it as a separate
series. I have a few more patches for the atmel_serial driver (or
at91_serial driver, depending on whether you'll accept this series)
which I'll send you tomorrow. Please give me a hint about whether this
series is acceptable or not so that I can rework the other patches as
appropriate.

Patch #6 turned out to be too big to send inline, so I'm sending a link
to it instead. I can send it to you in private if you want.

Also, the patches have been made with git-format-patch -M, so they
won't work with patch, only with git. This reduced the size of the
first two patches a lot.

Shortlog, diffstat and summary of the full series follows.

Haavard

Haavard Skinnemoen:
      at91_serial -> atmel_serial: at91rm9200_usart.h
      at91_serial -> atmel_serial: at91_serial.c
      at91_serial -> atmel_serial: Kconfig symbols
      at91_serial -> atmel_serial: Platform device name
      at91_serial -> atmel_serial: Public definitions
      at91_serial -> atmel_serial: Internal names
      serial: Rename PORT_AT91 -> PORT_ATMEL
      atmel_serial: Kill at91_register_uart_fns

 arch/arm/configs/at91rm9200dk_defconfig            |    6
 arch/arm/configs/at91rm9200ek_defconfig            |    6
 arch/arm/configs/ateb9200_defconfig                |    6
 arch/arm/configs/carmeva_defconfig                 |    4
 arch/arm/configs/csb337_defconfig                  |    6
 arch/arm/configs/csb637_defconfig                  |    6
 arch/arm/configs/kafa_defconfig                    |    6
 arch/arm/configs/kb9202_defconfig                  |    4
 arch/arm/configs/onearm_defconfig                  |    6
 arch/arm/mach-at91rm9200/devices.c                 |   34 -
 arch/avr32/configs/atstk1002_defconfig             |    6
 arch/avr32/mach-at32ap/at32ap7000.c                |   46 -
 drivers/serial/Kconfig                             |   14
 drivers/serial/Makefile                            |    2
 drivers/serial/at91_serial.c                       |  980 --------------------
 drivers/serial/atmel_serial.c                      |  940 +++++++++++++++++++
 drivers/serial/atmel_serial.h                      |  123 +++
 include/asm-arm/arch-at91rm9200/at91rm9200_usart.h |  123 ---
 include/asm-arm/arch-at91rm9200/board.h            |    4
 include/asm-arm/arch-at91rm9200/hardware.h         |    2
 include/asm-arm/mach/serial_at91.h                 |   33 -
 include/asm-avr32/arch-at32ap/at91rm9200_usart.h   |  123 ---
 include/asm-avr32/arch-at32ap/board.h              |    4
 include/asm-avr32/mach/serial_at91.h               |   33 -
 include/linux/serial_core.h                        |    4
 25 files changed, 1146 insertions(+), 1375 deletions(-)
 delete mode 100644 drivers/serial/at91_serial.c
 create mode 100644 drivers/serial/atmel_serial.c
 create mode 100644 drivers/serial/atmel_serial.h
 delete mode 100644 include/asm-arm/arch-at91rm9200/at91rm9200_usart.h
 delete mode 100644 include/asm-arm/mach/serial_at91.h
 delete mode 100644 include/asm-avr32/arch-at32ap/at91rm9200_usart.h
 delete mode 100644 include/asm-avr32/mach/serial_at91.h
