Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTLOLjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 06:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTLOLjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 06:39:31 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47582 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262776AbTLOLja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 06:39:30 -0500
Date: Mon, 15 Dec 2003 12:39:24 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: RunNHide <res0g1ta@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 intio.o build errors
Message-ID: <20031215113923.GJ23184@fs.tum.de>
References: <3FD918D8.7020100@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD918D8.7020100@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 08:24:40PM -0500, RunNHide wrote:
> okay - I'm not a n00b but I'm no C programmer or driver developer, 
> either - figured I'd post this - understand there's not a lot of this 
> hardware out there so maybe this will be helpful:
> 
>  CC [M]  drivers/scsi/ini9100u.o
> drivers/scsi/ini9100u.c:111:2: #error Please convert me to 
> Documentation/DMA-mapping.txt
> drivers/scsi/ini9100u.c:146: warning: initialization from incompatible 
> pointer type
> drivers/scsi/ini9100u.c:151: warning: initialization from incompatible 
> pointer type
> drivers/scsi/ini9100u.c:152: warning: initialization from incompatible 
> pointer type
> drivers/scsi/ini9100u.c: In function `i91uAppendSRBToQueue':
> drivers/scsi/ini9100u.c:241: error: structure has no member named `next'
> drivers/scsi/ini9100u.c:246: error: structure has no member named `next'
> drivers/scsi/ini9100u.c: In function `i91uPopSRBFromQueue':
> drivers/scsi/ini9100u.c:268: error: structure has no member named `next'
> drivers/scsi/ini9100u.c:269: error: structure has no member named `next'
> drivers/scsi/ini9100u.c: In function `i91uBuildSCB':
> drivers/scsi/ini9100u.c:507: error: structure has no member named `address'
> drivers/scsi/ini9100u.c:516: error: structure has no member named `address'
> make[2]: *** [drivers/scsi/ini9100u.o] Error 1
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2

This is a known problem.

The driver is marked BROKEN in the Kconfig file, and you were only able 
to choose it since you said "no" to
  Select only drivers expected to compile cleanly
.

Unless someone fixes this driver it will not be available in kernel 2.6.

> Thanks,
> RunNHide

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

