Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271966AbRHVJBV>; Wed, 22 Aug 2001 05:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271968AbRHVJBL>; Wed, 22 Aug 2001 05:01:11 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:7183 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S271966AbRHVJA5>; Wed, 22 Aug 2001 05:00:57 -0400
Date: Wed, 22 Aug 2001 10:00:47 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
To: Taylor Carpenter <taylorcc@codecafe.com>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: Oops when accessing /dev/fd0 (kernel 2.4.7 and devfsd 1.3.11)
In-Reply-To: <20010821223042.A30478@pioneer.oftheInter.net>
Message-ID: <Pine.LNX.4.21.0108220955470.18880-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Taylor Carpenter wrote:

> On Thu, Aug 16, 2001 at 10:19:07PM -0600, Richard Gooch wrote:
> > If you think the problem may be devfs-related, a good test is to try
> > again with CONFIG_DEVFS_FS=n.
> 
> I tried kernel 2.4.8 and also had an oops.  An earlier kernel w/out devfs did
> not cause an oops.  I plan on making a non-devfs 2.4.8 kernel to see if the
> oops does not happen.

I've noticed kernels 2.4.7, 2.4.8 and 2.4.9 can oops when modprobing
floppy.o under certain circumstances (specifically I've noticed it when
rc.sysinit does "/sbin/pam_console_apply -r",which appears to cause the
floppy driver to be modprobed).  There doesn't seem to be a problem if the
floppydriver is compiled into the kernel instead of being modular.

NOTE: I'm testing these kernels on Cobalt kit, which doesn't have a floppy
drive (and does some very odd things at the hardware/firmware side
occasionally :).  So I can't vouch for how this will affect
"normal" hardware.

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


