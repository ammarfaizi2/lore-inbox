Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWE3VPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWE3VPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWE3VPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:15:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:27103 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932480AbWE3VPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:15:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fj0t3kYXKeFDcIC47SjqaOL0UxJZq+C4XvxMI1/kgJm+TGefTQxjNYfu27RBRiuKnQnf8DLLYBATyHNCKPY1nhAxCKfjGr1mTszsYRXOPAPLmrDczUAFLEb7XA1YlLnrUZdNCCdZWNCti+t0mXcOpN0X/77TFpkUVNgc4Vo2NcE=
Message-ID: <441e43c90605301415u6974bc5r34bc7817011e3271@mail.gmail.com>
Date: Tue, 30 May 2006 16:15:50 -0500
From: "Ian Kester-Haney" <ikesterhaney@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <20060529102339.GA746@elf.ucw.cz>
	 <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
	 <20060529124840.GD746@elf.ucw.cz>
	 <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>
	 <20060530202401.GC16106@elf.ucw.cz>
	 <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

I think this debate boils down ti a few issues that could be easily resolved.
  As far as I can tell, the OpenGL Framebuffer is for an accelerated
console in 2D
  While expecting Intel, ATI and Nvidia to cough up specs for their
cards, a simpler
    implementation of OpenGL for the console could be offered up.
  The existing system works well for most people and a newer system could either
    tranisition from the base or take over if the installer or distro
supports it.
  I don't see the hardware folks releasing all the details, but I can
see them releasing a
    mini-GL driver ala the quake era in LGPL or other comparable liscense.
  It just seems that those of us with Expensive GPUs should be able to
get a better
    console experience.
  I think a main goal would be to allow the existing code to
gracefully release the hardware
    for a different driver to take over, be it a Xorg driver, a GLX
driver, an Open Source driver or
    a binary driver that 'taints' the kernel.  I want X to release to
the console in some cases
    and I want the consoles basic driver to release to the Xorg driver.
Most 'power users' run the binary drivers just fine.

I hope it makes sense to you guys.  I love Linux and want it to get better.
Just as the static /dev gave way to udev, the basic console should
make/prepare the way
    for an accelerated console that uses newer and more powerful
grapics cards to better
    use.

Thank You for reading.
Regards,
           Ian

On 5/30/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 5/30/06, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > > >No, to the contrary. suspend/resume can't ever work properly with
> > > >vgacon and vesafb. It works okay with radeonfb tooday, and in fact
> > > >radeonfb is neccessary today for saving power over S3.
> > >
> > > But the things is today for many users suspend/resume to RAM works for
> > > people running X drivers, I know on my laptop that my radeon
> > > suspends/resumes fine when running vgacon/DRM/accelerated X, it
> > > doesn't suspend/resume at all well when running vgacon on its own of
> > > course. or with radeonfb for that matter. so I still believe the
> > > suspend/resume code for a card can live in userspace if necessary but
> > > it just shouldn't be part of X... it needs to be part of another
> > > graphics controller process.
> >
> > So we are mostly in agreement. I'd prefer to have suspend/resume code
> > in kernel in cases it is simple... but separate userspace process is
> > better than having it in X.
>
> Don't draw any conclusions from saying that suspend/resume works in X
> and doesn't work on xx_fb. What matters is that a set of code that can
> perform suspend/resumes exists at all. Once a coherent driver model is
> designed the relevant code can be moved to the correct place.
>
> Another reason for moving things like this out of X is to allow the
> implementation of alternative graphics systems. It makes no sense that
> every new graphics system has to develop their own video and keyboard
> drivers. ALSA is a good model for this, it is shared by everyone.
> Imagine what things would be like if X built in drivers for every
> sound card,.
>
> --
> Jon Smirl
> jonsmirl@gmail.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
