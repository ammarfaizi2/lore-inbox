Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422703AbWATAch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422703AbWATAch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422704AbWATAch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:32:37 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:46155 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422703AbWATAcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:32:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=SQ+4Z67GaBYKzm7/gyx8+kRm8FHwEyOynXq2MvVBGscXbsenNWX6hFvlTvivg17QGjb4DEsSAmptvFRPd8amdzsF5OY9pdaTBn+gVCDZQm45lSz32Hbmji3YnNEZfzWeJKG1T3VVfnwydUH3w7pbG153yHN2XnUwkHOB8BO4sOE=
Date: Fri, 20 Jan 2006 03:50:01 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] Documentation/ioctl-mess.txt: update
Message-ID: <20060120005001.GA10912@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several of tty ioctls, tun driver, udf, usbdevfs. VUIDGFORMAT,
VUIDSFORMAT dissapeared somewhere.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/ioctl-mess.txt |  183 ++++++++++++++++++++++++++++++++++--------
 1 files changed, 146 insertions(+), 37 deletions(-)

--- a/Documentation/ioctl-mess.txt
+++ b/Documentation/ioctl-mess.txt
@@ -4181,7 +4181,9 @@ N: TIOCSETC
 I: struct tchars
 O: -
 
-TIOCSETD
+N: TIOCSETD
+I: int
+O: -
 
 N: TIOCSETN
 I: struct sgttyb
@@ -4195,35 +4197,102 @@ N: TIOCSLTC
 I: struct ltchars
 O: -
 
-TIOCSPGRP
-TIOCSPTLCK
+N: TIOCSPGRP
+I: pid_t
+O: -
+
+N: TIOCSPTLCK
+I: int
+O: -
+
 TIOCSSERIAL
 TIOCSSOFTCAR
 TIOCSTART
-TIOCSTI
+
+N: TIOCSTI
+I: char
+O: -
+
 TIOCSTOP
-TIOCSWINSZ
+
+N: TIOCSWINSZ
+I: struct winsize
+O: -
+
 TIOCTTYGSTRUCT
-TOSH_SMM
-TS_GET_CAL
-TS_SET_CAL
-TUBGETI
-TUBGETMOD
-TUBGETO
-TUBICMD
-TUBOCMD
+
+N: TOSH_SMM
+I: SMMRegisters
+O: SMMRegisters
+
+N: TS_GET_CAL
+I: -
+O: struct ts_calibration
+
+N: TS_SET_CAL
+I: struct ts_calibration
+O: -
+
+N: TUBGETI
+I: -
+O: char
+
+N: TUBGETMOD
+I: -
+O: struct raw3270_iocb
+
+N: TUBGETO
+I: -
+O: char
+
+N: TUBICMD
+I: (int) arg
+O: -
+
+N: TUBOCMD
+I: (int) arg
+O: -
+
 TUBSETMOD
 TUNER_SET_TYPE_ADDR
-TUNSETDEBUG
+
+N: TUNSETDEBUG
+I: (int) arg
+O: -
+
 TUNSETIFF
-TUNSETLINK
-TUNSETNOCSUM
-TUNSETOWNER
-TUNSETPERSIST
-UDF_GETEABLOCK
-UDF_GETEASIZE
-UDF_GETVOLIDENT
-UDF_RELOCATE_BLOCKS
+
+N: TUNSETLINK
+I: (int) arg
+O: -
+
+N: TUNSETNOCSUM
+I: (unsigned long) arg
+O: -
+
+N: TUNSETOWNER
+I: (uid_t) arg
+O: -
+
+N: TUNSETPERSIST
+I: (unsigned long) arg
+O: -
+
+N: UDF_GETEABLOCK
+I: -
+O: char [UDF_I_LENEATTR(inode)]
+
+N: UDF_GETEASIZE
+I: -
+O: int
+
+N: UDF_GETVOLIDENT
+I: -
+O: char [32]
+
+N: UDF_RELOCATE_BLOCKS
+I: long
+O: long
 
 UI_BEGIN_FF_ERASE
 UI_BEGIN_FF_UPLOAD
@@ -4274,29 +4343,72 @@ I: (int) arg
 O: -
 
 UNPROTECT_ARRAY
-USBDEVFS_BULK
+
+N: USBDEVFS_BULK
+I: struct usbdevfs_bulktransfer
+O: -
+
 USBDEVFS_BULK32
-USBDEVFS_CLAIMINTERFACE
-USBDEVFS_CLEAR_HALT
+
+N: USBDEVFS_CLAIMINTERFACE
+I: unsigned int
+O: -
+
+N: USBDEVFS_CLEAR_HALT
+I: unsigned int
+O: -
+
 USBDEVFS_CONNECT
-USBDEVFS_CONNECTINFO
+
+N: USBDEVFS_CONNECTINFO
+I: -
+O: struct usbdevfs_connectinfo
+
 USBDEVFS_CONTROL
 USBDEVFS_CONTROL32
-USBDEVFS_DISCARDURB
+
+N: USBDEVFS_DISCARDURB
+I: -
+O: -
+
 USBDEVFS_DISCONNECT
-USBDEVFS_DISCSIGNAL
+
+N: USBDEVFS_DISCSIGNAL
+I: struct usbdevfs_disconnectsignal
+O: -
+
 USBDEVFS_DISCSIGNAL32
-USBDEVFS_GETDRIVER
+
+N: USBDEVFS_GETDRIVER
+I: struct usbdevfs_getdriver
+O: struct usbdevfs_getdriver
+
 USBDEVFS_HUB_PORTINFO
 USBDEVFS_REAPURB
 USBDEVFS_REAPURB32
 USBDEVFS_REAPURBNDELAY
 USBDEVFS_REAPURBNDELAY32
-USBDEVFS_RELEASEINTERFACE
-USBDEVFS_RESET
-USBDEVFS_RESETEP
-USBDEVFS_SETCONFIGURATION
-USBDEVFS_SETINTERFACE
+
+N: USBDEVFS_RELEASEINTERFACE
+I: unsigned int
+O: -
+
+N: USBDEVFS_RESET
+I: -
+O: -
+
+N: USBDEVFS_RESETEP
+I: unsigned int
+O: -
+
+N: USBDEVFS_SETCONFIGURATION
+I: unsigned int
+O: -
+
+N: USBDEVFS_SETINTERFACE
+I: struct usbdevfs_setinterface
+O: -
+
 USBDEVFS_SUBMITURB
 USBDEVFS_SUBMITURB32
 USBTEST_REQUEST
@@ -4611,9 +4723,6 @@ N: VT_WAITACTIVE
 I: (int) arg
 O: -
 
-VUIDGFORMAT
-VUIDSFORMAT
-
 N: WDIOC_GETBOOTSTATUS
 I: -
 O: int

