Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRBITJS>; Fri, 9 Feb 2001 14:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbRBITJI>; Fri, 9 Feb 2001 14:09:08 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37897 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129387AbRBITIy>;
	Fri, 9 Feb 2001 14:08:54 -0500
Message-ID: <3A844022.CF971105@mandrakesoft.com>
Date: Fri, 09 Feb 2001 14:08:18 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
        jes@linuxcare.com, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.30.0102081355520.31024-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> On Thu, 8 Feb 2001, Jeff Garzik wrote:
> > The #ifdef ZEROCOPY code you added is a classic example of the kind of
> > code I -remove- from the kernel tree.
> 
> It's an issue of maintainer convenience vs. esthetics. And (last but not
> least) it's also about other people's ability to easily make changes to
> the driver, changes they can understand and test. So while in principle I
> agree with you, I'm also beginning to understand Donald Becker's
> frustration when others remove backward compatibility from his code.
> 
> So let's try to find some middle ground, ok? Your first suggestion sounds
> reasonable, and hopefully the fate of the zerocopy stuff will be decided
> sooner than later.

I would prefer that zerocopy code remain out of all official kernels
until zerocopy itself is in said kernels.  It's experimental code that
simply cannot work in its present form, due to lack of infrastructure in
the general kernel.  And being based on experimental code itself, there
is definitely the potential for changes yet.

Remember:  we are in a stable series of kernels.  This is experimental
code.  Maintain a separate branch of development like everyone else. 
:)   Yes it's a bit more effort, but that's what being a maintainer is
all about.  The kernel needs a -stable- starfire.c, let's talk about
adding experimental code later.

BTW, I would suggest looking at Jes' acenic.c as an example of a 2.4
driver that is clean but also [hopefully!] works under 2.2.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
