Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264294AbTKTG73 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 01:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbTKTG73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 01:59:29 -0500
Received: from ns.suse.de ([195.135.220.2]:8666 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264294AbTKTG7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 01:59:23 -0500
Date: Thu, 20 Nov 2003 07:59:20 +0100
From: Olaf Hering <olh@suse.de>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       christophe.varoqui@free.fr, patmans@us.ibm.com
Subject: Re: [ANNOUNCE] udev 006 release
Message-ID: <20031120065920.GC14930@suse.de>
References: <20031119162912.GA20835@kroah.com> <20031119234708.GC23529@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031119234708.GC23529@kroah.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Nov 19, Greg KH wrote:

> 	- I've added two external programs to the udev tarball, under
> 	  the extras/ directory.  They are the scsi-id program from Pat
> 	  Mansfield, and the multipath program from Christophe Varoqui.
> 	  Both of them can work as CALLOUT programs.  I don't think they
> 	  currently build properly within the tree, by linking against
> 	  klibc, but patches to their Makefiles to fix this would be
> 	  gladly accepted :)

There is no make install target for the headers and the libs. Both
packages disgree on the location. I use the patch below. Can you make a
decision where the headers should be located?


--- scsi_id/scsi_id.c
+++ scsi_id/scsi_id.c	2003/11/19 21:25:38
@@ -33,7 +33,7 @@
 #include <stdarg.h>
 #include <ctype.h>
 #include <sys/stat.h>
-#include <sys/libsysfs.h>
+#include <libsysfs.h>
 #include "scsi_id.h"
 
 #ifndef VERSION
--- scsi_id/scsi_serial.c
+++ scsi_id/scsi_serial.c	2003/11/19 21:25:42
@@ -31,7 +31,7 @@
 #include <unistd.h>
 #include <syslog.h>
 #include <scsi/sg.h>
-#include <sys/libsysfs.h>
+#include <libsysfs.h>
 #include "scsi_id.h"
 #include "scsi.h"
 

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
