Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTFXRhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTFXRhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:37:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:722 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262456AbTFXRhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:37:38 -0400
Date: Tue, 24 Jun 2003 19:51:38 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Geert Uytterhoeven <geert@linux-m68k.org>, trivial@rustcorp.com.au
Subject: [PATCH] NCR53C9x compile fix (fwd)
Message-ID: <20030624175138.GX3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below is still needed in 2.5.73.

Please apply
Adrian


----- Forwarded message from Geert Uytterhoeven <geert@linux-m68k.org> -----

Date:	Sun, 15 Jun 2003 20:38:40 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
    Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] NCR53C9x compile fix

NCR53C9x SCSI: Fix compilation after breakage in 2.5.71

--- linux-2.5.x/drivers/scsi/NCR53C9x.c	Sun Jun 15 10:04:26 2003
+++ linux-m68k-2.5.x/drivers/scsi/NCR53C9x.c	Sun Jun 15 11:49:32 2003
@@ -893,7 +893,7 @@
 int esp_proc_info(struct Scsi_Host *shost, char *buffer, char **start, off_t offset, int length,
 		  int inout)
 {
-	struct NCR_ESP *esp = (struct NCR_ESP *) SCpnt->device->host->hostdata;
+	struct NCR_ESP *esp = (struct NCR_ESP *)shost->hostdata;
 
 	if(inout)
 		return -EINVAL; /* not yet */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

----- End forwarded message -----
