Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263945AbUDZOF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbUDZOF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 10:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUDZOFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 10:05:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48362 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263851AbUDZNvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:51:41 -0400
Date: Mon, 26 Apr 2004 14:28:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: Martin Hermanowski <martin@mh57.de>
Cc: Nigel Cunningham <ncunningham@linuxmail.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SOFTWARE_SUSPEND as a module
Message-ID: <20040426122831.GH2595@openzaurus.ucw.cz>
References: <20040422120417.GA2835@gondor.apana.org.au> <20040423005617.GA414@elf.ucw.cz> <20040423093836.GA10550@gondor.apana.org.au> <opr6wvqddzruvnp2@laptop-linux.wpcb.org.au> <20040423143004.GC20742@mh57.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423143004.GC20742@mh57.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >As a side-effect it also allows you to resume from devices that couldn't
> > >be done before due to the need for user-space setup.  Examples are LVM
> > >and NBD.
> > 
> > LVM can be compiled in, can't it? Does it need to do some setup from an  
> > initrd?
> 
> It needs to be recognised by the lvm userspace utilities before it can
> be used.
> 
> One other thing this might be very useful for is _swsusp from encrypted
> swap'. With dm-crypt, it should be very easy to create a crypto mapping
> from initrd from which swsusp can resume. IMHO this is a killer feature
> for notebook users (everything encrypted but the boot partition).

Okay. Best way is probably to introduce reboot() variant that
says "resume from this".
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

