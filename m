Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269385AbRHGTzt>; Tue, 7 Aug 2001 15:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269391AbRHGTzk>; Tue, 7 Aug 2001 15:55:40 -0400
Received: from [63.209.4.196] ([63.209.4.196]:2059 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S269385AbRHGTz3>;
	Tue, 7 Aug 2001 15:55:29 -0400
Date: Tue, 7 Aug 2001 12:59:34 -0700 (PDT)
From: Patrick Mochel <mochel@transmeta.com>
To: "Joseph N. Hall" <joseph@5sigma.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux on FIVA MPC-206E, APM and other issues
In-Reply-To: <20010807193417Z269364-28344+2551@vger.kernel.org>
Message-ID: <Pine.LNX.4.10.10108071246390.14484-100000@nobelium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I am a happy new owner of a Casio FIVA MPC-206E (teensy 2.1 lb subnotebook)
> with RH 7.1 and 2.4.7 installed.  I'm trying to get a variety of things
> working, some of which may or may not be related to needed kernel tweaks.
> I suspect some of these have been address already by Japanese users, but
> alas I cannot read Japanese.

> * APM broken

It's likely that there is no APM support in the BIOS. Which would mean
that it is an ACPI-only BIOS, as far as power management would go. That
would explain your sleep/hibernate problems. And, it will likely account
for not being able to use the buttons.

Try enabling ACPI in the kernel and see what happens. 

> * 24 bit X support broken (an XFree86 issue, I suppose, will check there
> shortly); there is something funny about 24 bit mode on this machine
> anyway even in WIndowsMe mode

What version of X are you using? The chipset, I believe, is an SMI 721.
There is a native driver for it in X these days, and may have been updated
in 4.0.3 or 4.1.0 (I think RH 7.1 ships with 4.0.2).

That chipset should support 16 and 24 bit mode. 

> * Also I've been having no luck getting a DWL-650 (D-Link 802.11 card)
> recognized and working ... was close with the wvlan_cs(? one of those)
> driver but I'm operating on the assumption that the orinoco_cs driver is 
> more current, and can't get it recognized at all

I haven't actually tried to get this card to work, but I once saw a page
with relevant information about it:

http://www.focusresearch.com/dwl-650.html

(it recommends the wvlan_cs driver)

	-pat

