Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVDVH4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVDVH4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 03:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVDVH4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 03:56:53 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:27035 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261489AbVDVH4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 03:56:38 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
Subject: Re: Linux 2.6.12-rc3
Date: Fri, 22 Apr 2005 09:56:43 +0200
User-Agent: KMail/1.7.2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504220956.43883.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 April 2005 02:59, you wrote:
<snip>
Hello,

[build.log]
...
drivers/usb/storage/debug.c: In function `usb_stor_show_sense':
drivers/usb/storage/debug.c:166: warning: implicit declaration of function
`scsi_sense_key_string'
drivers/usb/storage/debug.c:166: warning: assignment makes pointer from
integer without a cast
drivers/usb/storage/debug.c:167: warning: implicit declaration of function
`scsi_extd_sense_format'
drivers/usb/storage/debug.c:167: warning: assignment makes pointer from
integer without a cast
...

Hmm, actually I've already sent the trivial patch below for this to Andrew a
few weeks ago and he included it in mm but somehow it is not there..

--- drivers/usb/storage/debug.c.orig	2005-04-05 14:24:21.000000000 +0200
+++ drivers/usb/storage/debug.c	2005-04-05 14:24:35.000000000 +0200
@@ -47,7 +47,7 @@
 #include <linux/cdrom.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
-
+#include <scsi/scsi_dbg.h>
 #include "debug.h"
 #include "scsi.h"

Regards,
Boris.
