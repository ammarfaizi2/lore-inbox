Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161179AbWKOTtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179AbWKOTtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbWKOTtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:49:04 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:45204 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161179AbWKOTtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:49:01 -0500
Message-ID: <455B6F20.6050503@garzik.org>
Date: Wed, 15 Nov 2006 14:48:48 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Stephen.Clark@seclark.us
CC: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Takashi Iwai <tiwai@suse.de>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>  <20061114.190036.30187059.davem@davemloft.net>  <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>  <20061114.192117.112621278.davem@davemloft.net>  <s5hbqn99f2v.wl%tiwai@suse.de>  <Pine.LNX.4.64.0611150814000.3349@woody.osdl.org> <1163607889.31358.132.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0611150829460.3349@woody.osdl.org> <455B6BB1.7030009@seclark.us>
In-Reply-To: <455B6BB1.7030009@seclark.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clark wrote:
> Also, I find it disturbing that we are forcing users to have know about 
> all these
> magic options that have to be put on the kernel boot line. My hard drive 
> on my
> new laptop would only run at 1.2mbs until I found out I had to use 
> combined_mode=libata
> and build a new ramdisk that included ata_piix.

That's what happens when two drivers want to drive the same hardware. 
The "slow and safe" default is the only proven-stable option, with the 
proven-stable PATA driver.  The other two options (drivers/ide for 
PATA+SATA -> leads to SATA locksup) and (libata for PATA -> ok but 
breaks existing configs, and less field time) are considered less safe.

Combined mode is ugly no matter how you look at it.  Just turn it off in 
BIOS (or pressure system vendor for this ability if BIOS lacks it, e.g. 
some Dell servers)

And throw some annoyance at Intel for creating such a headache.

	Jeff


