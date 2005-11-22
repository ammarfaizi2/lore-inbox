Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbVKVVlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbVKVVlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVKVVlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:41:05 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:45588 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965057AbVKVVlD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:41:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XiHIg3/krDFjTP4EzzsJp8qDoAIfIZ/C97N9QrUt3KeAjQkgi/FNvLu+BWlf01Fr0MImZaPEH5wydoqVPQUfyzazkqk/NFW3SngHVlxQULZ5jj8t7nWexBjG/2MI6u3vzLLjvoXPHAOtlNG2oD3i6I9QZMCTupkRv26v+n2zjO4=
Message-ID: <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
Date: Tue, 22 Nov 2005 16:41:02 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Kasper Sandberg <lkml@metanurb.dk>
Subject: Re: Christmas list for the kernel
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1132694935.10574.2.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <1132694935.10574.2.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > Currently you have to compile most of this stuff into the kernel.
> forgive my ignorance, but whats stopping you from doing this now?

It would be better if all of the legacy drivers could exist on
initramfs and only be loaded if the actual hardware is present. With
the current code someone like Redhat has to compile all of the legacy
support into their distribution kernel. That code will be present even
on new systems that don't have the hardware.

An example of this is that the serial driver is hard coded to report
four legacy serial ports when my system physically only has two. I
have to change a #define and recompile the kernel to change this.

The goal should be able to build something like Knoppix without
Knoppix needing any device probing scripts. Linux is 90% of the way
there but not 100% yet.

X is also part of the problem. Even if the kernel nicely identifies
all of the video hardware and input devices, X ignores this info and
looks for everything again anyway. In a more friendly system X would
use the info the kernel provides and automatically configure itself
for the devices present or hotplugged. You could get rid of your
xorg.cong file in this model.

--
Jon Smirl
jonsmirl@gmail.com
