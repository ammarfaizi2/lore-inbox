Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUGIEiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUGIEiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 00:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUGIEiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 00:38:12 -0400
Received: from web13702.mail.yahoo.com ([216.136.175.135]:54535 "HELO
	web13702.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264085AbUGIEiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 00:38:05 -0400
Message-ID: <20040709043804.50539.qmail@web13702.mail.yahoo.com>
Date: Thu, 8 Jul 2004 21:38:04 -0700 (PDT)
From: Martins Krikis <mkrikis@yahoo.com>
Subject: [Announce] "iswraid" (ICH5R/ICH6R ataraid sub-driver) for 2.4.26
To: linux-kernel@vger.kernel.org, linux-kernel-announce@vger.kernel.org
Cc: mkrikis@yahoo.com
In-Reply-To: <20040221024833.16640.qmail@web13707.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 0.1.4 of the Intel Sofware RAID driver (iswraid) is now
available for the 2.4 series kernels at
http://prdownloads.sourceforge.net/iswraid/2.4.26-libata-iswraid.patch.gz?download

It is an ataraid "subdriver" but uses the SCSI subsystem to find the
RAID member disks. It depends on the libata library, particularly the
ata_piix driver that enables the Serial ATA capabilities in ICH5/ICH6
chipsets. The libata patch by Jeff Garzik should be applied before
applying this patch. There is more information and some ICH6R related
patches at the project's home page at http://iswraid.sourceforge.net/.

The changes WRT version 0.1.3 are as follows:
* a fix for CONFIG_HIGHMEM systems; 
* reasonable handling of missing disks; 
* when RAID1 goes degraded, the I/O succeeds; 
* new mode that does not fail degraded RAID1 ever; 
* metadata updates started from the scheduler's queue; 
* slab caches instead of kmalloc-s; 
* small /proc filesystem tweaks; 
* serial number extraction fixed; 
* unused disks properly freed; 
* added documentation file; 
* major style changes and more comments about implementation choices.

If you have any questions or comments, please CC me directly because
I no longer read this list.

           Martins Krikis
           Storage Components Division (SCD)
           Intel Massachusetts



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - Helps protect you from nasty viruses.
http://promotions.yahoo.com/new_mail
