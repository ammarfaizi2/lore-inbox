Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751981AbWJABZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbWJABZp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 21:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWJABZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 21:25:45 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55785 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751881AbWJABZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 21:25:44 -0400
Message-ID: <451F1914.9040007@garzik.org>
Date: Sat, 30 Sep 2006 21:25:40 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: SCSI make all{yes,mod}config build breakage
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The block tree merge broke the SCSI build:

   CC [M]  drivers/scsi/libsas/sas_scsi_host.o
In file included from include/scsi/libsas.h:35,
                  from drivers/scsi/libsas/sas_internal.h:32,
                  from drivers/scsi/libsas/sas_scsi_host.c:26:
include/scsi/scsi_device.h: In function ‘scsi_device_reprobe’:
include/scsi/scsi_device.h:303: warning: ignoring return value of 
‘device_reprobe’, declared with attribute warn_unused_result
drivers/scsi/libsas/sas_scsi_host.c: In function ‘sas_scsi_get_task_attr’:
drivers/scsi/libsas/sas_scsi_host.c:129: error: ‘struct request’ has no 
member named ‘flags’

The attached patch (sent in separate email with proper sign-off) fixes 
things.

