Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287764AbSBMRKT>; Wed, 13 Feb 2002 12:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287865AbSBMRKL>; Wed, 13 Feb 2002 12:10:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11022 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287764AbSBMRKE>;
	Wed, 13 Feb 2002 12:10:04 -0500
Message-ID: <3C6A9DEA.5D89D739@mandrakesoft.com>
Date: Wed, 13 Feb 2002 12:10:02 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <3C6A5D79.33C31910@mandrakesoft.com>	<Pine.LNX.4.33.0202131028130.13632-100000@home.transmeta.com> <20020213.084952.68037450.davem@redhat.com> <3C6A9A7F.8020601@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> David S. Miller wrote:
> 
> >   From: Linus Torvalds <torvalds@transmeta.com>
> >   Date: Wed, 13 Feb 2002 10:30:48 -0800 (PST)
> >
> >   Basic rule: it's up to _other_ architectures to fix drivers that don't
> >   work for them. Always has been. Because there's no way you can get the
> >   people who just want to have something working to care.
> >
> >And if nobody else ends up doing it, you are right it will be people
> >like Jeff and myself doing it.
> >
> >So what we are asking is to allow a few weeks for that and not crap up
> >the tree meanwhile.  This is so that the cases that need to be
> >converted are harder to find.
> >
> If you try to use them, then they are not hard to find - things just
> break for you and you fix tem.

Applying a patch like s/virt_to_bus/virt_to_phys/ makes it more
difficult to find the right spots to change later.

Patience :)  We will fix i810_audio and the other notables.  As I noted
in the other message just now, i810_audio and bttv fixes are already
floating around, and hopefully should appear on lkml or in a Linus
pre-patch soon...


> If you are fixing things for the "store" Linus is right that indeed it's
> just a waiste of time on your behalf.

I can tell you it is -not- a waste of time.  It's not a waste of time
when a vendor appears out of nowhere, having copied a driver of yours. 
Since you did it right(tm), the vendor driver is portable, even though
its original source was for x86-only hardware.  It's not a waste of time
when people copy your code or learn from your code.  It's not a waste of
time when spiffy new x86 hardware appears that has useful IOMMU stuff,
making a driver's use of the PCI DMA API automatically useful for that
new hardware.

I agree with Linus that there is little motivation for someone to
continue patching a driver, after they have fixed the problem they set
out to fix.  But that is not the same as saying driver portability is
worthless... far from it.

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
