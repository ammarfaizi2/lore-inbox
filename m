Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270971AbTGPRAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270964AbTGPQ6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:58:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7614 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270969AbTGPQ6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:58:32 -0400
Date: Wed, 16 Jul 2003 19:13:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>, vojtech@suse.cz,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716171323.GL833@suse.de>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <20030716170911.GB21896@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716170911.GB21896@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16 2003, Dave Jones wrote:
> On Wed, Jul 16, 2003 at 07:03:52PM +0200, Jens Axboe wrote:
> 
>  > > It only happens whilst cdparanoia is reading from the CD.
>  > > The IDE CD drive is using DMA, and interrupts are unmasked.
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  > Yes. You can try and make the situation a little better by unmasking
>  > interrupts with -u1.
> 
> See above 8-) It was the first thing I tried when I observed this phenomenon.

Oh right, sorry.

>  > Or you can try and use a ripper that actually uses
>  > SG_IO, that way you can use dma (and zero copy) for the rips. That will
>  > be lots more smooth.
> 
> Ah right, I thought cdparanoia was still ripper de jour..
> What's recommended these days?

It is, unfortunately it uses read/write on /dev/sg* directly so cannot
be used with "new path" that is so much faster. It's been a while since
I looked, I can check for a good cdda ripper that uses SG_IO tomorrow if
you don't find one first.

I'm about to cave in and add block emulation of that part, too. It's a
bit more code, though.

-- 
Jens Axboe

