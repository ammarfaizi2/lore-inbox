Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUJIVhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUJIVhq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 17:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUJIVhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 17:37:46 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:23523 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S267449AbUJIVhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 17:37:23 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Martins Krikis <mkrikis@yahoo.com>
Subject: Re: [Announce] "iswraid" (ICH5R/ICH6R ataraid sub-driver) for 2.4.28-pre3
Date: Sat, 9 Oct 2004 23:37:36 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
References: <20041009204425.49483.qmail@web13725.mail.yahoo.com>
In-Reply-To: <20041009204425.49483.qmail@web13725.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410092337.36488.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I may sound like an ignorant but...

Why can't device mapper be merged into 2.4 instead?
Is there something wrong with 2.4 device mapper patch?

It would more convenient (same driver for 2.4 and 2.6)
and would benefit users of other software RAIDs
(easier transition to 2.6).

On Saturday 09 October 2004 22:44, Martins Krikis wrote:
> Version 0.1.4.3 of the Intel Sofware RAID driver (iswraid) is now
> available for the 2.4 series kernels at
> http://prdownloads.sourceforge.net/iswraid/2.4.28-pre3-iswraid.patch.gz?download
> 
> It is an ataraid "subdriver" but uses the SCSI subsystem to find the
> RAID member disks. It depends on the libata library, particularly the
> ata_piix driver that enables the Serial ATA capabilities in ICH5/ICH6
> chipsets. Hence, for kernels older than 2.4.28, the libata patch by 
> Jeff Garzik should be applied before applying this patch. There is 
> more information and some ICH6R related patches at the project's home
> page at http://iswraid.sourceforge.net/. The patch applies cleanly to
> 2.4.28-pre4 as well, and hopefully can be applied to any 2.4 kernel
> without too much difficulty. 
> 
> The changes WRT version 0.1.4 are the following:
> * Different buffer_head b_state bit used for IOs submitted
>   to the mirror.
> * Disk sizing problem for disks with odd number of sectors fixed.
> * Entering degraded mode with many outstanding IOs fixed. 
> 
> Please consider this driver for inclusion in the 2.4 kernel tree.
> 
> Driver documentation is included in Documentation/iswraid.txt,
> which is part of the patch. The license is GPL. I have added
> myself to the MAINTAINERS list, please feel free to throw me
> out if you don't think I should have done that.
> 
> Please let me know if there is anything else I can do to make
> this driver acceptable for the 2.4 kernel.
>  
>    Martins Krikis
>    Storage Components Division
>    Intel Massachusetts
