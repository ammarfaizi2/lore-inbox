Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbRGJHAv>; Tue, 10 Jul 2001 03:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265839AbRGJHAm>; Tue, 10 Jul 2001 03:00:42 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:5306 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S265828AbRGJHAa>;
	Tue, 10 Jul 2001 03:00:30 -0400
Message-ID: <3B4AA9CC.D139A58C@sun.com>
Date: Tue, 10 Jul 2001 00:07:56 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org, alan@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  IDE rwproc field
Content-Type: multipart/mixed;
 boundary="------------5036F736851EE873E0F4FB94"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5036F736851EE873E0F4FB94
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Attached i a one-liner that adds a rwproc cache field to the IDE
subsystem.  Please let me know of any reason this can't become part of the
mainline kernel.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------5036F736851EE873E0F4FB94
Content-Type: text/plain; charset=us-ascii;
 name="ide_rwproc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_rwproc.diff"

diff -ruN dist-2.4.6/include/linux/ide.h cobalt-2.4.6/include/linux/ide.h
--- dist-2.4.6/include/linux/ide.h	Tue Jul  3 15:44:16 2001
+++ cobalt-2.4.6/include/linux/ide.h	Mon Jul  9 15:56:19 2001
@@ -284,6 +284,7 @@
 	unsigned long service_time;	/* service time of last request */
 	unsigned long timeout;		/* max time to wait for irq */
 	special_t	special;	/* special action flags */
+	void	 *rwproc_cache;		/* last rwproc update */
 	byte     keep_settings;		/* restore settings after drive reset */
 	byte     using_dma;		/* disk is using dma for read/write */
 	byte     waiting_for_dma;	/* dma currently in progress */

--------------5036F736851EE873E0F4FB94--

