Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVK3C0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVK3C0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVK3C0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:26:55 -0500
Received: from utopia.booyaka.com ([206.168.112.107]:9113 "EHLO
	utopia.booyaka.com") by vger.kernel.org with ESMTP id S1750804AbVK3C0y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:26:54 -0500
Date: Tue, 29 Nov 2005 19:26:54 -0700 (MST)
From: Paul Walmsley <paul@booyaka.com>
To: mdharm-usb@one-eyed-alien.net, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] usb-storage: add debug entry for REPORT LUNS
Message-ID: <Pine.LNX.4.63.0511291923380.20294@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bugs involving the REPORT LUNS SCSI-3 command are much easier to track down
if usb-storage displays the command's name, rather than "(Unknown command)".

Signed-off-by: Paul Walmsley <paul@booyaka.com>


- Paul

diff --git a/drivers/usb/storage/debug.c b/drivers/usb/storage/debug.c
index 5a93217..bfc5054 100644
--- a/drivers/usb/storage/debug.c
+++ b/drivers/usb/storage/debug.c
@@ -132,6 +132,7 @@ void usb_stor_show_command(struct scsi_c
  	case 0x5C: what = "READ BUFFER CAPACITY"; break;
  	case 0x5D: what = "SEND CUE SHEET"; break;
  	case GPCMD_BLANK: what = "BLANK"; break;
+	case REPORT_LUNS: what = "REPORT LUNS"; break;
  	case MOVE_MEDIUM: what = "MOVE_MEDIUM or PLAY AUDIO (12)"; break;
  	case READ_12: what = "READ_12"; break;
  	case WRITE_12: what = "WRITE_12"; break;
