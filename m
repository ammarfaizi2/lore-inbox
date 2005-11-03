Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVKCOb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVKCOb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVKCOb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:31:56 -0500
Received: from agmk.net ([217.73.31.34]:13581 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S1751330AbVKCOb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:31:56 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [2.6.14-rt4] / fix `"tsc_c3_compensate" [drivers/acpi/processor.ko] undefined!`
Date: Thu, 3 Nov 2005 15:31:51 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031531.52755.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Please merge attached apatch into next -rt release.


--- a/arch/x86_64/kernel/time.c 2005-11-02 23:33:39.000000000 +0100
+++ b/arch/x86_64/kernel/time.c 2005-11-03 00:32:06.000000000 +0100
@@ -1037,6 +1037,8 @@
        tsc_c3_offset += cycles;
 }

+EXPORT_SYMBOL_GPL(tsc_c3_compensate);
+
 static inline u64 tsc_read_c3_time(void)
 {
        return tsc_c3_offset;

-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke
