Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbTLSXRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 18:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTLSXRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 18:17:22 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11250 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263700AbTLSXRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 18:17:20 -0500
Date: Sat, 20 Dec 2003 00:17:12 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6: modular scsi/mca_53c9x doesn't work
Message-ID: <20031219231712.GB12750@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following mesage when trying to build modular a mca_53c9x in 
2.6.0-test11-mm1:

<--  snip  -->

...
*** Warning: "esp_reset" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esp_abort" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esp_queue" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esps_in_use" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esp_initialize" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esp_allocate" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esp_intr" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esp_deallocate" [drivers/scsi/mca_53c9x.ko] undefined!
...

<--  snip  -->

It seems there are some EXPORT_SYMBOL's needed in NCR53C9x.c?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

