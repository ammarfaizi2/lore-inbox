Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUHGMwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUHGMwX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 08:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUHGMwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 08:52:23 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:7903 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261875AbUHGMwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 08:52:10 -0400
Date: Sat, 7 Aug 2004 14:51:35 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408071251.i77CpZqE007029@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: linux-kernel@vger.kernel.org
Subject: Linux Kernel bug report (includes fix)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-	Linux Kernel include files (starting with Linux-2.5) are buggy and 
	prevent compilation. Many files may be affected but let me name
	the most important files for me:

	-	/usr/src/linux/include/scsi/scsi.h depends on a nonexistant
		type "u8". The correct way to fix this would be to replace
		any "u8" by "uint8_t". A quick and dirty fix is to call:

			"change u8 __u8 /usr/src/linux/include/scsi/scsi.h"

		ftp://ftp.berlios.de/pub/change/

	-	/usr/src/linux/include/scsi/sg.h includes "extra text" "__user"
		in some structure definitions. This may be fixed by adding
		#include <linux/compiler.h> somewhere at the beginning of
		/usr/src/linux/include/scsi/sg.h

	This bug has been reported several times (starting with Linux-2.5).

	Time to fix: 5 minutes.
	
I did spend far to much time with the discussion on LKML..... so I need a cue
whether it makes sense to continue this discussion.

You now again have the bug report _and_ the fix in a single short mail.

If the bug mentioned above is not fixed in Linux-2.6.8, I will asume that it 
makes no sense to spend further time in discussions with LKML.

Best regards

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
