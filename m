Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbUKXJIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUKXJIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbUKXJIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:08:22 -0500
Received: from [81.23.229.73] ([81.23.229.73]:56779 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261837AbUKXJIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:08:07 -0500
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: papercrane@reversefold.com
Subject: Re: Compact Flash - simulating a card
Date: Wed, 24 Nov 2004 10:08:05 +0100
User-Agent: KMail/1.6.2
References: <432beae04112313344fb4a5f9@mail.gmail.com> <200411240642.14660.Norbert@edusupport.nl> <432beae0411240012519e976d@mail.gmail.com>
In-Reply-To: <432beae0411240012519e976d@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411241008.05045.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 November 2004 09:12, Justin Patrin wrote:
> On Wed, 24 Nov 2004 06:42:14 +0100, Norbert van Nobelen
>
> <norbert@edusupport.nl> wrote:
> > This is actually not really of topic, so so much for getting shunted.
> >
> > Anyway:
> > If you edit the modules part (manuals enough on the internet, watch your
> > kernel version, because modules changed a bit between 2.4 and 2.6
> > kernels), you can force the identifier of your card to be matched with a
> > CF device. Take the best matching device.
> > If you don't have any match at all, you have a problem, i.e. it will not
> > work.
>
> Well, it should be a storage device...
>
> > I don't know the Zaurus (except from a nice picture), so I don't know
> > what kind of port is used for the CF card (IDE? PCMCIA? other?). If it is
> > an IDE port, it should work at once. It does not need any other
> > information.
>
> It's got a normal CF slot with (I think) a PCMCIA bridge. You can plug
> in CF memory crad and microdrives as well as CF Wifi cards.

Look in the logs for pcmcia messages, and the Zaurus manual for info over the 
slot. It will help you a bit further. I would assume pcmcia too given the 
information.

>
> Basically I would want to connect the CF card as an IDE device (I have
> no idea how to expose one device as another, although I think the
> current CF storage device driver does this).

Just insert it in the slot? If that does not work. In the cs-ide module can be 
a mistake in some 2.4 versions of the kernel: there is a dash somewhere in 
the nameing which should be an underscore. 

>
> > For the rest it sounds to me like you are doing a hardware hack.
>
> So you think that I could force the kernel to assume that a device is
> present? Meaning that there's no hardware-level stuff that has to
> happen?

You could do that, inserting the card and just getting it to work is probably 
easier. I have no clue yet of what the kernel will do when you convince it 
that the card is there, and it will try to address it.
What you could do is create a dummy device based on the ide device in which 
you print debug information. Maybe a skeleton of such a dummy device is 
around somewhere (google?). 

>
> Of course the hard part is *where* I would edit the kernel for
> this...probably in the PCMCIA stuff. I know that that's where the
> timout message I was seeing was coming from.
>
> > Regards,
> >
> > Norbert
> >
> > On Tuesday 23 November 2004 22:34, Justin Patrin wrote:
> > > I am not currently subscribed to this list as I figure I'll be shunted
> > > to another anyway. Please CC me on replies to this thread. If I should
> > > be asking "someone else" whether it be another list or group, let me
> > > know.
> > >
> > > I currently have a Sharp Zaurus with OpenZaurus on it. I'm trying to
> > > connect a device to the CF slot. Would is be possible to fake the CF
> > > "startup"? I.e. connect a dumb device (which does not understand the
> > > CF spec itself) but have the kernel able to pass certain requests on
> > > to it? I have tried connecting the device and it sees it (as I've
> > > hooked up the detection pins) but something times out. Sorry, I don't
> > > have the exact message at the moment.
