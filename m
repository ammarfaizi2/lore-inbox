Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUI1PzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUI1PzP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 11:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUI1PzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 11:55:14 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:30148 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267958AbUI1PzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 11:55:05 -0400
From: Jan De Luyck <lkml@kcore.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [2.6.9-rc2] ALSA nm256 driver causes system lockup
Date: Tue, 28 Sep 2004 17:55:14 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200409281447.17537.lkml@kcore.org> <s5h655y1jjs.wl@alsa2.suse.de>
In-Reply-To: <s5h655y1jjs.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409281755.14844.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 September 2004 17:48, Takashi Iwai wrote:
> At Tue, 28 Sep 2004 14:47:17 +0200,
>
> Jan De Luyck wrote:
> > Hello list,
> >
> > I'm trying to configure a laptop (Dell Latitude CXs) with 2.6.9-rc2. All
> > runs well, except the ALSA nm256 driver for the Neomagic Audio chip.
> > Loading this driver results in an immediate and complete system
> > lockup....
> >
> > I've tried appending "vaio_hack=1" on the kernel command line, but that
> > didn't really do anything.
> >
> > ALSA is compiled as modules.
> >
> > Any pointers?
>
> Try to load snd-nm256 driver before X.  The chip uses the video RAM
> for the sound buffer.  It seems that X clears all video RAM that
> confuses the sound driver.  I.e. if you already started X, there is no
> way back :)

Yups, so I read in the documentation accompanying the kernel. It's being 
loaded by hotplug during bootup, but even at that early stage it locks up 
completely.

Jan

-- 
BOFH excuse #259:

Someone's tie is caught in the printer, and if anything else gets printed, 
he'll be in it too.
