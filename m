Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289093AbSANWTO>; Mon, 14 Jan 2002 17:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289099AbSANWTE>; Mon, 14 Jan 2002 17:19:04 -0500
Received: from waste.org ([209.173.204.2]:3736 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S289098AbSANWTC>;
	Mon, 14 Jan 2002 17:19:02 -0500
Date: Mon, 14 Jan 2002 16:18:41 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <20020114151748.B19776@thyrsus.com>
Message-ID: <Pine.LNX.4.43.0201141613580.31316-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Eric S. Raymond wrote:

> Alexander Viro <viro@math.psu.edu>:
> > But it still leaves you with tristate - instead of yes/module/no it's
> > yes/yes, but don't put it on initramfs/no.  However, dependencies become
> > simpler - all you need is "I want this, that and that on initramfs" and
> > the rest can be found by depmod (i.e. configurator doesn't have to deal
> > with "FOO goes on initramfs (== old Y), so BAR and BAZ must go there
> > (== can't be M)").
>
> Actually I think we may no longer be in tristate-land.  Instead, some
> devices have the property "This belongs in initramfs if it's configured
> at all" -- specifically, drivers for potential boot devices.  Everything
> else can dynamic-load after boot time.

The knowledge of what's required to boot can and should be moved out of
the kernel to distro land. 'make install' should call the distro's install
script that sez /boot and /lib are on ext3 on /dev/sd?, ergo I need to
include the ext3 and relevant SCSI modules.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

