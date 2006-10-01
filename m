Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWJAUQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWJAUQo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 16:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWJAUQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 16:16:44 -0400
Received: from smtp1.pacifier.net ([64.255.237.171]:13285 "EHLO
	smtp1.pacifier.net") by vger.kernel.org with ESMTP id S932299AbWJAUQn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 16:16:43 -0400
Message-ID: <452021F4.79081F8F@e-z.net>
Date: Sun, 01 Oct 2006 13:15:49 -0700
From: "Steven J. Hathaway" <shathawa@e-z.net>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Add "SAMSUNG CD-ROM SC-140" to ide-dma blacklist
Content-Type: multipart/mixed;
 boundary="------------43E602F95EB7DAFC4B546471"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------43E602F95EB7DAFC4B546471
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

MS-Windows sees the CD-ROM ok.
Linux V 2.4.21 and earlier see the CD-ROM ok.
Linux V 2.4.24 and later fail to find a CD-ROM file system.
The major ide code changed since 2.4.21.  I have since
required the following patch in order for the kernel to
see the CDROM.   Enclosed is a context diff patch file.

The problem appeared when I was trying to install a Slackware
distribution.
The bootstrap would load the kernel and initrd structure, but the
kernel,
once gaining control, would register file system errors when accessing
the disk drive.  Seeing other related SAMSUNG CD-ROM drivers in the
ide-dma.c blacklist, and adding my SAMSUNG CD-ROM device to the
same blacklist, and rebuilding a kernel, the problem has been overcome.

Sincerely,
Steven J. Hathaway



--------------43E602F95EB7DAFC4B546471
Content-Type: text/plain; charset=us-ascii;
 name="ide-dma.c-patch-samsung-cdr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-dma.c-patch-samsung-cdr"

KERNEL Version 2.4.32
The "SAMSUNG CD-ROM SC-140" needs to be added to the dma blacklist.
I have had to make this patch since about Version 2.4.23 to accommodate
a major code change in ide-dma structure.  Here is the context diff.

Sincerely:  Steven J.Hathaway, <shathawa@e-z.net>

*** drivers/ide/ide-dma.c-org	2006-10-01 12:31:17.000000000 -0700
--- drivers/ide/ide-dma.c	2006-10-01 12:33:20.000000000 -0700
***************
*** 137,142 ****
--- 137,143 ----
  	{ "CD-ROM Drive/F5A",	"ALL"		},
  	{ "RICOH CD-R/RW MP7083A",	"ALL"		},
  	{ "WPI CDD-820",		"ALL"		},
+ 	{ "SAMSUNG CD-ROM SC-140",	"ALL"		},
  	{ "SAMSUNG CD-ROM SC-148C",	"ALL"		},
  	{ "SAMSUNG CD-ROM SC-148F",	"ALL"		},
  	{ "SAMSUNG CD-ROM SC",	"ALL"		},

--------------43E602F95EB7DAFC4B546471--

