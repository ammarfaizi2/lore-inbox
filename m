Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293343AbSB1MJe>; Thu, 28 Feb 2002 07:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293301AbSB1MHQ>; Thu, 28 Feb 2002 07:07:16 -0500
Received: from [199.203.178.211] ([199.203.178.211]:7149 "EHLO
	exchange.store-age.com") by vger.kernel.org with ESMTP
	id <S293317AbSB1MGF> convert rfc822-to-8bit; Thu, 28 Feb 2002 07:06:05 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="x-user-defined"
Content-Transfer-Encoding: 8BIT
Subject: RE: Kernel module ethics.
Date: Thu, 28 Feb 2002 14:05:36 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <DCC3761A6EC31643A3BAF8BB584B26CC0DB959@exchange.store-age.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel module ethics.
Thread-Index: AcG/1j4TX4z3BAI+S52UDuEtdDB2qwAd4KCw
From: "Alexander Sandler" <ASandler@store-age.com>
To: "Allo! Allo!" <lachinois@hotmail.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

My company developing some comercial product and one sunny day smart guys from our company decided to make Linux to support it. 
I am the guy who had to do it. And I had almost exactly the same problems as you have. 
What I did was following. First, we do not distribute sources. We distribute binary only. It was quite a problem because of version information on modules symbols. So, we asked from our clients to disable it when using our driver. As a result loading precompiled driver became possible. Currently I have to maintain two versions of the driver (UP and MP), but things can't be too perfect. 
Another sunny day, one of our clients asked for a driver for Linux running on quad IA64 machine. Since we don't have such machine here, we had to give this client the sources, but before doing this, I scrambled the sources so it become completely impossible to read them and to modify them. The scrabler I used called cmunge. It was quite hard to use it for a driver since it's built for userland apps. but it is possible and I did managed to scramble the sources. And if you are afraid that it doesn't do it's job well anough, Well... trust me. It does!

This two ideas may help you with your problems as they did with mine.

Alexandr Sandler.

> Hi,
> 
> The company for whom I work wants to make a linux driver for 
> some of its 
> hardware. On my side I would like the driver to be completely 
> open sourced, 
> and from a customer point of view, its a big plus (a real 
> PITA to maintain 
> closed sourced drivers). On the other hand, the company wants 
> a clear way to 
> make "profit" from the work while still catering to it's 
> customers whish to 
> recompile the driver for just about any kernel version.
> 
> Here is what they propose... I do not know if what they are 
> proposing is 
> "going too far" regarding kernel module ethics, but I thought 
> I'd ask the 
> question here and see what other people think.
> 
> The hardware needs a firmware to run. Since this firmware is 
> under NDA, the 
> first compromise is to write the main part of the driver GPL 
> but keep the 
> firmware of the card in binary format. The driver can then 
> load the firmware 
> separately and this should not infringe on the GPL and I'm 
> quite ok with 
> this requirement. Now the problem is that any of our 
> competitor's cards will 
> work with the same closed sourced firmware and GPL engine. In pure 
> capitalist thinking, the company finds this particularly 
> troublesome...
> 
> The other compromise is to write a closed source part that 
> would not permit 
> the driver to work with another card supporting the same 
> chipset. Is this 
> kind of practice generally accepted or is it frowned upon? 
> The motive of the 
> company is quite clear. If people want to "improve" the 
> driver, they can 
> only improve it for their hardware, not the competitors. 
> There is also a big 
> marketing sales pitch that goes like "we support linux, the others 
> don&#8217;t..."
> 
> It's like if Nvidia did not have linux drivers and ASUS 
> wanted to ship a 
> card with a linux driver that only works with asus cards even 
> though there 
> is one from leadtek with the exact same chipset (assuming 
> that ASUS cannot 
> change the internals of the card).
> 
> Is the second compromise just "going too far"? Is this better 
> than simply 
> having a 100% closed source driver?
> 
> Thanks!
> Daniel Shane
