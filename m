Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTDQXFD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbTDQXFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:05:03 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21132 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262657AbTDQXFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:05:02 -0400
Date: Fri, 18 Apr 2003 01:16:30 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.67-ac1 IDE - fix Taskfile IOCTLs
Message-ID: <Pine.SOL.4.30.0304180052130.20946-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

This time 5 incremental patches:

1       - Fix PIO handlers for Taskfile ioctls.
2a + 2b - Taskfile and flagged Taskfile PIO handlers unification.
3       - Map HDIO_DRIVE_CMD ioctl onto taskfile.
4       - Remove dead ide_diag_taskfile() code.

[ More comments inside patches. ]

Special care is needed for patch 3 as it is a bit experimental,
but at least hdparm -I /dev/hdx still works :-).
I have also made version using direct IO to user pages,
it works okay too but needs some more work to be elegant...

You can also get them at:
http://home.elka.pw.edu.pl/~bzolnier/patches/2.5.67-ac1/

--
bzolnier

