Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWE2WKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWE2WKY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 18:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWE2WKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 18:10:24 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:42712 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751424AbWE2WKX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 18:10:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bCW4OnAAbaerS8Ov3i8xS5B64+T7fX7+/t4U1e6iKOUCSaI2AY/owiSYOVkrbah5N7H9CQdeVfJelZDmZ9Cqik62u8c0b7NZ4sZ2BHCPwmYq/JsCHdq6TJYI0SRqy6xuXr2PF/+gJkKGAEgiKeVCKbeUgOe7eqyk6/SwcSJWIM0=
Message-ID: <9e4733910605291510i18d80ff3qc7be3b412fc99785@mail.gmail.com>
Date: Mon, 29 May 2006 18:10:13 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dave Airlie" <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <447B666F.5080109@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <20060529102339.GA746@elf.ucw.cz>
	 <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
	 <20060529124840.GD746@elf.ucw.cz> <447B666F.5080109@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/06, Jeff Garzik <jeff@garzik.org> wrote:
> Pavel Machek wrote:
> > These are very reasonable rules... but still, I think we need to move
> > away from vgacon/vesafb. We need proper hardware drivers for our
> > hardware.
>
> I agree we need proper drivers, but moving away from vesafb will be
> tough... moving away from vgacon is likely impossible for many many
> years yet.
>
> Once proper hardware drivers exist, you will still need to support
> booting into a situation where you probably need video before a driver
> can be loaded -- e.g. distro installers.  Server owners will likely
> prefer vgacon over a huge video driver they will never use for anything
> but text mode console.

These are areas that definitely need more discussion and design work
once we can come to some kind of basic agreement on where to start. I
would definitely like to reduce the number of permutations on how
video drivers can be combined to an absolute minimum. For example
vesafb has caused me a number of problems when it is used
simultaneously with other drivers.

Other areas that can be explored:
1) Multiple active consoles on multiple video cards
2) User space console driver
3) Ownership of video hardware by the logged in user
4) Using graphics mode to do console for complex Asian languages
5) Concept of a safe mode console that will work in all environments

There are probably a lot more areas that can be added to this list.
But none of this can be built until the foundation is laid.

-- 
Jon Smirl
jonsmirl@gmail.com
