Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbWFKC0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWFKC0R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 22:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWFKC0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 22:26:17 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:45260 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932469AbWFKC0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 22:26:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ExDkf0lZNni/7T/HADWAfO8tWcd0Y7DQR6hWkDMBeL9ni9RJLmYEo3Om1/Yz4GqogFeToAVcL6afu/dWLAamg8O4ICNXDzSlKCgZ0w2vwzhWQGrnKsQdER/5otZmUdS/9l2RzvT+QwgFdHJZjDWX8PzENRuVllIDvkhhSb4Ddwo=
Message-ID: <9e4733910606101926h73addc1j7cbb4027d3d9f41e@mail.gmail.com>
Date: Sat, 10 Jun 2006 22:26:15 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>
In-Reply-To: <448B7594.6040408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44893407.4020507@gmail.com>
	 <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
	 <448AC8BE.7090202@gmail.com>
	 <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
	 <448B38F8.2000402@gmail.com>
	 <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>
	 <448B61F9.4060507@gmail.com>
	 <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>
	 <9e4733910606101805t3060c0cdgd08ceabe8cfe4e0e@mail.gmail.com>
	 <448B7594.6040408@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
> > On 6/10/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> >> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> > > I see now that you can have tty0-7 assigned to a different console
> >> > > driver than tty8-63.
> >> > > Why do I want to do this?
> >> >
> >> > Multi-head.  I can have vgacon on the primary card for tty0-7,
> >> > fbcon on the secondary card for tty8-16.
> >>
> >
> > When I say dropped, I mean drop the feature of having multiple drivers
> > simultaneously open by the VT layer. You would still be able to switch
> > from vgacon to fbcon by using sysfs. You just wouldn't be able to use
> > VT swap hotkeys between them.
>
> Quoting you:
>
> "Googling around the only example I could find was someone with a VGA
> card and a Hercules card. They setup 8 consoles on each card."
>
> How do you think they accomplished that? They did not rewrite the VT
> layer, all they need to do is change the 'first' and 'last' parameter
> passed to take_over_console() in mdacon.c.  This implies that the VT
> layer already supports multiple active VT console drivers, maybe as
> early as 2.2, and no, we won't remove that.

But the hardware has changed. The kernel is missing a lot of the
support needed for multiple VGA cards in a single box so that option
isn't legal. So this needs to be done with non-VGA cards. Are there
non-VGA cards still in production where a user would want to put
multiple cards in their box? As far as I know they aren't any in the
x86 world, I don't know about other architectures.

All modern Hercules cards are VGA based, they use NVidia and ATI
chips. The reference was from 1998, they were referring to the ancient
Hercules cards that were non-VGA.

Back in the days of CGA, MDA, HGC, 8514, etc this situation was
common, but now everything is VGA.

-- 
Jon Smirl
jonsmirl@gmail.com
