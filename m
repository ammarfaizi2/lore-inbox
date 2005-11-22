Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbVKVVOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVKVVOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVKVVNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:13:52 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:33729 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965038AbVKVVNE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:13:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ChHvZDYtNqaJMyV3/YMGqlfSwPOk44DjTwtmVqBWtyU+LU9Q+S6XTTELM04dJPk1xmauIplz48LGp53499rIJqjWW0uEpcHH+ASIFY2lhllzhMDcXNS1IORd56M7x5GcTuSCQ9mwZuzslJ8rkdRqdJl24ZHjGEWe7vA+BtfuZck=
Message-ID: <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
Date: Tue, 22 Nov 2005 16:13:01 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Christmas list for the kernel
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051122204918.GA5299@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Greg KH <greg@kroah.com> wrote:
> On Tue, Nov 22, 2005 at 01:31:16PM -0500, Jon Smirl wrote:
> >
> > 4) Merge klibc and fix up the driver system so that everything is
> > hotplugable. This means no more need to configure drivers in the
> > kernel, the right drivers will just load automatically.
>
> What driver subsystem is not hotplugable and does not have automatically
> loaded modules today?

All of the legacy stuff - VGA, Vesafb, PS2, serial, parallel,
joystick, floppy, gameport, etc. Those drivers could be in initramfs
and only load if the hardware is found. Most of these legacy devices
have poor sysfs support too. Also, it's not just x86 legacy device all
of the platforms have them.

Currently you have to compile most of this stuff into the kernel.

> There are a few issues around PnP devices that I know of, and PCMCIA
> needs some seriously love, but other than that I think we are well off.
> Or am I missing something big here?
>
> thanks,
>
> greg k-h
>


--
Jon Smirl
jonsmirl@gmail.com
