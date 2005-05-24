Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVEXQfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVEXQfw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVEXQaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:30:17 -0400
Received: from web88008.mail.re2.yahoo.com ([206.190.37.195]:28810 "HELO
	web88008.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262137AbVEXQ1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:27:13 -0400
Message-ID: <20050524162710.55401.qmail@web88008.mail.re2.yahoo.com>
Date: Tue, 24 May 2005 12:27:10 -0400 (EDT)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: [PATCH][2.6.12-rc4][SATA] sil driver - Blacklist Maxtor disk
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I know we shouldn't do this, but at the current
time, this seems to fix DMA READ/WRITE timeout
problems. This also may fix the sata_nv driver as
well, but this seems indicate that there is a lowlevel
problem with the SATA subsystem. 

Signed-off-by: Shawn Starr <shawn.starr@rogers.com>

--- sata_sil.c.old      2005-05-24 12:19:20.312197269
-0400
+++ sata_sil.c  2005-05-11 14:05:26.000000000 -0400
@@ -93,6 +93,7 @@ struct sil_drivelist {
        { "ST380011ASL",        SIL_QUIRK_MOD15WRITE
},
        { "ST3120022ASL",       SIL_QUIRK_MOD15WRITE
},
        { "ST3160021ASL",       SIL_QUIRK_MOD15WRITE
},
+       { "Maxtor 6Y080M0",     SIL_QUIRK_MOD15WRITE
},
        { "Maxtor 4D060H3",     SIL_QUIRK_UDMA5MAX },
        { }
 };

