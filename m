Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbRE2ILu>; Tue, 29 May 2001 04:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbRE2ILk>; Tue, 29 May 2001 04:11:40 -0400
Received: from fungus.teststation.com ([212.32.186.211]:40698 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S261392AbRE2ILc>; Tue, 29 May 2001 04:11:32 -0400
Date: Tue, 29 May 2001 10:11:09 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Daniel Rose <daniel.rose@datalinesolutions.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: (via-rhine.c problem) 2.4.5 and pppd/pppoe
In-Reply-To: <991110870.912.3.camel@rocket>
Message-ID: <Pine.LNX.4.30.0105290928240.31793-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 May 2001, Daniel Rose wrote:

> Ok, I have decided the problem lays in via-rhine.c, the ethernet driver
> for my card. The second boot finds the mac address as 00's all the time,
> regardless of whether the driver is compiled as a module, or monolith.

Do you boot something else in between? Like win98? There is a known
problem with the via-rhine driver not being able to restart some versions
of the card after win98 has shut it down. Perhaps some bioses do similar
clever things.

This seems to only happen with newer chips that have power management
support. If you don't boot into win98, perhaps you can play with bios
settings until the driver is fixed (or fix the driver of course).

Which type of via-rhine do you have? (manufacturer, model of card)
When you boot what does dmesg say about eth0? (or lspci -n)


D-Link makes a card called DFE-530TX. If you have that it can be one of
(at least) 2 different versions. Could you in addition to sending lspci
info identify which of these images match best?

DFE-530TX REV-A1 (vt3043, PCI ID 1106:3043)
http://www.intozgc.com/2001jrsc/200103/200103image/26%B5%DA%B6%FE%D6%D6.jpg

DFE-530TX REV-B1 (hopefully vt6102, PCI ID 1106:3065 but I'm not sure)
http://www.intozgc.com/2001jrsc/200103/200103image/26%D5%FD%C6%B7.jpg

or this which is also called B1 ... but a chip with different markings.
http://www.intozgc.com/2001jrsc/200103/200103image/26%B5%DA%D2%BB%D6%D6.jpg

This page tries to explain something about card versions, but I don't
speak the language (which ever it is).
http://www.intozgc.com/2001jrsc/200103/20010326.htm

I think the conclusion is DL10030A -> REV-B1, DL10030 -> REV-A1.

/Urban

