Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVLaFSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVLaFSN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 00:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVLaFSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 00:18:13 -0500
Received: from smtp4.pacifier.net ([64.255.237.174]:8888 "EHLO
	smtp4.pacifier.net") by vger.kernel.org with ESMTP id S1751304AbVLaFSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 00:18:12 -0500
Message-ID: <43B6146C.60E044FF@e-z.net>
Date: Fri, 30 Dec 2005 21:17:32 -0800
From: "Steven J. Hathaway" <shathawa@e-z.net>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org, axobe@suse.de, linux-kernel@vger.kernel.org
CC: shathawa@e-z.net, andre@linuxdiskcert.org
Subject: PROBLEM: Linux ATAPI CDROM ->FIX: SAMSUNG CD-ROM SC-140
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem first appeared in Linux 2.4.21 when the "ide-dma" source
experienced
a significant overhaul, but worked OK in Linux  versions 2.4.5 through
2.4.20.
The problem still exists in Linux 2.4.32.

Attempts to mount a SAMSUNG SC-140 CDROM are allowing DMA which fails
because of a problem in the following source code file:

        <linux>/drivers/ide/ide-dma.c

User sees displayed
    mount: Directory not available

The fix is to add the following record to the drive_blacklist[] table.

     { "SAMSUNG CD-ROM SC-140",  "ALL" },

This model of SAMSUNG CD-ROM disk drive is original equipment on the
E=Machines etower 556i2 compters, and possibly many other models.

DMA should not be performed on this CDROM model, therefore I submit
the drive_blacklist[] request.

I had given up on upgrading Linux on this platform until the fix was
found
and tested.  The fix works with all Linux 2.4.21 through 2.4.32 versions

of stable kernels.

Sincerely,
Steven J. Hathaway
<shathawa@e-z.net>



