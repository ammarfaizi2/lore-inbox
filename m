Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbTJIW3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTJIW3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:29:21 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:11405 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S262237AbTJIW3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:29:19 -0400
Message-ID: <3F85DF83.80502@rackable.com>
Date: Thu, 09 Oct 2003 15:21:55 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: 2.4.23-pre6 aic79xx compile failure amd64
References: <Pine.LNX.4.44.0310011434400.6488-100000@dmt.cyclades>
In-Reply-To: <Pine.LNX.4.44.0310011434400.6488-100000@dmt.cyclades>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Oct 2003 22:29:17.0795 (UTC) FILETIME=[C6DA2B30:01C38EB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   A minor compile failure for aic79xx under amd64.  The driver compiles 
if you remove -werror in the makefile.

Error:
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-stric
t-aliasing -fno-common -fomit-frame-pointer -mno-red-zone 
-mcmodel=kernel -pipe -fno-reorder-bloc
ks -finline-limit=2000 -fno-strength-reduce -Wno-sign-compare 
-fno-asynchronous-unwind-tables   -
I/usr/src/linux/drivers/scsi
-Werror -nostdinc -iwithprefix include -DKBUILD_BASENAME=aic79xx_osm_pci 
  -c -o
aic79xx_osm_pci.o aic79xx_osm_pci.c
cc1: warnings being treated as errors
aic79xx_osm_pci.c:278: warning: `ahd_linux_pci_reserve_mem_region' 
defined but not used
make[4]: *** [aic79xx_osm_pci.o] Error 1
make[4]: Leaving directory `/usr/src/linux/drivers/scsi/aic7xxx'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/linux/drivers/scsi/aic7xxx'
make[2]: *** [_subdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2


Aic79xx in .config
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_ENABLE_RD_STRM=y
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y

Compiler:
Red Hat Enterprise Linux release 2.9.5AS (Taroon)
Reading specs from /usr/lib/gcc-lib/x86_64-redhat-linux/3.2.3/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man 
--infodir=/usr/share/info --e
nable-shared --enable-threads=posix --disable-checking 
--with-system-zlib --enable-__cxa_atexit -
-host=x86_64-redhat-linux
Thread model: posix
gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-16)

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

