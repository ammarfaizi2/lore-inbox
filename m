Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUDGKhz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 06:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUDGKhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 06:37:55 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:35793 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S262514AbUDGKhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 06:37:53 -0400
Date: Wed, 7 Apr 2004 12:37:46 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-mm2 build problem
Message-ID: <20040407103746.GF20293@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.5-mm1 builds OK, 2.6.5-mm2 does not:

  CC [M]  drivers/scsi/scsicam.o
  CC [M]  drivers/scsi/scsi_error.o
  CC [M]  drivers/scsi/scsi_lib.o
  CC [M]  drivers/scsi/scsi_scan.o
  CC [M]  drivers/scsi/scsi_syms.o
  CC [M]  drivers/scsi/scsi_sysfs.o
  CC [M]  drivers/scsi/scsi_devinfo.o
  CC [M]  drivers/scsi/scsi_sysctl.o
  CC [M]  drivers/scsi/scsi_proc.o
  CC [M]  drivers/scsi/sd.o
  CC [M]  drivers/scsi/sr.o
drivers/scsi/sr.c: In function scsi_cd_get':
drivers/scsi/sr.c:128: error: structure has no member named kobj'
drivers/scsi/sr.c: In function scsi_cd_put':
drivers/scsi/sr.c:135: error: structure has no member named kobj'
drivers/scsi/sr.c: In function sr_probe':
drivers/scsi/sr.c:554: error: structure has no member named kobj'
drivers/scsi/sr.c:555: error: structure has no member named kobj'
drivers/scsi/sr.c: In function sr_kobject_release':
drivers/scsi/sr.c:904: error: structure has no member named kobj'
drivers/scsi/sr.c:904: warning: type defaults to int' in declaration of __mptr'
drivers/scsi/sr.c:904: warning: initialization from incompatible pointer type
drivers/scsi/sr.c:904: error: structure has no member named kobj'
make[3]: *** [drivers/scsi/sr.o] Error 1
make[2]: *** [drivers/scsi] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory /usr/src/linux-2.6.5-mm2'
make: *** [stamp-build] Error 2

My .config is here:
http://www.stahl.bau.tu-bs.de/~hildeb/satellitepro/kernel-config-2.6		      

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
