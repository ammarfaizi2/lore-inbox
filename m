Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbUKXIWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbUKXIWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 03:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUKXIUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 03:20:43 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:45619 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262531AbUKXITe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 03:19:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HKJCctGlvOAbDvYu+mhjVc7YOvkK27BSMLWiyhwcUheiYvwbkico9JkjKT+LjOWKfgvwDMyLsPiDIG39DkXxDlA/SQeBEgsT3V16P2L2IV9VXoBdylULIgyyb0+P/mLFz2VKAAsvZ86pxOnoMX1rv6tF11yck5WrqqPhvtOpRA8=
Message-ID: <432beae0411240012519e976d@mail.gmail.com>
Date: Wed, 24 Nov 2004 00:12:53 -0800
From: Justin Patrin <papercrane@gmail.com>
Reply-To: papercrane@reversefold.com
To: Norbert van Nobelen <norbert@edusupport.nl>
Subject: Re: Compact Flash - simulating a card
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200411240642.14660.Norbert@edusupport.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <432beae04112313344fb4a5f9@mail.gmail.com>
	 <200411240642.14660.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004 06:42:14 +0100, Norbert van Nobelen
<norbert@edusupport.nl> wrote:
> This is actually not really of topic, so so much for getting shunted.
> 
> Anyway:
> If you edit the modules part (manuals enough on the internet, watch your
> kernel version, because modules changed a bit between 2.4 and 2.6 kernels),
> you can force the identifier of your card to be matched with a CF device.
> Take the best matching device.
> If you don't have any match at all, you have a problem, i.e. it will not work.
> 

Well, it should be a storage device...

> I don't know the Zaurus (except from a nice picture), so I don't know what
> kind of port is used for the CF card (IDE? PCMCIA? other?). If it is an IDE
> port, it should work at once. It does not need any other information.

It's got a normal CF slot with (I think) a PCMCIA bridge. You can plug
in CF memory crad and microdrives as well as CF Wifi cards.

Basically I would want to connect the CF card as an IDE device (I have
no idea how to expose one device as another, although I think the
current CF storage device driver does this).

> 
> For the rest it sounds to me like you are doing a hardware hack.

So you think that I could force the kernel to assume that a device is
present? Meaning that there's no hardware-level stuff that has to
happen?

Of course the hard part is *where* I would edit the kernel for
this...probably in the PCMCIA stuff. I know that that's where the
timout message I was seeing was coming from.

> 
> Regards,
> 
> Norbert
> 
> 
> 
> On Tuesday 23 November 2004 22:34, Justin Patrin wrote:
> > I am not currently subscribed to this list as I figure I'll be shunted
> > to another anyway. Please CC me on replies to this thread. If I should
> > be asking "someone else" whether it be another list or group, let me
> > know.
> >
> > I currently have a Sharp Zaurus with OpenZaurus on it. I'm trying to
> > connect a device to the CF slot. Would is be possible to fake the CF
> > "startup"? I.e. connect a dumb device (which does not understand the
> > CF spec itself) but have the kernel able to pass certain requests on
> > to it? I have tried connecting the device and it sees it (as I've
> > hooked up the detection pins) but something times out. Sorry, I don't
> > have the exact message at the moment.
> 
> 

-- 
Justin Patrin
