Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbTKTNHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 08:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTKTNHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 08:07:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17894 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261740AbTKTNHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 08:07:07 -0500
Date: Wed, 19 Nov 2003 20:06:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Samium Gromoff <deepfire@ibe.miee.ru>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org, rob@landley.net
Subject: Re: Patrick's Test9 suspend code.
Message-ID: <20031119190656.GD6293@openzaurus.ucw.cz>
References: <87fzgkwlci.wl@drakkar.ibe.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fzgkwlci.wl@drakkar.ibe.miee.ru>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > A) Any scheme we come up with there will be a way the user can do something 
> > stupid enough to break it.  (Put the swap partition on a ramdisk living on 
> > the video card, or on a device require an initrd to load the driver to 
> > access...)
> > 
> > B) A heuristic that looks at the mounted block devices for things that smell 
> > like a resume partition would actually be more robust in that case.
> 
> Really, what i think here is appropriate is a more fundamental approach.
> 
> We should reserve a new partition type in addition to three already
> existing, namely "linux"==0x83, "linux swap"==0x82 and "linux lvm"==0x8e.
> 
> And call it something like "linux suspend".
> And initialize it, if needed (i presume to write a signature etc), with
> something like "mksusp".

Yes and we should create separate partition type for root filesystem
and have separate mkfs.ext2.root.

NOT!

I see no advantages in mksusp; it only means you need to re-fdisk
your machine. Bad idea, and its way too late for 2.6 anyway.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

