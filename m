Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWEVFae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWEVFae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 01:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWEVFad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 01:30:33 -0400
Received: from palrel10.hp.com ([156.153.255.245]:11981 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751556AbWEVFad convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 01:30:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [LINUX-KERNEL] Problem loading any custom driver
Date: Sun, 21 May 2006 22:30:32 -0700
Message-ID: <1FB1F81B4767FC48A2AF2278D735CE64038BFC5F@cacexc05.americas.cpqcorp.net>
In-Reply-To: <1148271181.3902.59.camel@laptopd505.fenrus.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [LINUX-KERNEL] Problem loading any custom driver
Thread-Index: AcZ9Vggd8zZSnJFeRl6unPFx0Hg6JwAChcqw
From: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 May 2006 05:30:32.0231 (UTC) FILETIME=[D8164B70:01C67D60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So,
in this case what kind of makefile I should have?
Can you attach an example?
Attached makefile is very similar what I found in the 2.6.9-34.EL-i686 source
I also were thinking that some os includes are not the right ones

--------------------------------------------------

/* Include Files */
#ifdef MODULE
#include <linux/module.h>
#include <linux/version.h>
#endif

#include <linux/config.h>
#include <linux/types.h>
#include <linux/pci.h>
#include <linux/kernel.h>
#include <linux/sched.h>

#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/init.h>
#include <linux/skbuff.h>
#include <linux/ethtool.h>

#include <linux/mm.h>
#include <linux/errno.h>
#include <linux/ioport.h>

#include <linux/delay.h>
#include <linux/timer.h>
#include <linux/slab.h>
#include <linux/interrupt.h>
#include <linux/version.h>
#include <linux/inetdevice.h>
#include <linux/bitops.h>

#include <asm/uaccess.h>
#include <linux/if_ether.h>
#include <linux/if_arp.h>
#include <net/arp.h>

#include "atf.h"
#include "atf_host.h"
#include "atf_common.h"

-------------------------------------------------------------

-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org]
Sent: Sunday, May 21, 2006 9:13 PM
To: Libershteyn, Vladimir
Cc: linux-kernel@vger.kernel.org
Subject: RE: [LINUX-KERNEL] Problem loading any custom driver


On Sun, 2006-05-21 at 21:05 -0700, Libershteyn, Vladimir wrote:
> Here is a makefile
> -------------------------------------------------
> #
> # Makefile for the Los Angeles PCI Adapter
> # This file supports Red Hat Linux kernel 2.6(included) and above
> #
> HPATH := /usr/src/kernels/2.6.9-34.EL-i686/include
> CFLAGS = -I$(HPATH) -Wall -O2 -fomit-frame-pointer -c
> CFLAGS := $(CFLAGS) -DHOST_LITTLE_ENDIAN -DHOST_SIZE_32
> 
> obj-m += atf_host.o

this is buggy, you have to drop the CFLAGS lines!!!!!


> Our group does not have ability to put files for outside access.
> Can you specify what parts of the code you need me to attach?
> Im not familiar with rules, is it allowed to attach source files?

yeah that's fine if they're not gigantic (50Kb or so is a reasonable
boundary for that)

