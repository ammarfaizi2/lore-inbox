Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVDEMkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVDEMkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 08:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVDEMkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 08:40:32 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:37068 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261715AbVDEMk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 08:40:26 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm1
Date: Tue, 5 Apr 2005 14:40:04 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, mdharm-usb@one-eyed-alien.net
References: <20050405000524.592fc125.akpm@osdl.org>
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504051440.04886.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

a missing include:

...
drivers/usb/storage/debug.c: In function `usb_stor_show_sense':
drivers/usb/storage/debug.c:166: warning: implicit declaration of function `scsi_sense_key_string'
drivers/usb/storage/debug.c:167: warning: implicit declaration of function `scsi_extd_sense_format'
...


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
