Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbUF3WgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUF3WgS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 18:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUF3WgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 18:36:18 -0400
Received: from sasami.anime.net ([207.109.251.120]:13746 "EHLO
	sasami.anime.net") by vger.kernel.org with ESMTP id S263028AbUF3WgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 18:36:16 -0400
X-Antispam-Origin-Id: c4dc35da7d5d290438c6d6bdb17308d1
Date: Wed, 30 Jun 2004 15:36:15 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.6 amd8111 apic bugs
Message-ID: <Pine.LNX.4.44.0406301533030.28684-100000@sasami.anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Message not sent from an IPv4 address, not delayed by milter-greylist-1.3.8 (sasami.anime.net [0.0.0.0]); Wed, 30 Jun 2004 15:36:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sent to linux-ide ml several weeks ago and received no response. Cc'ing to 
linux-kernel in the hopes someone will be able to figure out whats wrong 
with amd8111 apic.

Responses in email please as im not subscribed to the list.

-Dan

---------- Forwarded message ----------
Date: Mon, 14 Jun 2004 17:34:57 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: J. Ryan Earl <heretic@clanhk.org>
Cc: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org
Subject: Re: kernel 2.6.6 amd8111 dma bugs

On Wed, 2 Jun 2004, J. Ryan Earl wrote:
> Jens Axboe wrote:
> >On Fri, May 28 2004, Dan Hollis wrote:
> >>replies to email as i'm not subscribed to the list.
> >>There seem to be regular dma timeouts:
> >>hdc: dma_timer_expiry: dma status == 0x24
> >>hdc: DMA interrupt recovery
> >>hdc: lost interrupt
> >>hda: dma_timer_expiry: dma status == 0x24
> >>hda: DMA interrupt recovery
> >>hda: lost interrupt
> >>Hardware:
> >>Opteron 140, Tyan Tomcat K8S (S2850)
> >Try disabling ACPI (in .config or boot acpi=off iirc)
> I had that problem, but not with ACPI, only when I forced APIC on.  It 
> was on the VIA controller which uses the same driver.

Turns out it was apic and not acpi at all. Booting with ACPI but noapic 
and I no longer get any dma errors.

Is the bug in the linux apic code or a hardware flaw in the opteron cpu? 
Or something else?

-Dan

