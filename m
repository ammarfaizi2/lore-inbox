Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131455AbRC0RIX>; Tue, 27 Mar 2001 12:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131459AbRC0RIN>; Tue, 27 Mar 2001 12:08:13 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:64272
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131455AbRC0RII>; Tue, 27 Mar 2001 12:08:08 -0500
Date: Tue, 27 Mar 2001 09:06:48 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Uncle George <gatgul@voicenet.com>
cc: linux-kernel@vger.kernel.org, Jeremy Jackson <jerj@coplanar.net>
Subject: Re: slow latencies on IDE disk drives( controller? )
In-Reply-To: <3AC080F3.6A09863C@voicenet.com>
Message-ID: <Pine.LNX.4.10.10103270904490.16125-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


#define PCI_VENDOR_ID_CONTAQ            0x1080
#define PCI_DEVICE_ID_CONTAQ_82C599     0x0600
#define PCI_DEVICE_ID_CONTAQ_82C693     0xc693

 * linux/drivers/block/cy82c693.c       Version 0.34    Dec. 13, 1999
 *
 *  Copyright (C) 1998-99 Andreas S. Krebs (akrebs@altavista.net), Maintainer
 *  Copyright (C) 1998-99 Andre Hedrick, Integrater

 * Notes:
 * - I recently got a 16.8G IBM DTTA, so I was able to test it with
 *   a large and fast disk - the results look great, so I'd say the
 *   driver is working fine :-)
 *   hdparm -t reports 8.17 MB/sec at about 6% CPU usage for the DTTA
 * - this is my first linux driver, so there's probably a lot  of room
 *   for optimizations and bug fixing, so feel free to do it.
 * - use idebus=xx parameter to set PCI bus speed - needed to calc
 *   timings for PIO modes (default will be 40)
 * - if using PIO mode it's a good idea to set the PIO mode and
 *   32-bit I/O support (if possible), e.g. hdparm -p2 -c1 /dev/hda
 * - I had some problems with my IBM DHEA with PIO modes < 2
 *   (lost interrupts) ?????
 * - first tests with DMA look okay, they seem to work, but there is a
 *   problem with sound - the BusMaster IDE TimeOut should fixed this

This is your fix....

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

