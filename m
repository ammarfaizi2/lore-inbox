Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130449AbQLPUhn>; Sat, 16 Dec 2000 15:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbQLPUhe>; Sat, 16 Dec 2000 15:37:34 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:11350
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130449AbQLPUh1>; Sat, 16 Dec 2000 15:37:27 -0500
Date: Sat, 16 Dec 2000 21:06:52 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: isdn4linux@listserv.isdn4linux.de
Cc: linux-kernel@vger.kernel.org
Subject: doubly defined symbols in drivers/isdn/eicon (240t13p2)
Message-ID: <20001216210652.A609@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

When I try to compile kernel 240test13pre2 I get the following:


rm -f eicon_drv.o
ld -m elf_i386  -r -o eicon_drv.o eicon.o divas.o
divas.o: In function `eicon_init':
divas.o(.text+0x61d0): multiple definition of `eicon_init'
eicon.o(.text+0x197c): first defined here
ld: Warning: size of symbol `eicon_init' changed from 370 to 83 in divas.o
divas.o: In function `file_check':
divas.o(.text+0x61bc): multiple definition of `file_check'
eicon.o(.text+0xb394): first defined here
make[4]: *** [eicon_drv.o] Error 1
make[4]: Leaving directory `/home/rasmus/kernel/linux/drivers/isdn/eicon'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/home/rasmus/kernel/linux/drivers/isdn/eicon'
make[2]: *** [_subdir_eicon] Error 2
make[2]: Leaving directory `/home/rasmus/kernel/linux/drivers/isdn'
make[1]: *** [_subdir_isdn] Error 2
make[1]: Leaving directory `/home/rasmus/kernel/linux/drivers'
make: *** [_dir_drivers] Error 2


The part of my .config I guess is interesting:

#
# Active ISDN cards
#
CONFIG_ISDN_DRV_ICN=y
CONFIG_ISDN_DRV_PCBIT=y
CONFIG_ISDN_DRV_SC=y
CONFIG_ISDN_DRV_ACT2000=y
CONFIG_ISDN_DRV_EICON=y
CONFIG_ISDN_DRV_EICON_OLD=y
# CONFIG_ISDN_DRV_EICON_PCI is not set
CONFIG_ISDN_DRV_EICON_ISA=y
CONFIG_ISDN_DRV_EICON_DIVAS=y
CONFIG_ISDN_CAPI=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPIFS=y
CONFIG_ISDN_CAPI_CAPI20=y
CONFIG_ISDN_CAPI_CAPIDRV=y


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"Men kick friendship around like a football, but it doesn't seem to
 crack. Women treat it like glass and it goes to pieces."
  -- Anne Spencer Morrow Lindbergh
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
