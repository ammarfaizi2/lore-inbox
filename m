Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285320AbRLGAL7>; Thu, 6 Dec 2001 19:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285328AbRLGALu>; Thu, 6 Dec 2001 19:11:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:4879 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S285320AbRLGALl>;
	Thu, 6 Dec 2001 19:11:41 -0500
Date: Fri, 7 Dec 2001 01:11:34 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Greg KH <greg@kroah.com>
Cc: jonathan@daria.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Q: device(file) permissions for USB
Message-Id: <20011207011134.04c2a4af.rene.rebe@gmx.net>
In-Reply-To: <20011206160055.O2710@kroah.com>
In-Reply-To: <fa.ljcupnv.1ghotjk@ifi.uio.no>
	<664.3c0fd1b7.a66fa@trespassersw.daria.co.uk>
	<20011206223050.179cd30e.rene.rebe@gmx.net>
	<20011206152721.M2710@kroah.com>
	<20011207004521.19a131d4.rene.rebe@gmx.net>
	<20011206160055.O2710@kroah.com>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001 16:00:55 -0800
Greg KH <greg@kroah.com> wrote:

Ok I did not searched this far. But this way you also change the nodes for
USB hard-discs, net-interfaces, ... to 666 - the same insecure as my find
solotion ...

> So a simple /sbin/hotplug script of:
> 	#!/bin/sh
> 	if [ "$1" == "usb" ]; then
> 		chmod 666 $DEVICE
> 	fi
> 
> would work just fine for your needs.

> It's not a procfs hack, it is a stand alone filesystem.  The fact that
> you happen to mount it within the /proc filesystem is your option.

Yes my mistake - sorry.

> The USB developers did not want to force people to use devfs to use USB
> devices, and based on the fact that not a single distro is using devfs
> (the one that did, now recommends that you disable it) backs up this
> choice.

OK. Might be well for backward-compatibility - but the devfs solution
would be a very nice option.

> > I do not know why they adapt so slowly to such a cool technology
> > anyway ...
> 
> See the numerous lkml posts about why this is so.

We at ROCK linux (www.rocklinux) use it for years - and never had a
problem (maybe some have - because they use the www.ibm.org/linu-docs-somewhere
approach of taring them on shutdown and untar it on bootup. Using devfsd.conf
is hust fine! (I'll try to search the archive for devfs posts ...)

> thanks,
> 
> greg k-h

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
