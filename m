Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318026AbSFSVp1>; Wed, 19 Jun 2002 17:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318029AbSFSVp0>; Wed, 19 Jun 2002 17:45:26 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:62989 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318026AbSFSVpZ>;
	Wed, 19 Jun 2002 17:45:25 -0400
Date: Wed, 19 Jun 2002 14:44:11 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Matthew Harrell 
	<mharrell-dated-1024798178.8a2594@bittwiddlers.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.22 fix for pci_hotplug
Message-ID: <20020619214410.GC27552@kroah.com>
References: <20020619173622.GB26136@kroah.com> <Pine.NEB.4.44.0206192326000.10290-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0206192326000.10290-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 22 May 2002 20:35:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 11:26:59PM +0200, Adrian Bunk wrote:
> On Wed, 19 Jun 2002, Greg KH wrote:
> 
> > > He tries to fix the following compile error that is caused by Martin
> > > Dalecki's "[PATCH] 2.5.21 kill warnings 4/19" that is included in 2.5.22:
> >
> > Yeah, it looks like Martin got it wrong :)
> >
> > Can you try this patch instead and let me know if it fixes it or not?
> 
> 
> Yes, this patch fixes it. A similar patch is needed for
> pci_hotplug_util.c...

Here ya go.

greg k-h


diff -Nru a/drivers/hotplug/pci_hotplug_util.c b/drivers/hotplug/pci_hotplug_util.c
--- a/drivers/hotplug/pci_hotplug_util.c	Wed Jun 19 14:44:45 2002
+++ b/drivers/hotplug/pci_hotplug_util.c	Wed Jun 19 14:44:45 2002
@@ -41,7 +41,7 @@
 	#define MY_NAME	THIS_MODULE->name
 #endif
 
-#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt, MY_NAME, __FUNCTION__, ## arg); } while (0)
+#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt , MY_NAME , __FUNCTION__ , ## arg); } while (0)
 #define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
