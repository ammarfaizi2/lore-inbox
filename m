Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVBFO0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVBFO0V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 09:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVBFO0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 09:26:20 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:16143 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261155AbVBFO0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 09:26:14 -0500
Date: Sun, 6 Feb 2005 15:26:15 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Enrico Bartky <DOSProfi@web.de>, linux-pci@atrey.karlin.mff.cuni.cz
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Maarten Deprez <maartendeprez@scarlet.be>, Greg KH <gregkh@suse.de>
Subject: Re: M7101
Message-Id: <20050206152615.1ab7498c.khali@linux-fr.org>
In-Reply-To: <41DC59A4.1070006@web.de>
References: <41DC59A4.1070006@web.de>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

Sorry for the delay.

> I have a board with the ALI M7101 chip, but I can't activate it in
> BIOS.  I tried to compile the prog/hotplug/m7101.c but I seen that
> this is only  for 2.4 Kernels. Is there a module for 2.6?

The prog/hotplug/m7101.c (from the lm_sensors project) was a quick hack
and only works with 2.4 kernels, as you noticed. For 2.6 kernels, the
prefered solution is known as PCI quirks (drivers/pci/quirks.c). I can
see that you already found that and proposed a patch for the 2.6 kernel
here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110606482902883

Maarten Deprez then converted it to the proper kernel coding-style:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110726276414532

I invite you to test the new patch and confirm that it works for you.

Any chance we could get the PCI folks to review the code and push it
upwards if it is OK?

For reference, here are links to the original m7101 unhiding driver code
and help file:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/hotplug/m7101.c
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/hotplug/README

Thanks,
-- 
Jean Delvare
