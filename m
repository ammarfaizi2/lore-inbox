Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUJIUvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUJIUvf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267396AbUJIUss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:48:48 -0400
Received: from web13725.mail.yahoo.com ([66.163.176.64]:2194 "HELO
	web13725.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267404AbUJIUo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:44:29 -0400
Message-ID: <20041009204425.49483.qmail@web13725.mail.yahoo.com>
Date: Sat, 9 Oct 2004 13:44:25 -0700 (PDT)
From: Martins Krikis <mkrikis@yahoo.com>
Subject: [Announce] "iswraid" (ICH5R/ICH6R ataraid sub-driver) for 2.4.28-pre3
To: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Cc: mkrikis@yahoo.com
In-Reply-To: <87d5zzfds7.fsf@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 0.1.4.3 of the Intel Sofware RAID driver (iswraid) is now
available for the 2.4 series kernels at
http://prdownloads.sourceforge.net/iswraid/2.4.28-pre3-iswraid.patch.gz?download

It is an ataraid "subdriver" but uses the SCSI subsystem to find the
RAID member disks. It depends on the libata library, particularly the
ata_piix driver that enables the Serial ATA capabilities in ICH5/ICH6
chipsets. Hence, for kernels older than 2.4.28, the libata patch by 
Jeff Garzik should be applied before applying this patch. There is 
more information and some ICH6R related patches at the project's home
page at http://iswraid.sourceforge.net/. The patch applies cleanly to
2.4.28-pre4 as well, and hopefully can be applied to any 2.4 kernel
without too much difficulty. 

The changes WRT version 0.1.4 are the following:
* Different buffer_head b_state bit used for IOs submitted
  to the mirror.
* Disk sizing problem for disks with odd number of sectors fixed.
* Entering degraded mode with many outstanding IOs fixed. 

Please consider this driver for inclusion in the 2.4 kernel tree.

Driver documentation is included in Documentation/iswraid.txt,
which is part of the patch. The license is GPL. I have added
myself to the MAINTAINERS list, please feel free to throw me
out if you don't think I should have done that.

Please let me know if there is anything else I can do to make
this driver acceptable for the 2.4 kernel.
 
   Martins Krikis
   Storage Components Division
   Intel Massachusetts



		

