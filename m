Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317324AbSFLD3I>; Tue, 11 Jun 2002 23:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSFLD3H>; Tue, 11 Jun 2002 23:29:07 -0400
Received: from 04-195.088.popsite.net ([64.24.84.195]:13952 "EHLO perl")
	by vger.kernel.org with ESMTP id <S317324AbSFLD3G>;
	Tue, 11 Jun 2002 23:29:06 -0400
Date: Wed, 12 Jun 2002 03:29:06 +0000
To: linux-kernel@vger.kernel.org
Cc: Cengiz Akinli <cengiz@drtalus.aoe.vt.edu>, xsdg@mangalore.zipworld.com.au
Subject: Re: computer reboots before "Uncompressing Linux..." with 2.5.19-xfs
Message-ID: <20020612032906.A27982@216.254.117.126>
In-Reply-To: <20020612002229.A27386@216.254.117.126> <200206120037.g5C0bFd18677@drtalus.aoe.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: xsdg <xsdg@openprojects.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 08:37:12PM -0400, Cengiz Akinli wrote:
> In message <20020612002229.A27386@216.254.117.126>, xsdg writes:
::snip? SNIP!::
> The reply was:
> 
> >I have a feeling that its the empty_8042 routine in arch/i386/boot/setup.S
> >that's causing you problems.... without a keyboard attached, some
> >controllers will hang there, sadly. If you feel brave, take a look in
> >setup.S around lines 598 (where we enable a20) and 783 (the empty_8042
> >routine itself)  and see if you can get rid of those calls to empty_8042
> >or otherwise screw around in there so that it doesn't wait forever to
> >empty the controller's buffers.
hrm... the box has a keyboard on it...

> >1) Compile the kernel, optimized for P-MMX, on another box (PII-350 Deschutes)
> >   using gcc 2.95.4
> 
> Have you tried building for a generic i386 target processor?
Not yet... will try...

> >2) Recompile bzImage
> >3) Recompile bzImage
> 
> Well, if it didn't work the first time....   :)
> 
> >4) Remove framebuffer support.  Remove vid mode selection support.  Optimize
> >   for Pentium-Classic.  Recompile with everything else the same
> >5) Recompile on target box (gcc 2.95.4 also) with options the same as after #4
> 
> I'm inclined to think none of this ha anything to do with it, because
> the kernel in which all of these items reside is never booting up...
> 
> My problem persisted despite my building a buck-naked 2.4.18 kernel.
> It had no ANYTHING in it (not even module support) and was just 250K.
> The results were the same.
> 
> I'm betting on a problem with the boot loader or bios incompatibility.
> My machine has a PhoenixBios (4.06 I think-- I'll check tomorrow).
> What does your machine have?
Award BIOS (don't know the version offhand)  I'm using grub 0.91-2...

> Regards,
> Cengiz

	--xsdg
-- 
|---------------------------------------------------|
| It's not the fall that kills you, it's the        |
|   landing.                                        |
|---------------------------------------------------|
| http://xsdg.hypermart.net   xsdg@openprojects.net |
|---------------------------------------------------|
