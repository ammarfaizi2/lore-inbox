Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWBBWTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWBBWTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWBBWTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:19:35 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:22291 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932345AbWBBWTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:19:34 -0500
Date: Thu, 2 Feb 2006 23:19:22 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Jones <davej@redhat.com>, Michael Loftis <mloftis@wgops.com>,
       David Weinehall <tao@acc.umu.se>, Doug McNaught <doug@mcnaught.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060202221922.GB8712@mars.ravnborg.org>
References: <E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com> <20060120200051.GA12610@flint.arm.linux.org.uk> <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com> <87slrio9wd.fsf@asmodeus.mcnaught.org> <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com> <20060202121653.GI20484@vasa.acc.umu.se> <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com> <20060202201008.GD11831@redhat.com> <20060202220519.GA8712@mars.ravnborg.org> <20060202221023.GJ11831@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202221023.GJ11831@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 05:10:25PM -0500, Dave Jones wrote:
> 
> -rw-r--r--    1 davej    davej        4613 Dec 15 23:31 linux-2.6-build-nonintconfig.patch
> 
> Adds a 'nonintconfig' target that behaves like oldconfig, but doesn't
> ask any questions (takes the default answer), and prints out a list
> at the end of all the options it didn't know about.
> (Handy when rebasing, as it means I get to add all the new options
>  in one swoop).
I have this around somewhere. hch did it but recall Roman did not
like it. It's in my pile of 'when I am in kconfig hacking mode' which
happens now and then.

> 
> -rw-r--r--    1 davej    davej         605 Dec 15 23:31 linux-2.6-build-reference-discarded-opd.patch
> 
> Think I posted this already, and it may even be in 16rc
Have applied some changes recently. Needs to come in via (or acked-by)
Keith Ownes though.

> -rw-r--r--    1 davej    davej        1686 Dec 15 23:31 linux-2.6-build-userspace-headers-warning.patch
> 
> adds a #error to includes if __KERNEL__ isn't being used
> (We want people to use the headers from our glibc-kernheaders package,
>  not from the kernel soucre).
Will not touch it. Combining 'kernel header files' and 'userspace' in 
same sentence generate far too much noise :-(

> 
> -rw-r--r--    1 davej    davej        1753 Dec 15 23:31 linux-2.6-bzimage.patch
> 
> To get around some gynamstics in the rpm spec, defining a seperate build target
> for every arch, we make every arch grok 'bzImage'. Fugly, but it keeps the
> spec cleaner to maintain.

Yup - seen it before. Did not like it.
Consistent use of KBUILD_IMAGE across relevant architectures should buy
you the same simplicity and a mergeable approach.

Thanks,
	Sam
