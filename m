Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVBBUNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVBBUNu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbVBBUMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:12:40 -0500
Received: from pat.uio.no ([129.240.130.16]:27274 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262791AbVBBUIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 15:08:20 -0500
Date: Wed, 2 Feb 2005 21:08:10 +0100
From: Haakon Riiser <haakon.riiser@fys.uio.no>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Accelerated frame buffer functions
Message-ID: <20050202200810.GA2100@s>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
References: <20050202133108.GA2410@s> <Pine.LNX.4.61.0502020900080.16140@chaos.analogic.com> <20050202142155.GA2764@s> <1107357093.6191.53.camel@gonzales> <20050202154139.GA3267@s> <9e4733910502020825434a477@mail.gmail.com> <20050202174509.GA773@s> <Pine.GSO.4.61.0502022037440.2069@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0502022037440.2069@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.6i
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.05, required 12,
	autolearn=disabled, AWL -0.00, FORGED_RCVD_HELO 0.05)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Geert Uytterhoeven]

> mmap() the MMIO registers to userspace, and program the
> acceleration engine from userspace, like DirectFB (and XF*_FBDev
> 3.x for Matrox and Mach64) does.

Right, this was how I originally intended to do it.  The reason
why I started to obsess about the accelerated fb_ops functions was
that I hoped that, by creating a driver that registered accelerated
versions of these functions, other frame buffer-using applications
would instantly take advantage of it, requiring no changes in those
applications.  I thought the frame buffer device was supposed to
serve as an an abstraction layer between the graphics card and
the application, allowing for 2D acceleration without having to
know anything about the underlying hardware.  But if no one uses the
frame buffer device in this way, I might as well do as you suggest
and mmap() the registers to userspace.

Anyway, thanks to everyone who participated in this thread.  Even if
I didn't get the answers I was hoping for, at least now I can put the
matter to rest.

-- 
 Haakon
