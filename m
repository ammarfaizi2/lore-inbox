Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264866AbUEKQfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264866AbUEKQfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbUEKQfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:35:10 -0400
Received: from tench.street-vision.com ([212.18.235.100]:19174 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S264866AbUEKQeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:34:22 -0400
Subject: Re: sata_sil bug
From: Justin Cormack <justin@street-vision.com>
To: T.Maguin@web.de
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <200405110953.36293.T.Maguin@web.de>
References: <200405110953.36293.T.Maguin@web.de>
Content-Type: text/plain
Message-Id: <1084293259.15715.12.camel@lotte.street-vision.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 11 May 2004 17:34:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 08:53, Thomas Maguin wrote:
> Justin Cormack wrote:
> 
> > ata1: DMA timeout, stat 0x0
> > ATA: abnormal status 0xD8 on port 0xF8807087
> > scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x2a 00 17 9b d9 80 00 00
> > 20 00
> > Current sda: sense = 70  3
> > ASC= c ASCQ= 2
> > Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> > 0x00 0x0c
> > end_request: I/O error, dev sda, sector 396089728
> > ATA: abnormal status 0xD8 on port 0xF8807087
> > ATA: abnormal status 0xD8 on port 0xF8807087
> > ATA: abnormal status 0xD8 on port 0xF8807087
> > 
> 
> I was able to produce this error on my system too. It occured for me, when I 
> compiled the ide interface of sil_3112 as a modul in to my kernel, although I 
> was using the libata driver for my harddisks. I lost more then five times my 
> sdb drive. After removing the ide modul, the system was rock stable again.

I definitely didnt have sii3112 as a module. I get this happening very
very rarely. Still wonder if it might be the SiI3112 bug for which there
is a watchdog workaround - any idea if this is the case Jeff? It is
quite hard to repeat as it happened on a faulty disk and they tend to
remap sectors eventually...

Justin


