Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVBBRph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVBBRph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 12:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbVBBRpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 12:45:34 -0500
Received: from pat.uio.no ([129.240.130.16]:41173 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262376AbVBBRpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 12:45:18 -0500
Date: Wed, 2 Feb 2005 18:45:09 +0100
From: Haakon Riiser <haakon.riiser@fys.uio.no>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Accelerated frame buffer functions
Message-ID: <20050202174509.GA773@s>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
References: <20050202133108.GA2410@s> <Pine.LNX.4.61.0502020900080.16140@chaos.analogic.com> <20050202142155.GA2764@s> <1107357093.6191.53.camel@gonzales> <20050202154139.GA3267@s> <9e4733910502020825434a477@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910502020825434a477@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.05, required 12,
	autolearn=disabled, FORGED_RCVD_HELO 0.05)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Jon Smirl]

> On Wed, 2 Feb 2005 16:41:39 +0100, Haakon Riiser
> <haakon.riiser@fys.uio.no> wrote:
>> Thanks for the tip, I hadn't heard about it.  I will take a look,
>> but only to see if it can show me the user space API of /dev/fb.
>> I don't need a general library that supports a bunch of different
>> graphics cards.  I'm writing my own frame buffer driver for the
>> GX2 CPU, and I just want to know how to call the various functions
>> registered in struct fb_ops, so that I can test my code.  I mean,
>> all those functions registered in fb_ops must be accessible
>> somehow; if they weren't, what purpose would they serve?
> 
> You should look at writing a DRM driver. DRM implements the kernel
> interface to get 3D hardware running. It is a fully accelerated driver
> interface. They are located in drivers/char/drm

Have the standard frame buffer drivers been abandoned, even
for devices that have no 3D acceleration (like the Geode GX2)?
I took a quick look at the DRM stuff, and it looked like extreme
overkill for what I need, if it even can be used for what I want
to do.  At first glance it looked like this is only relevant for
OpenGL/X11 3D-stuff, which I have absolutely no use for.

GX2 is an integrated CPU/graphics chip for embedded systems.
We have third party applications that use the framebuffer device,
and I was hoping to make things faster by writing an accelerated
driver.  The only thing I need answered is how to access fb_ops
from userspace.  If that is impossible because all the framebuffer
code is leftover junk that no one uses anymore, or even /can/
use anymore because the userspace interface is gone, please let
me know now so I don't have to waste any more time.

-- 
 Haakon
