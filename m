Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264772AbTE1Pm4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbTE1Pm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:42:56 -0400
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:33035 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264772AbTE1Pmx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:42:53 -0400
Date: Wed, 28 May 2003 17:56:04 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70
In-Reply-To: <2CE21B51D37@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.51L.0305281714500.24008@piorun.ds.pg.gda.pl>
References: <2CE21B51D37@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, Petr Vandrovec wrote:
> > Finally - I've started to worry if this kernel will be ever released
> > When building framebuffer driver for my new Matrox G400 I get this
> > error:
> > 
> > scripts/fixdep drivers/video/logo/.logo_linux_clut224.o.d drivers/video/logo/logo_linux_clut224.o 'gcc -Wp,-MD,drivers/video/logo/.logo_linux_clut224.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-protot
> >   LD      drivers/video/logo/built-in.o
> >   CC      drivers/video/matrox/matroxfb_base.o
> > In file included from drivers/video/matrox/matroxfb_base.c:105:
> > drivers/video/matrox/matroxfb_base.h:52: video/fbcon.h: No such file or directory
> I just sent email there yesterday with URL of matroxfb patch I sent to
> Linus for inclusion.

sorry - I haven't seen it...

> ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-stripdown-2.5.70.gz

Tnx - it builds fine now. After I'll be back home I'll check if it works 
:)


There is second problem - some unresolved symbols while make 
modules_install:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.70; fi
WARNING: /lib/modules/2.5.70/kernel/arch/i386/kernel/cpu/cpufreq/powernow-k7.ko needs unknown symbol dmi_broken
WARNING: /lib/modules/2.5.70/kernel/drivers/char/drm/radeon.ko needs unknown symbol mmu_cr4_features
WARNING: /lib/modules/2.5.70/kernel/drivers/char/drm/r128.ko needs unknown symbol mmu_cr4_features
WARNING: /lib/modules/2.5.70/kernel/drivers/char/drm/mga.ko needs unknown symbol mmu_cr4_features
WARNING: /lib/modules/2.5.70/kernel/drivers/char/drm/i830.ko needs unknown symbol mmu_cr4_features
WARNING: /lib/modules/2.5.70/kernel/drivers/char/drm/i810.ko needs unknown symbol mmu_cr4_features
WARNING: /lib/modules/2.5.70/kernel/drivers/char/drm/gamma.ko needs unknown symbol mmu_cr4_features
WARNING: /lib/modules/2.5.70/kernel/drivers/char/agp/nvidia-agp.ko needs unknown symbol agp_memory_reserved

My kernel config:
http://piorun.ds.pg.gda.pl/~blues/config-2.5.70.txt

-- 
pozdr.  Pawe³ Go³aszewski 
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
