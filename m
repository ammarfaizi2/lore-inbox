Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291151AbSAaQp5>; Thu, 31 Jan 2002 11:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291149AbSAaQps>; Thu, 31 Jan 2002 11:45:48 -0500
Received: from air-1.osdl.org ([65.201.151.5]:44959 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S291147AbSAaQph>;
	Thu, 31 Jan 2002 11:45:37 -0500
Date: Thu, 31 Jan 2002 08:46:36 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Luigi Genoni <kernel@Expansa.sns.it>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.3 does not compile on sparc64
In-Reply-To: <Pine.LNX.4.44.0201311108550.16240-100000@Expansa.sns.it>
Message-ID: <Pine.LNX.4.33.0201310845320.800-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there.

> Of course I had to correct dome
> #include <malloc.h>
> in
> #include <slab.h> (this is the case).

That's right. I've sent a patch to Linus, but here it is for everyone else 
while waiting for 2.5.4-pre1.

	-pat

--- linux-2.5.3/drivers/base/core.c.1	Wed Jan 30 14:20:25 2002
+++ linux-2.5.3/drivers/base/core.c	Wed Jan 30 14:20:33 2002
@@ -7,7 +7,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 
 #undef DEBUG
 
--- linux-2.5.3/drivers/base/fs.c.0	Wed Jan 30 14:20:44 2002
+++ linux-2.5.3/drivers/base/fs.c	Wed Jan 30 14:20:52 2002
@@ -8,7 +8,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/string.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 
 extern struct driver_file_entry * device_default_files[];
 

