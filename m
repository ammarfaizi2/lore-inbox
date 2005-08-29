Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVH2XO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVH2XO7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVH2XO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:14:59 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:22879 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751339AbVH2XO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:14:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AeQUM5KZHyHeMY6PB7Ab9uHNtpdMrqmJyVtTol77eplN0freRXLl3htQENuNm0Bsr6xueFVinp9OVqgKgCZ1KAtaMl8t+OnH69QR7NdvpQmR38IdyNtqn6ocqsqKbv9MHk+PpTACfGT+c/5bY4ZQQoWbBJ9nmqu8xeIN8XJej08=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix compiler warning in aic7770
Date: Tue, 30 Aug 2005 01:15:36 +0200
User-Agent: KMail/1.8.2
Cc: linux-scsi@vger.kernel.org, James.Bottomley@steeleye.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508300115.47618.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compiler warning in drivers/scsi/aic7xxx/aic7770.c : 
   drivers/scsi/aic7xxx/aic7770.c:129: warning: unused variable `l'

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/scsi/aic7xxx/aic7770.c |    1 -
 1 files changed, 1 deletion(-)

--- linux-2.6.13-orig/drivers/scsi/aic7xxx/aic7770.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/drivers/scsi/aic7xxx/aic7770.c	2005-08-30 01:08:22.000000000 +0200
@@ -126,7 +126,6 @@ aic7770_find_device(uint32_t id)
 int
 aic7770_config(struct ahc_softc *ahc, struct aic7770_identity *entry, u_int io)
 {
-	u_long	l;
 	int	error;
 	int	have_seeprom;
 	u_int	hostconf;

