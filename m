Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263462AbUJ3D0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbUJ3D0W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 23:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbUJ3D0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 23:26:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58890 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263462AbUJ3DY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 23:24:58 -0400
Date: Sat, 30 Oct 2004 05:24:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Sylvain Meyer <sylvain.meyer@worldonline.fr>,
       Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: 2.6.10-rc1-mm2: intelfb/AGP unknown symbols
Message-ID: <20041030032425.GI6677@stusta.de>
References: <20041029014930.21ed5b9a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029014930.21ed5b9a.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 01:49:30AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.10-rc1-mm1:
> 
>  linus.patch
>...
>  bk-agpgart.patch
>...


The removal of 3 "unneeded exports" in bk-agpgart.patch conflicts with 
code adding usage of them in Linus' tree:


<--  snip  -->

...
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.10-rc1-mm2; fi
WARNING: /lib/modules/2.6.10-rc1-mm2/kernel/drivers/video/intelfb/intelfb.ko needs unknown symbol agp_backend_acquire
WARNING: /lib/modules/2.6.10-rc1-mm2/kernel/drivers/video/intelfb/intelfb.ko needs unknown symbol agp_copy_info
WARNING: /lib/modules/2.6.10-rc1-mm2/kernel/drivers/video/intelfb/intelfb.ko needs unknown symbol agp_backend_release
WARNING: /lib/modules/2.6.10-rc1-mm2/kernel/drivers/video/i810/i810fb.ko needs unknown symbol agp_backend_acquire
WARNING: /lib/modules/2.6.10-rc1-mm2/kernel/drivers/video/i810/i810fb.ko needs unknown symbol agp_backend_release

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

