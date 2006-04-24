Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWDXMg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWDXMg1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 08:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWDXMg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 08:36:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1809 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750741AbWDXMg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 08:36:26 -0400
Date: Mon, 24 Apr 2006 13:36:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Ram <vshrirama@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: SD Card not mounting
Message-ID: <20060424123621.GA16464@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Ram <vshrirama@gmail.com>, linux-kernel@vger.kernel.org
References: <8bf247760604240215j12af040dk4e695dbe03d89a83@mail.gmail.com> <444CC1E2.5000101@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444CC1E2.5000101@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 02:17:38PM +0200, Pierre Ossman wrote:
> Ram wrote:
> > Hi,
> >    When i try to mount an generic SD Card on my hardware. i get the error:
> > 
> > mount /dev/mmcblk0 /mnt/mmc -t vfat
> > mount: Mounting /dev/mmcblk0 on /mnt/mmc failed: Device or resource busy
> > 
> 
> You should cc the relevant maintainers when sending questions/bug
> reports. Otherwise it will just get lost in the sheer volume of mail.
> 
> Since I don't recognise what driver you're using I'm adding Russell King
> (the MMC maintainer) as cc.

and I doubt that "Device or resource busy" has anything at all to do
with MMC.  Sounds more like a userspace issue - maybe two filesystems
are being mounted on /mnt/mmc?  Reading the mount(2) man page gives
some ideas what this error may mean.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
