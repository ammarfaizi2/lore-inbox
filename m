Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278269AbRKXN6K>; Sat, 24 Nov 2001 08:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278358AbRKXN6B>; Sat, 24 Nov 2001 08:58:01 -0500
Received: from ns.caldera.de ([212.34.180.1]:50598 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S278269AbRKXN5t>;
	Sat, 24 Nov 2001 08:57:49 -0500
Date: Sat, 24 Nov 2001 14:56:18 +0100
Message-Id: <200111241356.fAODuIb30257@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: kaos@ocs.com.au (Keith Owens)
Cc: linux-kernel@vger.kernel.org, kaih@khms.westfalen.de
Subject: Re: is 2.4.15 really available at www.kernel.org?
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <2450.1006608941@ocs3.intra.ocs.com.au>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <2450.1006608941@ocs3.intra.ocs.com.au> you wrote:
> kbuild 2.5 has standard support for running user specific install
> scripts after installing the bootable kernel and modules.  That is, the
> "update my bootloader" phase can be automated and will propagate from
> one .config to the next when you make oldconfig.

Never 2.4 kernels already try to excecute ~/bin/installkernel in the
'make install' pass on i386.

My personal tip for people keeping lots of kernels around is grub, though.
No need for a menu entry, one can just boot all kernel on the accessible
filesystems.

Together with the above "~/bin/installkernel" option I put my kernels always
into /lib/modules/<version>/vmlinux so I can find them easily (IMHO this
should be default in 2.5), so even lilo-using people could write simple
scripts to add all kernels present in /lib/modules/ to their config.
This does of course make the path '/lib/modules/' grossly misnamed, maybe
we could change it into /kernel in 2.5 :)

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
