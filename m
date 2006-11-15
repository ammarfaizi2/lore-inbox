Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030823AbWKOScK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030823AbWKOScK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030824AbWKOScJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:32:09 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:46223 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030823AbWKOScG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:32:06 -0500
Message-ID: <455B5D22.10408@garzik.org>
Date: Wed, 15 Nov 2006 13:32:02 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: David Miller <davem@davemloft.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>	<20061114.190036.30187059.davem@davemloft.net>	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>	<20061114.192117.112621278.davem@davemloft.net> <s5hbqn99f2v.wl%tiwai@suse.de>
In-Reply-To: <s5hbqn99f2v.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> The snd-hda-intel driver has a test of MSI, but it seems not working
> on every machine.  It caused non-cared interrupts and the kernel
> disabled that irq.

Possibly the test was broken.  Did you have IRQF_DISABLED and 
IRQF_SHARED flags set?


>> Given current experience maybe white-lists are in fact the way
>> to go.
> 
> Could it be whitelisted in the PCI driver side?  I don't think it's
> good to have a huge white/blacklist in each device driver.

Certainly, we should not have such lists in the driver.  I don't think 
anybody wants that.

	Jeff



