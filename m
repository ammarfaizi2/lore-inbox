Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbUKJCiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbUKJCiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 21:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbUKJCiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 21:38:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37137 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261847AbUKJCdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 21:33:18 -0500
Date: Wed, 10 Nov 2004 03:32:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] #if 0 cx88_risc_disasm
Message-ID: <20041110023246.GG4089@stusta.de>
References: <20041107175017.GP14308@stusta.de> <20041108114008.GB20607@bytesex> <20041109004341.GO15077@stusta.de> <20041109094648.GB5587@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109094648.GB5587@bytesex>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 10:46:48AM +0100, Gerd Knorr wrote:
>...
> > > moment automatically is useless.  cx88_risc_disasm() for example is
> > > useful for debugging the driver.  And that there is no in-kernel user
> > 
> > But couldn't this be #if 0'ed?
> 
> Yes, it could.
>...


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm4-full/drivers/media/video/cx88/cx88-core.c.old	2004-11-10 02:46:36.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/media/video/cx88/cx88-core.c	2004-11-10 02:47:15.000000000 +0100
@@ -462,6 +462,7 @@
 	return incr[risc >> 28] ? incr[risc >> 28] : 1;
 }
 
+#if 0
 void cx88_risc_disasm(struct cx88_core *core,
 		      struct btcx_riscmem *risc)
 {
@@ -479,6 +480,8 @@
 			break;
 	}
 }
+EXPORT_SYMBOL(cx88_risc_disasm);
+#endif
 
 void cx88_sram_channel_dump(struct cx88_core *core,
 			    struct sram_channel *ch)
@@ -1197,8 +1200,6 @@
 EXPORT_SYMBOL(cx88_risc_stopper);
 EXPORT_SYMBOL(cx88_free_buffer);
 
-EXPORT_SYMBOL(cx88_risc_disasm);
-
 EXPORT_SYMBOL(cx88_sram_channels);
 EXPORT_SYMBOL(cx88_sram_channel_setup);
 EXPORT_SYMBOL(cx88_sram_channel_dump);

