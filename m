Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbTA2Hto>; Wed, 29 Jan 2003 02:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTA2Hto>; Wed, 29 Jan 2003 02:49:44 -0500
Received: from webmail10.rediffmail.com ([202.54.124.179]:28623 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S265094AbTA2Htn>;
	Wed, 29 Jan 2003 02:49:43 -0500
Date: 29 Jan 2003 08:05:26 -0000
Message-ID: <20030129080526.25423.qmail@webmail10.rediffmail.com>
MIME-Version: 1.0
From: "nitin  kumbhar" <nkumbhar@rediffmail.com>
Reply-To: "nitin  kumbhar" <nkumbhar@rediffmail.com>
To: "Richard B.Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: driver address space
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Jan 2003 Richard B. Johnson wrote :
>On 28 Jan 2003, nitin  kumbhar wrote:
>
> > Hello,
> >   I have a small query about kernel image organization. i am
> > using
> > 2.4.7 kernel version.Is there any data structure in kernel 
>which
> > will give
> > information about _all_ kernel symbols? i could get the data
> > structure
> > which gives _exported_ symbols only. But not all symbols. 
>Using
> > this
> > structure i want to access information about functions present 
>in
> > a driver,
> > which can be used to find out address range(_start_address_ 
>&
> > _end_address_) of the driver in kernel address space.
> >   It is possible to get this information about functions in 
>a
> > driver
> > using System.map. to get this information into kernel can we 
>push
> > the
> > content of this file into kernel image? i think this can be 
>done
> > either by
> > putting it at specific address or appending the image. Will it 
>be
> > OK to
> > access System.map(all kernel symbols) in this way from 
>kernel?
> > Could
> > this cause any security or some other problems?
> >   Or apart from this is there any other way to find out 
>driver's
> > address range in the kernel?
> >
> >   I hope this not something totally out of context. Thank 
>You.
> >
> > Regards,
> > Nitin
> >
>
>Since it's dynamic, i.e., the addresses depends upon other
>drivers/modules being loaded before yours, you just make an 
>ioctl()
>that returns anything you want, including the virtual or even 
>physical
>address of anything in your driver.

hi Richard,

You are true if the driver is a module. But i think the same case 
is not with
drivers present in the kernel image(when built with kernel). The 
position
in the kernel address space where the drivers are loaded is fixed. 
it can
change only if you recompile the kernel. correct me if i am going 
wrong
somewhere.

About ioctl, ioctls can return the required values from the 
driver. But if the
driver is present in the kernel (not as a module) where to find 
these
return values(in this case start & end addresses of the driver). 
Here i am
not getting the place or method to find the addresses.

it will be very helpful if someone could push me forward in 
correct direction.

Thank You.

Regards,
Nitin



