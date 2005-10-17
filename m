Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVJQR4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVJQR4Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVJQR4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:56:24 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:33646 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751074AbVJQR4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:56:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DHtIjsOoEbGVujFPEy7wQF9I+/a4Dfa1rKH+alPVE07qx6byNWBSZpYp2bXaXeVJ1Yi5c8oD0InTmwEexdNiVsN+8IKpv5b40X9A+oCr5wEfQV4NM/lxrs7XT+1JLYGqyL0cQChUmvm8cBuw6Usz8PgY+sfCSBNbPghqSTEgi2s=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: [PATCH] fix implicit declaration compile warning in qla2xxx
Date: Mon, 17 Oct 2005 19:59:23 +0200
User-Agent: KMail/1.8.2
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171959.23585.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix warning about implicitly declared function in qla_rscn.c
  drivers/scsi/qla2xxx/qla_rscn.c:334: warning: implicit declaration of function `fc_remote_port_unblock'

From: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/scsi/qla2xxx/qla_rscn.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.14-rc4-mm1-orig/drivers/scsi/qla2xxx/qla_rscn.c	2005-10-11 22:41:20.000000000 +0200
+++ linux-2.6.14-rc4-mm1/drivers/scsi/qla2xxx/qla_rscn.c	2005-10-17 19:53:50.000000000 +0200
@@ -17,6 +17,7 @@
  *
  */
 #include "qla_def.h"
+#include <scsi/scsi_transport_fc.h>
 
 /**
  * IO descriptor handle definitions.





/Jesper Juhl


PS. 
 Please CC me on replies.


