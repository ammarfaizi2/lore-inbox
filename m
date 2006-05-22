Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWEVEFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWEVEFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 00:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWEVEFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 00:05:39 -0400
Received: from palrel10.hp.com ([156.153.255.245]:9116 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S965009AbWEVEFi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 00:05:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [LINUX-KERNEL] Problem loading any custom driver
Date: Sun, 21 May 2006 21:05:35 -0700
Message-ID: <1FB1F81B4767FC48A2AF2278D735CE64038BFC5E@cacexc05.americas.cpqcorp.net>
In-Reply-To: <1148269847.3902.57.camel@laptopd505.fenrus.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [LINUX-KERNEL] Problem loading any custom driver
Thread-Index: AcZ9UvTSMNc/PXPFRpabCcNxX6OJcQAAUpUg
From: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 May 2006 04:05:35.0474 (UTC) FILETIME=[FA2EE520:01C67D54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a makefile
-------------------------------------------------
#
# Makefile for the Los Angeles PCI Adapter
# This file supports Red Hat Linux kernel 2.6(included) and above
#
HPATH := /usr/src/kernels/2.6.9-34.EL-i686/include
CFLAGS = -I$(HPATH) -Wall -O2 -fomit-frame-pointer -c
CFLAGS := $(CFLAGS) -DHOST_LITTLE_ENDIAN -DHOST_SIZE_32

obj-m += atf_host.o
-------------------------------------------------

Our group does not have ability to put files for outside access.
Can you specify what parts of the code you need me to attach?
Im not familiar with rules, is it allowed to attach source files?

Regards,
Vlad


-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org]
Sent: Sunday, May 21, 2006 8:51 PM
To: Libershteyn, Vladimir
Cc: linux-kernel@vger.kernel.org
Subject: Re: [LINUX-KERNEL] Problem loading any custom driver


On Sun, 2006-05-21 at 20:42 -0700, Libershteyn, Vladimir wrote:
> Greetings,
> 
> I need a help on understanding and possible resolution on a problem I have while trying to load driver(s) to a server running Linux_IA32_RH_EL4_Update3 either AS or WS
> I have a few (actually four) device drivers for different type of devices.
> These drivers compile and run fine on any 2.4.x kernels for both desktops/workstations and servers.
> The same drivers run fine on desktops/workstations and on slected servers, like IA64 Itanium servers, AMD64 servers, however I can't make it run on IA32 servers.
> I've noticed one common among all IA32 servers drivers won't run. All of them have dual processors motherboard with only one processor installed.
> The actual problem is: the first kernel function call from the driver (I'm running "insmod drivername" that calls driver_init function) cause kernel to panic.
> I believe the problem is either with kernel configuration/setup or with development environment configuration/setup.
> Any help/ideas are greatly appretiated. Below are part of a source code and related part of /var/log/messages. Please let me know if more information needed
> 
> Regards,

you forgot to put a URL to your source code.......

however it strongly points towards a broken Makefile on your side.... if
we'd have that URL I could say for sure ..


