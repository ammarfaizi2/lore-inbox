Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRBNTTD>; Wed, 14 Feb 2001 14:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRBNTSx>; Wed, 14 Feb 2001 14:18:53 -0500
Received: from [207.199.12.19] ([207.199.12.19]:60685 "EHLO
	centrum.jedi-group.com") by vger.kernel.org with ESMTP
	id <S129842AbRBNTSn>; Wed, 14 Feb 2001 14:18:43 -0500
Date: Wed, 14 Feb 2001 11:16:21 -0800 (PST)
From: "Erik G. Burrows" <egb@erikburrows.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Multicast on loopback?
In-Reply-To: <E14SocF-0003Df-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102141105140.19982-100000@centrum.jedi-group.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > locally over the loopback interface. This does not work without adding a 
> > bogus route statement to get the kernel to hand up the packets from
> > loopback to my waiting application.
> 
> The multicast ABI includes the ability to toggle loopback of multicast
> datagrams. Use the socket options instead

I read that multicast loopback is by default enabled, and I have witnessed
this, when having my application bind to my ethernet interface, but the
datagrams do not seem to be looped back when I bind to the 'lo' interface.

Could this possibly be a conflict with the inherently 'looped back'
behavior of the loopback net driver?

As far as toggling the flag, or even reading it, I cannot, as I am
developing in Java.

For developing, I can easily kludge it to work, by adding a fake route
statement, forcing the packets back up to the application, but I want to 
make sure the differing behavior is not a bug in the kernel networking
code.

-Erik G. Burrows

