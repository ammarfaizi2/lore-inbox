Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbVAJW2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVAJW2S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVAJWWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:22:50 -0500
Received: from mproxy.gmail.com ([216.239.56.251]:21347 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262740AbVAJWT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:19:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Fj6IMSADgg2rN00MaT2vp9rdLrKIQCEEssc+DjOSTtgCmZ1RIjMfU4cijX6VKpT6Rxg3N0GBD+aBbxf7iHbHEZD6ciJsOFIhT/+WeQVFdT+35sXZ1/8rjww5WQbKhuetHWcKcToNkAxCO/4sy6aKsUMrqkPjwSSly2C6cMSWzHs=
Message-ID: <21d7e99705011014197b8a9767@mail.gmail.com>
Date: Tue, 11 Jan 2005 09:19:24 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: starting with 2.7
Cc: John Richard Moser <nigelenki@comcast.net>, znmeb@cesmail.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105361337.12054.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	 <1105045853.17176.273.camel@localhost.localdomain>
	 <1105115671.12371.38.camel@DreamGate> <41DEC5F1.9070205@comcast.net>
	 <1105237910.11255.92.camel@DreamGate> <41E0A032.5050106@comcast.net>
	 <1105278618.12054.37.camel@localhost.localdomain>
	 <41E1CCB7.4030302@comcast.net>
	 <21d7e99705010917281c6634b8@mail.gmail.com>
	 <1105361337.12054.66.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Llu, 2005-01-10 at 01:28, Dave Airlie wrote:
> > I do wonder would open source kernel drivers to work with a closed
> > source user space application be accepted into the mainline kernel...
> > say for example Nvidia or VMware GPL'ed their lower layer kernel
> 
> It isnt about whether they are "accepted" but whether they are
> derivative works. The license is quite clear on this with the specific
> clarification included for the syscall interface.

but if the GPL'ed their in-kernel software and submitted it to the
kernel for inclusion would it be accepted given that the only user for
the software would be their own userspace driver, and that userspace
driver is closed source.... I think people would object like crazy 
but I'd love to see what would happen?

Say theoretically ATI decide tomorrow:
1. GPL in kernel source code (ATI is based on the DRM so it isn't such
a leap of faith as say NVIDIA doing it...)
2. clean it all up so that it follows every single kernel coding
practice to the letter
3. submit it for inclusion into the kernel as a device driver,
drivers/char/drm/fglrx.c

Now would you include it? we can't use the no-one is using it excuse,
as people are using fglrx already and many have no choice, the driver
would have no userspace applications other than the binary only 2D/3D
drivers they supply for X... ATI would then benefit from the kernel
development process for keeping the things up-to-date with respect to
interfaces etc...

In this way, people who are running on ppc etc would still not have or
be any closer to 3D acceleration for their graphics cards, but ATI
would have followed the rules as far as the kernel is concerned....

The main reason 3D graphics drivers are the big one here as of course
we can't put OpenGL into the kernel, so it requires a split
kernel/userspace solution, and one is of little use without the other,
if the kernel one is GPL and userspace one is closed source how do
people sit with it? (uneasy?)

Dave.
