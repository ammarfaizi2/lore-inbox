Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbULaNsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbULaNsQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 08:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbULaNsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 08:48:16 -0500
Received: from astro.systems.pipex.net ([62.241.163.6]:36037 "EHLO
	astro.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262055AbULaNrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 08:47:41 -0500
Message-ID: <41D5585E.6040201@dsl.pipex.com>
Date: Fri, 31 Dec 2004 13:47:10 +0000
From: Ian Smith <the.pond@dsl.pipex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7.5) Gecko/20041222
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 - problem with cx88-cards.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to get a Hauppauge Nova-T working.  The chip IDs are 
cx22702-15 and cx23882-19.

Relevant configs:

CONFIG_VIDEO_CX88_DVB=m
CONFIG_DVB=y
CONFIG_DVB_CORE=m
CONFIG_DVB_AV7110=m
# CONFIG_DVB_AV7110_OSD is not set
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
# CONFIG_DVB_DIBUSB is not set
# CONFIG_DVB_CINERGYT2 is not set
CONFIG_DVB_B2C2_SKYSTAR=m
# CONFIG_DVB_B2C2_USB is not set
CONFIG_DVB_BT8XX=m
# Supported DVB Frontends
# Customise DVB Frontends
# DVB-S (satellite) frontends
CONFIG_DVB_STV0299=m
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_TDA8083=m
# CONFIG_DVB_TDA80XX is not set
CONFIG_DVB_MT312=m
CONFIG_DVB_VES1X93=m
# DVB-T (terrestrial) frontends
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_MT352=m
# CONFIG_DVB_DIB3000MB is not set
# CONFIG_DVB_DIB3000MC is not set
# DVB-C (cable) frontends
# CONFIG_DVB_ATMEL_AT76C651 is not set
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_STV0297=m
CONFIG_VIDEO_BUF_DVB=m

Problem is the kernel build fails (nb. this is with a completely 
pristine source tree):

Kernel: arch/i386/boot/bzImage is ready
make[1]: Leaving directory `/usr/src/linux-2.6.10'
/usr/bin/make    ARCH=i386 \
                      modules
make[1]: Entering directory `/usr/src/linux-2.6.10'
   CHK     include/linux/version.h
make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
   CC [M]  drivers/media/video/cx88/cx88-cards.o
drivers/media/video/cx88/cx88-cards.c: In function `hauppauge_eeprom_dvb':
drivers/media/video/cx88/cx88-cards.c:694: error: `PLLTYPE_DTT7595' 
undeclared (first use in this function)
drivers/media/video/cx88/cx88-cards.c:694: error: (Each undeclared 
identifier is reported only once
drivers/media/video/cx88/cx88-cards.c:694: error: for each function it 
appears in.)
drivers/media/video/cx88/cx88-cards.c:698: error: `PLLTYPE_DTT7592' 
undeclared (first use in this function)
drivers/media/video/cx88/cx88-cards.c: In function `cx88_card_setup':
drivers/media/video/cx88/cx88-cards.c:856: error: `PLLTYPE_DTT7579' 
undeclared (first use in this function)
make[5]: *** [drivers/media/video/cx88/cx88-cards.o] Error 1
make[4]: *** [drivers/media/video/cx88] Error 2
make[3]: *** [drivers/media/video] Error 2
make[2]: *** [drivers/media] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.10'
make: *** [stamp-build] Error 2

Hope someone can shed some light on this - patches welcomed.  BTW I am 
not subscribed, but I will be monitoring the archives so no need to cc 
if you can't be bothered ;)

-- 
------------------------------------------------------------------------
Ian Smith
Worst . . . signature . . . ever !

