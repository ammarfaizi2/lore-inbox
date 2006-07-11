Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWGKMrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWGKMrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWGKMrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:47:43 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39953 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751264AbWGKMrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:47:42 -0400
Date: Tue, 11 Jul 2006 14:47:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>,
       Tigran Aivazian <tigran@veritas.com>, Greg KH <greg@kroah.com>
Subject: [-mm patch] MICROCODE should select FW_LOADER
Message-ID: <20060711124741.GM13938@stusta.de>
References: <20060709021106.9310d4d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 02:11:06AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm6:
>...
> +x86-microcode-add-sysfs-and-hotplug-support-fix-fix.patch
> 
>  Fix x86-microcode-add-sysfs-and-hotplug-support.patch some more.
>...

FW_LOADER is a helper variable that should be select'ed.

Please replace this patch with the patch below.

cu
Adrian


<--  snip  -->


MICROCODE requires FW_LOADER.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/Kconfig   |    1 +
 arch/x86_64/Kconfig |    1 +
 2 files changed, 2 insertions(+)

--- linux-2.6.18-rc1-mm1-full/arch/i386/Kconfig.old	2006-07-11 00:12:53.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/arch/i386/Kconfig	2006-07-11 00:13:17.000000000 +0200
@@ -399,6 +399,7 @@
 
 config MICROCODE
 	tristate "/dev/cpu/microcode - Intel IA32 CPU microcode support"
+	select FW_LOADER
 	---help---
 	  If you say Y here and also to "/dev file system support" in the
 	  'File systems' section, you will be able to update the microcode on
--- linux-2.6.18-rc1-mm1-full/arch/x86_64/Kconfig.old	2006-07-11 00:13:30.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/arch/x86_64/Kconfig	2006-07-11 00:13:43.000000000 +0200
@@ -163,6 +163,7 @@
 
 config MICROCODE
 	tristate "/dev/cpu/microcode - Intel CPU microcode support"
+	select FW_LOADER
 	---help---
 	  If you say Y here the 'File systems' section, you will be
 	  able to update the microcode on Intel processors. You will

