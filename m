Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWARAWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWARAWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWARAWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:22:15 -0500
Received: from mx15.sac.fedex.com ([199.81.195.17]:1296 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP id S932436AbWARAWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:22:12 -0500
Date: Wed, 18 Jan 2006 08:22:53 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1 -- which gcc version?
In-Reply-To: <Pine.LNX.4.64.0601170946050.3240@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0601180810270.29057@boston.corp.fedex.com>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
 <20060117183916.399b030f.diegocg@gmail.com> <Pine.LNX.4.64.0601170946050.3240@g5.osdl.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/18/2006
 08:22:07 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/18/2006
 08:22:09 AM,
	Serialize complete at 01/18/2006 08:22:09 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Which gcc version should I use, now that gcc-2.95.3 can't compile
2.6.16-rc1 anymore? gcc-3.3 as mentioned in the patch?

Thanks,
Jeff.



On Tuesday 17 January 2006 03:19, Linus Torvalds wrote:
>Ok, it's two weeks since 2.6.15, and the merge window is closed.


diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 04d3082..0abbce8 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
-#error    Known good compilers: 2.95.3, 2.95.4, 2.96, 3.3
+#error    Known good compilers: 3.3


diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d737821..f23d3c6 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -42,8 +42,6 @@ extern void __chk_io_ptr(void __iomem *)
  # include <linux/compiler-gcc4.h>
  #elif __GNUC__ == 3
  # include <linux/compiler-gcc3.h>
-#elif __GNUC__ == 2
-# include <linux/compiler-gcc2.h>
  #else
  # error Sorry, your compiler is too old/not recognized.
  #endif

