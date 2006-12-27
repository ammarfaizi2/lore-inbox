Return-Path: <linux-kernel-owner+w=401wt.eu-S1753730AbWL0SkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbWL0SkD (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 13:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbWL0SkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 13:40:02 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:53660 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbWL0SkA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 13:40:00 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: util-linux: orphan
Date: Wed, 27 Dec 2006 19:39:47 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Henne Vogelsang <hvogel@suse.de>,
       Olaf Hering <olh@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
References: <20061109224157.GH4324@petra.dvoda.cz> <200612270346.10699.arnd@arndb.de> <20061227181510.GB17785@petra.dvoda.cz>
In-Reply-To: <20061227181510.GB17785@petra.dvoda.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612271939.48125.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 19:15, Karel Zak wrote:
> 
> On Wed, Dec 27, 2006 at 03:46:10AM +0100, Arnd Bergmann wrote:
> > On Monday 18 December 2006 08:17, Karel Zak wrote:
> > >         - remove FS/device detection code
> > >           (libblkid from e2fsprogs or libvolumeid is replacement)
> > 
> > I saw that the current Fedora already dynamically links /bin/mount
> > against /usr/lib/libblkid.so. 
> 
>  Sorry, but it's nonsense.
> 
>  $ grep -r %{_root_libdir}/libblkid.so *
> 
>  devel/e2fsprogs.spec:%{_root_libdir}/libblkid.so.*

Right, please accept my apologies for spreading confusion about this.
I currently don't have access to the machine that broke, so I could
not check the exact problem, and must have misremembered the bug.

> > This obviously does not work if /usr is a separate partition that
> > needs to be mounted with /bin/mount.
> 
>  Yes, I have /usr on a separate partition for many years :-)
>
> > I'd suggest that you make sure that mount always gets statically linked
> > against libblkid to avoid these problems.
> 
>  It's dynamically linked in many distributions without a problem.

The problem that I saw was because of selinux going wild. Statically linking
would have avoided the problem for me, but I guess this is just one
more reason for me to disable selinux and be done with it.

	Arnd <><
