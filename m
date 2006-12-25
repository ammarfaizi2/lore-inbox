Return-Path: <linux-kernel-owner+w=401wt.eu-S1751736AbWLYUbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbWLYUbW (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 15:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754426AbWLYUbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 15:31:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:45792 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751736AbWLYUbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 15:31:21 -0500
X-Authenticated: #20450766
Date: Mon, 25 Dec 2006 21:31:23 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Mark Glines <mark@glines.org>
cc: linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc2: forgot how to make a zImage on powerpc?
In-Reply-To: <45902A6F.4000100@glines.org>
Message-ID: <Pine.LNX.4.60.0612252128530.3424@poirot.grange>
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>
 <fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no> <45902A6F.4000100@glines.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Dec 2006, Mark Glines wrote:

> Mark Glines wrote:
> > Hmm.  I'm trying to build 2.6.20-rc2 on a little powerpc box with
> > arch/powerpc/configs/linkstation_defconfig, and I get:
> ...
> >   MODPOST vmlinux
> > ln: accessing `arch/powerpc/boot/zImage': No such file or directory
> > make[1]: *** [arch/powerpc/boot/zImage] Error 1
> > make: *** [zImage] Error 2
> > 
> > So, uh, are we forgetting to go into the right subdirectory to make the
> > actual zImage, or what?  If I'm just doing something wrong, I'd love to know
> > what it is.
> > 
> > I'll follow up here on lkml if I diagnose this further.  Thanks,
> 
> 
> Followup:  Yeah, it looks like it just doesn't know which format of zImage to
> produce for linkstation.
> 
> I'm not sure what image should be used by default.  I guess it depends on the
> bootloader.  Maybe default to uImage, as uBoot seems to be fairly common on
> these devices?

Yes, uImage is the format used on linkstation. Is there a way to cleanly 
specify this in the kernel sources apart from a comment in Kconfig?

Thanks
Guennadi
---
Guennadi Liakhovetski
