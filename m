Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129873AbRAQKUT>; Wed, 17 Jan 2001 05:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131001AbRAQKUJ>; Wed, 17 Jan 2001 05:20:09 -0500
Received: from [24.65.192.120] ([24.65.192.120]:52974 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S131399AbRAQKUA>;
	Wed, 17 Jan 2001 05:20:00 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101171019.f0HAJSM04596@webber.adilger.net>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <3A656C09.4A40BBF5@mandrakesoft.com> "from Jeff Garzik at Jan 17,
 2001 04:55:21 am"
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Date: Wed, 17 Jan 2001 03:19:28 -0700 (MST)
CC: David Woodhouse <dwmw2@infradead.org>,
        Andreas Dilger <adilger@turbolinux.com>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Bryan Henderson'" <hbryan@us.ibm.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff writes:
> David Woodhouse wrote:
> > 
> > adilger@turbolinux.com said:
> > >  One reason why this may NOT ever make it into the kernel is that I
> > > know "kernel poking at devices" is really frowned upon.
> > 
> > A possible alternative is to specify drives by serial number.
> 
> Currently mount(8) supports mounting by '-L <label>' and '-U <UUID>'. 
> Most modern mke2fs proggies will assign a UUID to each newly created
> filesystem.  For /etc/fstab, you can specify LABEL=xxx or UUID=xxx
> instead of a device name.

> The one thing I don't know is... can the kernel mount the root fs if
> only given the uuid?

You missed the context.  I was referring to the 2.2.5? patch that allowed
you to do exactly that - specify a kernel parameter "root=UUID:foo" or
"root=LABEL:bar".  I've re-worked it and will post after testing a bit.
My only hesitation was that kernel probing is frowned upon.  When UUID/LABEL
support for devfs came up at the Miami Linux Storage Workshop, it was
given the thumbs down.

If I get a chance I will also fix LILO to allow UUID/LABEL for root as well.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
