Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757664AbWK2Msv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757664AbWK2Msv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 07:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757680AbWK2Msv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 07:48:51 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:3925 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1757664AbWK2Msu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 07:48:50 -0500
Date: Wed, 29 Nov 2006 13:49:27 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch -mm 2/2] s390: Update cio documentation.
Message-ID: <20061129134927.4daaa5c9@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Update documentation for dynamic subchannel mapping.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 Documentation/s390/driver-model.txt |    7 +++++++
 1 files changed, 7 insertions(+)

--- linux-2.6-CH.orig/Documentation/s390/driver-model.txt
+++ linux-2.6-CH/Documentation/s390/driver-model.txt
@@ -18,11 +18,18 @@ devices/
 	   - 0.0.0002/
 	   - 0.1.0000/0.1.1234/
 	   ...
+	   - defunct/
 
 In this example, device 0815 is accessed via subchannel 0 in subchannel set 0,
 device 4711 via subchannel 1 in subchannel set 0, and subchannel 2 is a non-I/O
 subchannel. Device 1234 is accessed via subchannel 0 in subchannel set 1.
 
+The subchannel named 'defunct' does not represent any real subchannel on the
+system; it is a pseudo subchannel where disconnnected ccw devices are moved to
+if they are displaced by another ccw device becoming operational on their
+former subchannel. The ccw devices will be moved again to a proper subchannel
+if they become operational again on that subchannel.
+
 You should address a ccw device via its bus id (e.g. 0.0.4711); the device can
 be found under bus/ccw/devices/.
 
