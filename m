Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVEXRQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVEXRQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVEXRQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:16:16 -0400
Received: from mailtir.platform.com ([192.219.104.248]:63112 "EHLO
	mailtir.platform.com") by vger.kernel.org with ESMTP
	id S261292AbVEXRNh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 13:13:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [PATCH][2.6.12-rc4][SATA] sil driver - Blacklist Maxtor disk - Redux
Date: Tue, 24 May 2005 13:13:35 -0400
Message-ID: <9CD190F4AD92EC499A9397F49C8B0E4E01E8EC86@catoexm04.noam.corp.platform.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6.12-rc4][SATA] sil driver - Blacklist Maxtor disk - Redux
Thread-Index: AcVgg+tEBK6y3aySSr+Ad2Hg/rHThQ==
From: "Shawn Starr" <sstarr@platform.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-ide@vger.kernel.org>, <jgarzik@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I know we shouldn't do this, but at the current
time, this seems to fix DMA READ/WRITE timeout
problems. This also may fix the sata_nv driver as
well, but this seems indicate that there is a lowlevel
problem with the SATA subsystem. 

Signed-off-by: Shawn Starr <shawn.starr@rogers.com>

--- sata_sil.c.old      2005-05-24 12:19:20.312197269 -0400
+++ sata_sil.c  2005-05-11 14:05:26.000000000 -0400
@@ -93,6 +93,7 @@ struct sil_drivelist {
        { "ST380011ASL",        SIL_QUIRK_MOD15WRITE },
        { "ST3120022ASL",       SIL_QUIRK_MOD15WRITE },
        { "ST3160021ASL",       SIL_QUIRK_MOD15WRITE },
+       { "Maxtor 6Y080M0",     SIL_QUIRK_MOD15WRITE },
        { "Maxtor 4D060H3",     SIL_QUIRK_UDMA5MAX },
        { }
 };
