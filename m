Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTKUUOg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 15:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTKUUOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 15:14:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53678 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264436AbTKUUOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 15:14:15 -0500
Date: Fri, 21 Nov 2003 21:14:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ionice kills vanilla 2.6.0-test9 was [Re: [PATCH] cfq + io priorities (fwd)]
Message-ID: <20031121201408.GF6616@suse.de>
References: <20031113124510.GZ643@openzaurus.ucw.cz> <20031121153900.GA193@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031121153900.GA193@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 21 2003, Pavel Machek wrote:
> Hi!
> 
> > > I'm attaching the simple ionice tool. It's used as follows:
> > 
> > Here's one that works, sorry about that. To compile:
> > 
> > # gcc -Wall -D__X86 -o ionice ionice.c
> > 
> > or other define for PPC or X86_64.
> 
> Well, did that, run it on vanilla kernel, and it kills the
> machine. Can someone reproduce it?

I saw that on ppc too, btw, didn't trace it yet. But there definitely is
a problem with calling syscalls that don't exist.

> [What is needed to start using cfq? Is your patch, this utility and
> elevator=cfq enough?]

Yes, that is it. Your result may vary though, I have a newer cfq that's
almost ready for release that fixes varies performance problems.

-- 
Jens Axboe

