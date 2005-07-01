Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVGAOlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVGAOlK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 10:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbVGAOlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 10:41:10 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:28934 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261284AbVGAOlG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 10:41:06 -0400
Date: Fri, 1 Jul 2005 16:41:08 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Sebastian Pigulak <dreamin@interia.pl>, linux-kernel@vger.kernel.org,
       Sebastian Witt <se.witt@gmx.net>, Greg KH <greg@kroah.com>,
       lm-sensors@lm-sensors.org
Subject: Re: [2.6 patch] SENSORS_ATXP1 must select I2C_SENSOR
Message-Id: <20050701164108.0bc4e364.khali@linux-fr.org>
In-Reply-To: <20050630221727.GE27478@stusta.de>
References: <20050630234709.1ad1512a@DreaM.darnet>
	<20050630221727.GE27478@stusta.de>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> > I've tried patching linux-2.6.13-RC1 with patch-2.6.13-rc1-git2 and
> > building atxp1(it allows Vcore voltage changing) into the kernel.
> > Unfortunately, the kernel compilation stops with:
> > 
> > LD      init/built-in.o
> > LD      vmlinux
> > drivers/built-in.o(.text+0x92298): In function `atxp1_detect':
> > : undefined reference to `i2c_which_vrm'
> > drivers/built-in.o(.text+0x921ae): In function
> > `atxp1_attach_adapter': : undefined reference to `i2c_detect'
> > make: *** [vmlinux] B??d 1
> > ==> ERROR: Build Failed.  Aborting... 
> > 
> > Could someone have a look at the module and possibly fix it up?
> 
> The patch below should fix it.

Good catch. However, this fix will conflict with a larger patch I am
working on (moving hardware monitoring drivers to a different directory
[1]), so I applied a different fix on top of my own stack, and will send
all this stuff to Greg as soon as possible.

[1] http://lkml.org/lkml/2005/6/27/302

Thanks,
-- 
Jean Delvare
