Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318022AbSFSVjy>; Wed, 19 Jun 2002 17:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318023AbSFSVjx>; Wed, 19 Jun 2002 17:39:53 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:61197 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318022AbSFSVjx>;
	Wed, 19 Jun 2002 17:39:53 -0400
Date: Wed, 19 Jun 2002 14:38:38 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5 patch] drivers/hotplug/cpqphp.h must include tqueue.h
Message-ID: <20020619213838.GB27552@kroah.com>
References: <Pine.NEB.4.44.0206192327530.10290-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0206192327530.10290-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 22 May 2002 20:35:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 11:31:50PM +0200, Adrian Bunk wrote:
> Hi,
> 
> another tqueue.h compile problem: It's needed in drivers/hotplug/cpqphp.h,
> otherwise compilation fails:

Thanks, but I prefer this fix:

greg k-h


diff -Nru a/drivers/hotplug/cpqphp_core.c b/drivers/hotplug/cpqphp_core.c
--- a/drivers/hotplug/cpqphp_core.c	Wed Jun 19 14:38:54 2002
+++ b/drivers/hotplug/cpqphp_core.c	Wed Jun 19 14:38:54 2002
@@ -33,6 +33,7 @@
 #include <linux/proc_fs.h>
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
+#include <linux/tqueue.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
diff -Nru a/drivers/hotplug/cpqphp_ctrl.c b/drivers/hotplug/cpqphp_ctrl.c
--- a/drivers/hotplug/cpqphp_ctrl.c	Wed Jun 19 14:38:54 2002
+++ b/drivers/hotplug/cpqphp_ctrl.c	Wed Jun 19 14:38:54 2002
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/wait.h>
diff -Nru a/drivers/hotplug/cpqphp_nvram.c b/drivers/hotplug/cpqphp_nvram.c
--- a/drivers/hotplug/cpqphp_nvram.c	Wed Jun 19 14:38:54 2002
+++ b/drivers/hotplug/cpqphp_nvram.c	Wed Jun 19 14:38:54 2002
@@ -33,6 +33,7 @@
 #include <linux/proc_fs.h>
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
+#include <linux/tqueue.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
diff -Nru a/drivers/hotplug/cpqphp_pci.c b/drivers/hotplug/cpqphp_pci.c
--- a/drivers/hotplug/cpqphp_pci.c	Wed Jun 19 14:38:54 2002
+++ b/drivers/hotplug/cpqphp_pci.c	Wed Jun 19 14:38:54 2002
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/tqueue.h>
 #include <linux/proc_fs.h>
 #include <linux/pci.h>
 #include "cpqphp.h"
diff -Nru a/drivers/hotplug/cpqphp_proc.c b/drivers/hotplug/cpqphp_proc.c
--- a/drivers/hotplug/cpqphp_proc.c	Wed Jun 19 14:38:54 2002
+++ b/drivers/hotplug/cpqphp_proc.c	Wed Jun 19 14:38:54 2002
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/tqueue.h>
 #include <linux/pci.h>
 #include "cpqphp.h"
 
