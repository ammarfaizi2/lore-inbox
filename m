Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbWGKFNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWGKFNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 01:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWGKFNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 01:13:51 -0400
Received: from xenotime.net ([66.160.160.81]:3733 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965165AbWGKFNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 01:13:49 -0400
Date: Mon, 10 Jul 2006 22:16:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Matt Reuther <mreuther@umich.edu>, perex@suse.cz
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound-miro unknown symbols (Depmod errors on
 2.6.17.4/2.6.18-rc1/2.6.18-rc1-mm1)
Message-Id: <20060710221637.d6612823.rdunlap@xenotime.net>
In-Reply-To: <200607102327.38426.mreuther@umich.edu>
References: <200607100833.00461.mreuther@umich.edu>
	<20060710113212.5ddn42t40ks44s00@engin.mail.umich.edu>
	<44B27931.30609@gmail.com>
	<200607102327.38426.mreuther@umich.edu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/sound/isa/opti9xx/snd-miro.ko 
> needs unknown symbol snd_cs4231_create
> WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/sound/isa/opti9xx/snd-miro.ko 
> needs unknown symbol snd_cs4231_pcm
> WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/sound/isa/opti9xx/snd-miro.ko 
> needs unknown symbol snd_cs4231_timer
> WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/sound/isa/opti9xx/snd-miro.ko 
> needs unknown symbol snd_cs4231_mixer
> WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/fs/reiser4/reiser4.ko needs 
> unknown symbol generic_file_read

Someone posted a patch for the reiser4 function-name conversion.

Here is a patch for the snd-miro driver references.

---
From: Randy Dunlap <rdunlap@xenotime.net>

Fix undefined (missing) references in ISA MIRO sound driver.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 sound/isa/cs423x/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- linux-2618-rc1mm1.orig/sound/isa/cs423x/Makefile
+++ linux-2618-rc1mm1/sound/isa/cs423x/Makefile
@@ -11,6 +11,7 @@ snd-cs4236-objs := cs4236.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_AZT2320) += snd-cs4231-lib.o
+obj-$(CONFIG_SND_MIRO) += snd-cs4231-lib.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-cs4231-lib.o
 obj-$(CONFIG_SND_CS4231) += snd-cs4231.o snd-cs4231-lib.o
 obj-$(CONFIG_SND_CS4232) += snd-cs4232.o snd-cs4231-lib.o
