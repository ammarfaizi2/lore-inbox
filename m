Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUHELwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUHELwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267657AbUHELwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:52:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40913 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267653AbUHELt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:49:56 -0400
Date: Thu, 5 Aug 2004 13:49:49 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: 2.6.8-rc3-mm1: ALSA: vortex_asXtalkGainsAllChan multiple definitions
Message-ID: <20040805114949.GE2746@fs.tum.de>
References: <20040805031918.08790a82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805031918.08790a82.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
>...
> All 450 patches
>...
> bk-alsa.patch
>...

The following compile error is still present in 2.6.8-rc3-mm1:

<--  snip  -->

...
  CC      sound/pci/au88x0/au8810.o
  CC      sound/pci/au88x0/au8820.o
  CC      sound/pci/au88x0/au8830.o
  LD      sound/pci/au88x0/snd-au8810.o
  LD      sound/pci/au88x0/snd-au8820.o
  LD      sound/pci/au88x0/snd-au8830.o
  LD      sound/pci/au88x0/built-in.o
sound/pci/au88x0/snd-au8830.o(.rodata+0xd46): multiple definition of 
`vortex_asXtalkGainsAllChan'
sound/pci/au88x0/snd-au8810.o(.rodata+0xb66): first defined here
make[3]: *** [sound/pci/au88x0/built-in.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

