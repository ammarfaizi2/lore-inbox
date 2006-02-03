Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945980AbWBCVZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945980AbWBCVZL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945983AbWBCVZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:25:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9486 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945982AbWBCVZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:25:10 -0500
Date: Fri, 3 Feb 2006 22:25:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, bcollins@debian.org, scjody@modernduck.com
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.ne,
       sam@ravnborg.org
Subject: 2.6.16-rc1-mm5: drivers/ieee1394/oui O=... builds broken
Message-ID: <20060203212507.GR4408@stusta.de>
References: <20060203000704.3964a39f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203000704.3964a39f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 12:07:04AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm4:
>...
>  git-ieee1394.patch
>...
>  Git trees
>...

<--  snip  -->

...
  OUI2C   drivers/ieee1394/oui.c
/bin/sh: drivers/ieee1394/oui2c.sh: No such file or directory
make[3]: *** [drivers/ieee1394/oui.c] Error 127

<--  snip  -->


The change that broke it is:


 quiet_cmd_oui2c = OUI2C   $@
-      cmd_oui2c = $(CONFIG_SHELL) $(srctree)/$(src)/oui2c.sh < $< > $@
+      cmd_oui2c = $(CONFIG_SHELL) $(src)/oui2c.sh < $< > $@


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

