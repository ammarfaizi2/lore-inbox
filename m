Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283268AbRLTKF7>; Thu, 20 Dec 2001 05:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283244AbRLTKFl>; Thu, 20 Dec 2001 05:05:41 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:48900 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S283234AbRLTKFT>;
	Thu, 20 Dec 2001 05:05:19 -0500
Date: Wed, 19 Dec 2001 23:14:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: vt_kern fails to include tty.h
Message-ID: <20011219231408.A5358@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...but it needs MAX_NR_CONSOLES. Here's fix, please apply.
							Pavel

--- clean/include/linux/vt_kern.h	Mon Nov  5 21:43:02 2001
+++ linux-swsusp/include/linux/vt_kern.h	Wed Dec 19 23:10:41 2001
@@ -9,6 +9,7 @@
 #include <linux/config.h>
 #include <linux/vt.h>
 #include <linux/kd.h>
+#include <linux/tty.h>
 
 /*
  * Presently, a lot of graphics programs do not restore the contents of

-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
