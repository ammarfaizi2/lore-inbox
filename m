Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270941AbTGPQtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270950AbTGPQtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:49:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10684 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270941AbTGPQtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:49:13 -0400
Date: Wed, 16 Jul 2003 19:03:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>, vojtech@suse.cz,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716170352.GJ833@suse.de>
References: <20030716165701.GA21896@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716165701.GA21896@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16 2003, Dave Jones wrote:
> I've decided to oggify my CD collection, and every now and
> again, the mouse pointer goes bezerk is if I had been
> shaking it around and randomly clicking on things.
> In the logs are lots of..
> 
> psmouse.c: Lost synchronization, throwing 3 bytes away.
> 
> It only happens whilst cdparanoia is reading from the CD.
> The IDE CD drive is using DMA, and interrupts are unmasked.
> according to the logs, its happened 32 times since I last
> booted..  /proc/interrupts shows that the i8042 is using
> a different interrupt to the IDE devices..
> 
> Mouse is a logitech wheely PS/2 mouse, using ImPS/2 protocol
> in X config reading from /dev/psaux.
> 
> This is using 2.6test1, I'don't recall ever seeing this
> happen in 2.4, but it did occur for a while earlier in 2.5,
> and I forgot about it until now.
> 
> Any ideas?

Yes. You can try and make the situation a little better by unmasking
interrupts with -u1. Or you can try and use a ripper that actually uses
SG_IO, that way you can use dma (and zero copy) for the rips. That will
be lots more smooth.

-- 
Jens Axboe

