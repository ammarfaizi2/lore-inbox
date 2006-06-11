Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbWFKBFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWFKBFI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 21:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWFKBFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 21:05:08 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:26314 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161060AbWFKBFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 21:05:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oeH+KUSh9y7CY0vTScrS4a01xTEihcbDPOKApy2ol6MBg8HKxqG3Vkv3Crlgth0trnVen5FfgTIkNs5dHcRCSBSs2MGq4pwWjY+Z4hdfmEs7PE4+xBx4WawcJYd06hg2vAJLfMkZKMeD985G4w3JmnP7XBcg/i5m3nXOKJGrk90=
Message-ID: <9e4733910606101805t3060c0cdgd08ceabe8cfe4e0e@mail.gmail.com>
Date: Sat, 10 Jun 2006 21:05:05 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>
In-Reply-To: <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > > I see now that you can have tty0-7 assigned to a different console
> > > driver than tty8-63.
> > > Why do I want to do this?
> >
> > Multi-head.  I can have vgacon on the primary card for tty0-7,
> > fbcon on the secondary card for tty8-16.
>
> That's what I thought, I couldn't see any other reason. The kernel
> doesn't support input from multiple users so multihead can only be
> used by a single user.
>
> Does anyone use single user multihead on current systems? The kernel
> doesn't have code in it to initialize secondary VGA cards. What modern
> non-VGA hardware does this work on?

The kernel is also missing the logic for controlling which VGA card is
active when multiple ones exist in the same box.

> If this feature doesn't work on current hardware, could it be dropped?
> It would make binding to the vt system much simpler if only one driver
> could be bound at a time. Anything we do to make that system simpler
> would benefit everyone.

When I say dropped, I mean drop the feature of having multiple drivers
simultaneously open by the VT layer. You would still be able to switch
from vgacon to fbcon by using sysfs. You just wouldn't be able to use
VT swap hotkeys between them.

> At some future point I would like to explore pushing the VT system out
> to user space where it becomes much easier to make it multi-user and
> multi-head. If you do that, something like a single user, in-kernel
> system management console makes more sense.
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>

-- 
Jon Smirl
jonsmirl@gmail.com
