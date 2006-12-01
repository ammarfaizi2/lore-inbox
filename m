Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161771AbWLAVUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161771AbWLAVUR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161824AbWLAVUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:20:17 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:21144 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1161771AbWLAVUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:20:15 -0500
Message-ID: <45709C93.7050709@drzeus.cx>
Date: Fri, 01 Dec 2006 22:20:19 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 5/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_omap_dma.diff
References: <4564648B.2020005@indt.org.br> <456805F3.1020407@drzeus.cx> <456AEB70.2000100@indt.org.br>
In-Reply-To: <456AEB70.2000100@indt.org.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
>
> This patch is needed only for lock/unlock commands. So, it's necessary to
> make MMC omap works when using that feature. It's not a generic patch.
> But I can take off this one from the series and send after (if) the
> series
> is integrated.
>

The patches are marked "[RFC]" which I interpret as that I shouldn't
merge it. Is this incorrect?

>
> frame depends on data->blksz. When we were using data->blksz_bits
> everything was
> ok because we always had a multiple of 16 bits (2 bytes). Once a pwd
> can has a size
> not multiple of 2, the value must be rounded.
> According to MMC OMAP Technical Reference Manual, because of each DMA
> transfer is of
> equal size, it is necessary to have the block size of the transfer be
> a multiple of
> the DMA write access size (which is 2 bytes).
>

This sounds very generic and not something that is specific to the
password command.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

