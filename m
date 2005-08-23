Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVHWNA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVHWNA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVHWNA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:00:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2510 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932164AbVHWNA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:00:57 -0400
Date: Tue, 23 Aug 2005 15:00:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] suspend: update warnings
Message-ID: <20050823130050.GB3735@elf.ucw.cz>
References: <20050822081528.GA4418@elf.ucw.cz> <1124753566.5093.8.camel@localhost> <20050823125017.GB3664@elf.ucw.cz> <20050823125724.GA7341@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050823125724.GA7341@infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > - DRI being used in X where the drivers don't properly support
> > suspend/resume (NVidia esp)
> 
> NVidias driver is not support and a copyright violation of the
> copyrights of many of use.  It's never supported so please don't
> mention it.

Unfortunately, it is quite common out there. I need to somehow keep
those bug reports off my mailbox.

Okay, this should be enough:

Q: What information is usefull for debugging suspend-to-disk problems?

A: Well, last messages on the screen are always useful. If something
is broken, it is usually some kernel driver, therefore trying with as
little as possible modules loaded helps a lot. I also prefer people to
suspend from console, preferably without X running. Booting with
init=/bin/bash, then swapon and starting suspend sequence manually
usually does the trick. Then it is good idea to try with latest
vanilla kernel.

"Known problematic" modules are; be sure to unload them before
suspend:
- DRI being used (3D acceleration)
- Firewire
- SCSI



-- 
if you have sharp zaurus hardware you don't need... you know my address
