Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWDXIzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWDXIzB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWDXIzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:55:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26191 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932092AbWDXIzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:55:00 -0400
Date: Mon, 24 Apr 2006 10:55:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       Chris Ball <cjb@mrao.cam.ac.uk>, Arkadiusz Miskiewicz <arekm@maven.pl>,
       Jeff Garzik <jeff@garzik.org>, Matt Mackall <mpm@selenic.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ... (fwd)
Message-ID: <20060424085507.GH22614@suse.de>
References: <Pine.LNX.4.64.0604232153230.2890@boston.corp.fedex.com> <20060424075511.GA26345@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424075511.GA26345@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24 2006, Pavel Machek wrote:
> Hi!
> 
> > >>FWIW, this patch fixes S3 resume for me too.  I'm on an Alienware m5500
> > >>using sd_mod and ata_piix, and I think your T43p is using AHCI, so it
> > >>seems that this fixes a libata-wide problem rather than something
> > >>specific to your hardware.
> > >
> > >Thanks for the info, that is useful; but in fact I'm ata_piix not ahci.
> > 
> > 
> > May be just me, not matter what I tried, it still doesn't work. Closest I 
> > can get is to use "resume=/dev/sda" on boot, able to suspend, able to 
> > resume to X windows, can do anything, but can't access disk. ... simple 
> > "ls" would hang. Dmesg is show SATA disk timeout.
> > 
> > 
> > I've tried both "piix" and "ahci". Both suspend to disk and mem.
> 
> Do suspend-to-disk, first. It is easier.
> 
> > My config ...
> > 	CONFIG_SUSPEND2_CRYPTO=y
> > 	CONFIG_SUSPEND2=y
> > 	CONFIG_SUSPEND2_SWAPWRITER=y
> > 	CONFIG_SUSPEND2_DEFAULT_RESUME2="swap:/dev/sda3"
> 
> You'll want to go with vanilla kernel.
> 
> > Linux version is 2.6.17-rc2. IBM X60s is Pentium D, so SMP ... may be this 
> > has something to do with it.
> 
> Disable SMP in kernel config, then; it makes perfect sense to test it
> UP.

If you can, try and test the SUSE kotd kernel. I have at least one
report of the 10.1-RC1 kernel working just fine for STD on an x60s.

-- 
Jens Axboe

