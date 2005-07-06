Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVGFLaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVGFLaE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 07:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVGFLaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 07:30:04 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:8398 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261737AbVGFIyw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:54:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bHxwL7BMp9IZltXrD6k+WgEDtc+5/jDdyGi4vSwoOh96HC4cPRq9OPE+1CrT+FXo2yMVxSFdh9xXf+URmedaWNj72lSdLKFnhLpQQUMbWHtoR42suXt6C3aY0EYE+F05cEpYdVnz6wmkBM9Kh7Kq08+KqL9WbGNlTgJVPtwIqWM=
Message-ID: <465e1cd305070601547253a91e@mail.gmail.com>
Date: Wed, 6 Jul 2005 10:54:51 +0200
From: davide vecchio <davide.vecchio@gmail.com>
Reply-To: davide vecchio <davide.vecchio@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with PS/2 Logitech WheelMouse
Cc: dtor_core@ameritech.net
In-Reply-To: <465e1cd3050705100350144e32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <465e1cd305070508442be8af@mail.gmail.com>
	 <d120d50005070509186bd3cdb1@mail.gmail.com>
	 <465e1cd3050705100350144e32@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry but as I wrote nothing as changend using both the suggested
module parameters.
I think there can be something wrong with the hotplug but no clear
idea on what to try more...
Any suggestion is welcome.
Thanks,
 Davide

On 7/5/05, davide vecchio <davide.vecchio@gmail.com> wrote:
> Hi Dimitry,
> I tried both options you suggested but noting changes ...
> the only strange thing I didn't notice before is :
> "input.c: calling hotplug without a hotplug agent defined "
> Any further idea ?
> Davide
> 
> On 7/5/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On 7/5/05, davide vecchio <davide.vecchio@gmail.com> wrote:
> > > Hi everybody,
> > > I'm running SOME LINUX DISTROS (Fedora Core 2 kernel 2.6.7 and, Suse
> > > 9.3 kernel 2.6.10-4) on an  Amd XP 1200 box on an msi 6360 MAINBOARD.
> > > I'm using a PS/2 Logitech WheelMouse (usb mouse connected using ps2 adapter).
> > > I'm experiencing on both distros that with the standard kernel (the
> > > one prebuilt coming with the distro), the mouse is working correctly
> > > but when I tried to compile a new kernel (2.6.11 or 2.6.22) got from
> > > the kernel.org site both using modules or static support for the mouse
> > > , the mouse stops working both in console (tested throught cat
> > > /dev/input/mice) and in X.
> > >
> >
> > Hi,
> >
> > I see that the mouse seem to be detected properly... I wonder if some
> > of the extended probes confuse it. Could you try doing:
> >
> >          rmmod psmouse
> >          insmod /lib/modules/`uname
> > -r`/kernel/drivers/input/mouse/psmouse.ko proto=bare
> >
> > and
> >
> >          rmmod psmouse
> >          insmod /lib/modules/`uname
> > -r`/kernel/drivers/input/mouse/psmouse.ko proto=imps
> >
> > And tell me if any of them work?
> >
> > Thanks!
> >
> > --
> > Dmitry
> >
> 
> 
>
