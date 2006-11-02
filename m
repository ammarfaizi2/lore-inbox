Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752213AbWKBMLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbWKBMLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 07:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbWKBMLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 07:11:46 -0500
Received: from qb-out-0506.google.com ([72.14.204.226]:26550 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752195AbWKBMLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 07:11:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FsESH1fWNtFRBv3ovR0Y2qQUX79Ranm4CJyAQbfWLoD+jNcMog7q52oIrrD9j+cuVlO1NB1YgRf/3oeBPq29U7uSCW2+14ZbGTc7h9Ja2kOjS9cGJYPwPdHCZZuo4QvW3B8KIAZZV76SlwGhG83bqtmqKAm396Pz4DM+p0HKzX4=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Len Brown <len.brown@intel.com>
Subject: [PATCH][Trivial] ACPI: Get rid of 'unused variable' warning in  acpi_ev_global_lock_handler()
Date: Thu, 2 Nov 2006 13:13:22 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       trivial@kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611021313.22709.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this warning : 
  drivers/acpi/events/evmisc.c: In function `acpi_ev_global_lock_handler':
  drivers/acpi/events/evmisc.c:334: warning: unused variable `status'


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/acpi/events/evmisc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index ee2a10b..bf63edc 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -331,7 +331,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_gl
 static u32 acpi_ev_global_lock_handler(void *context)
 {
 	u8 acquired = FALSE;
-	acpi_status status;
 
 	/*
 	 * Attempt to get the lock


