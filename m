Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932815AbWJINh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932815AbWJINh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 09:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932814AbWJINh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 09:37:59 -0400
Received: from server6.greatnet.de ([83.133.96.26]:36517 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932812AbWJINh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 09:37:58 -0400
Message-ID: <452A50DA.102@nachtwindheim.de>
Date: Mon, 09 Oct 2006 15:38:34 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Cc: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: Scsi_Cmnd convertion in aic7xxx_old.c
References: <452363DB.60107@nachtwindheim.de> <20061006202913.GA7835@aepfle.de>
In-Reply-To: <20061006202913.GA7835@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a typo in the aic7xxx_old.c.
Signed-off-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---
Damn!
Thanks Olaf!

diff --git a/drivers/scsi/aic7xxx_old.c b/drivers/scsi/aic7xxx_old.c
index 7f0adf9..d9cc3fe 100644
--- a/drivers/scsi/aic7xxx_old.c
+++ b/drivers/scsi/aic7xxx_old.c
@@ -2646,7 +2646,7 @@ static void aic7xxx_done_cmds_complete(s
 
 	while (p->completeq.head != NULL) {
 		cmd = p->completeq.head;
-		p->completeq.head = (struct scsi_Cmnd *) cmd->host_scribble;
+		p->completeq.head = (struct scsi_cmnd *) cmd->host_scribble;
 		cmd->host_scribble = NULL;
 		cmd->scsi_done(cmd);
 	}


