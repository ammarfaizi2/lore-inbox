Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbTAXJPj>; Fri, 24 Jan 2003 04:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267615AbTAXJPj>; Fri, 24 Jan 2003 04:15:39 -0500
Received: from mail.bmlv.gv.at ([193.171.152.37]:54413 "HELO mail.bmlv.gv.at")
	by vger.kernel.org with SMTP id <S267613AbTAXJPi> convert rfc822-to-8bit;
	Fri, 24 Jan 2003 04:15:38 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: bh@sgi.com
Subject: arch/ia64/sn/io/hcl.c debug bug
Date: Fri, 24 Jan 2003 10:25:03 +0100
User-Agent: KMail/1.4.3
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301241025.03955.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bent, hi Ingo,

I found a debug bug :-)

I took this email-adresses as they are the 
only ones in MAINTAINERS listed for an SGI.
Sorry if I've told the wrong people.


Regards,

Phil



diff -u linux-2.5.59.orig/./arch/ia64/sn/io/hcl.c linux-2.5.59/./arch/ia64/sn/io/hcl.c
-- linux-2.5.59.orig/./arch/ia64/sn/io/hcl.c       Fri Jan 24 10:19:44 2003
+++ linux-2.5.59/./arch/ia64/sn/io/hcl.c   Fri Jan 24 10:19:46 2003
@@ -1257,7 +1257,7 @@
         * It does not make any sense to call this on vertexes with multiple
         * inventory structs chained together
         */
-       if ( device_inventory_get_next(device, &invplace) != NULL ) {
+       if ( device_inventory_get_next(device, &invplace) != NULL )
                printk("Should panic here ... !\n");
 #endif
        return (val);



