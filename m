Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSLFOqk>; Fri, 6 Dec 2002 09:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSLFOqk>; Fri, 6 Dec 2002 09:46:40 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:17062 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S262038AbSLFOqj>; Fri, 6 Dec 2002 09:46:39 -0500
Date: Fri, 6 Dec 2002 15:54:10 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.20 fails to build with aic7xxx
Message-ID: <20021206145410.GD5990@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We get:

...
make[3]: Entering directory /usr/src/linux-2.4.20/drivers/scsi'
/usr/bin/make -C aic7xxx
make[4]: Entering directory /usr/src/linux-2.4.20/drivers/scsi/aic7xxx'
/usr/bin/make all_targets
make[5]: Entering directory /usr/src/linux-2.4.20/drivers/scsi/aic7xxx'
/usr/bin/make -C aicasm
make[6]: Entering directory
/usr/src/linux-2.4.20/drivers/scsi/aic7xxx/aicasm'
yacc -d -b aicasm_gram aicasm_gram.y
aicasm_gram.y:921.21: parse error, unexpected ":", expecting ";" or "|"
aicasm_gram.y:936.2-5: $$ of critical_section_start' has no declared type
aicasm_gram.y:938.2-5: $$ of critical_section_start' has no declared type
make[6]: *** [aicasm_gram.h] Error 1
make[6]: Leaving directory
/usr/src/linux-2.4.20/drivers/scsi/aic7xxx/aicasm'
make[5]: *** [aicasm/aicasm] Error 2
make[5]: Leaving directory /usr/src/linux-2.4.20/drivers/scsi/aic7xxx'
make[4]: *** [first_rule] Error 2
make[4]: Leaving directory /usr/src/linux-2.4.20/drivers/scsi/aic7xxx'
make[3]: *** [_subdir_aic7xxx] Error 2
make[3]: Leaving directory /usr/src/linux-2.4.20/drivers/scsi'
make[2]: *** [_subdir_scsi] Error 2
make[2]: Leaving directory /usr/src/linux-2.4.20/drivers'
make[1]: *** [_dir_drivers] Error 2
make[1]: Leaving directory /usr/src/linux-2.4.20'
make: *** [stamp-build] Error 2

# yacc -V
bison (GNU Bison) 1.75
Written by Robert Corbett and Richard Stallman.

Copyright (C) 2002 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There
is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.

# grep -i AIC .config
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
CONFIG_AIC7XXX_BUILD_FIRMWARE=y

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916

