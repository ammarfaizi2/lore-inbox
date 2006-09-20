Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWITLWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWITLWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 07:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWITLWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 07:22:13 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:60585 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751130AbWITLWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 07:22:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Omif3DUwnkTWwN16vJWeLvM4Z1BCYTAdtGf+AiS2fs7yKb7mp24uz6hBrRetzXbOnD377UGFYl1BFy0y79tF5XChK5JKUGppxEnFUGe4eLzGhXcBErj7JWbzCvRNlVSmCUW6TLXl4WHY7SsTqdWT/+i1W5yr3lc+8SHVv9NvB7c=
Message-ID: <1b270aae0609200422h511d1169na201cdeaee05a24a@mail.gmail.com>
Date: Wed, 20 Sep 2006 13:22:09 +0200
From: "Metathronius Galabant" <m.galabant@googlemail.com>
To: iss_storagedev@hp.com
Subject: [PATCH]: cciss - remove unneeded spaces in output for attached volumes (resend)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please see the following patch against the cciss driver (HP/Compaq
SmartArray Controllers).
It removes the awkwards spaces after the "=" when displaying the
geometry of the attached volumes.

Before:
cciss: using DAC cycles
     blocks= 286734240 block_size= 512
     heads= 255, sectors= 32, cylinders= 35139

After:
cciss: using DAC cycles
     blocks=286734240 block_size=512
     heads=255, sectors=32, cylinders=35139


The following is against 2.6.18-rc6 (and I hope gmail doesn't corrupt
the inline patch).
Cheers,
M.


Signed-off-by: Metathronius Galabant <m.galabant@gmail.com>

diff -ru linux-2.6.18-rc6/drivers/block/cciss.c
linux-2.6.18-rc6-f/drivers/block/cciss.c
--- linux-2.6.18-rc6/drivers/block/cciss.c      2006-09-11
15:57:54.000000000 +0200
+++ linux-2.6.18-rc6-f/drivers/block/cciss.c    2006-09-11
16:32:42.000000000 +0200
@@ -1934,7 +1934,7 @@
        } else {                /* Get geometry failed */
                printk(KERN_WARNING "cciss: reading geometry failed\n");
        }
-       printk(KERN_INFO "      heads= %d, sectors= %d, cylinders= %d\n\n",
+       printk(KERN_INFO "      heads=%d, sectors=%d, cylinders=%d\n\n",
               drv->heads, drv->sectors, drv->cylinders);
 }

@@ -1962,7 +1962,7 @@
                *total_size = 0;
                *block_size = BLOCK_SIZE;
        }
-       printk(KERN_INFO "      blocks= %u block_size= %d\n",
+       printk(KERN_INFO "      blocks=%u block_size=%d\n",
               *total_size, *block_size);
        return;
 }
