Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWBBXyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWBBXyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWBBXyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:54:54 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:8614 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932490AbWBBXyx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:54:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jnm/b9mf2C/Bs/sO2xSMLhLc2JQ50dA4nsvhRqvLG/7Guc1UM2yGepwo7TMsygFbgt7Gie+cm9lrcWBX6a9TaVqCY5qc3eZFCEx/h80TPwUiUVjnnaN+IVNqHEveGufe5hhisf3JyyvmeDUaQDqHiRd93z2FQk9uxqEmlP7Mufc=
Message-ID: <7f45d9390602021554gcb602a1i3fd7378942601c65@mail.gmail.com>
Date: Thu, 2 Feb 2006 16:54:52 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] liyitec: Liyitec PS/2 touchscreen driver
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d5000602021512x42be2006h31e63cb6d78ac1b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d9390602021502q325752d7oe635569cde7ce2c7@mail.gmail.com>
	 <d120d5000602021512x42be2006h31e63cb6d78ac1b3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 2/2/06, Shaun Jackman <sjackman@gmail.com> wrote:
> > [PATCH] liyitec: Liyitec PS/2 touchscreen driver
> >
> > Add an input driver for the Liyitec PS/2 touchscreen.
>
> I don't see any suibstantial differences from the older patch. I think
> it should be integrated into psmouse. Is there a way to query the
> device? What kind of boxes use this touchscreen? Maybe using DMI is an
> option, like lifebook does?

I supplied some commentary in another email. I wasn't entirely sure
how to separate some free commentary from the ChangeLog entry in a
[PATCH] post. Sorry for the confusion.

The system I have, an Advantech touchscreen computer, has no DMI
information. So that option is out, at least in my case.

# ./dmidecode
# dmidecode 2.7
# No SMBIOS nor DMI entry point found, sorry.

I agree this driver would be best as a psmouse drive, but some
reliable detection code is necessary first. The serio driver does work
as is. If the user loads the liyitec.ko module or compiles the driver
into the kernel, she likely knows what she's doing.

I suspect there exists a detection routine using PS/2 commands that
will work, but I haven't figured one out yet.

Cheers,
Shaun
