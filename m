Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264751AbUD2VOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264751AbUD2VOa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbUD2VLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:11:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:15331 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264868AbUD2VLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:11:04 -0400
Date: Thu, 29 Apr 2004 14:10:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Giuliano Colla <copeca@copeca.dsnet.it>
cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       hsflinux@lists.mbsi.ca, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about
 their license
In-Reply-To: <40914C35.1030802@copeca.dsnet.it>
Message-ID: <Pine.LNX.4.58.0404291404100.1629@ppc970.osdl.org>
References: <408DC0E0.7090500@gmx.net> <40914C35.1030802@copeca.dsnet.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Apr 2004, Giuliano Colla wrote:
> 
> Let's try not to be ridiculous, please.

It's not abotu being ridiculous. It's about honoring peoples copyrights.

> As an end user, if I buy a full fledged modem, I get some amount of 
> proprietary, non GPL, code  which executes within the board or the 
> PCMCIA card of the modem. The GPL driver may even support the 
> functionality of downloading a new version of *proprietary* code into 
> the flash Eprom of the device. The GPL linux driver interfaces with it, 
> and all is kosher.

Indeed. Everything is kosher, because the other piece of hardware and 
software has _nothing_ to do with the kernel. It's not linked into it, it 
cannot reasonably corrupt internal kernel data structures with random 
pointer bugs, and in general you can think of firmware as part of the 
_hardware_, not the software of the machine.

> On the other hand, I have the misfortune of being stuck with a 
> soft-modem, roughly the *same* proprietary code is provided as a binary 
> file, and a linux driver (source provided) interfaces with it. In that 
> case the kernel is flagged as "tainted".

It is flagged as tainted, because your argument that it is "the same code" 
is totally BOGUS AND UNTRUE!

In the binary kernel module case, a bug in the code corrupts random data 
structures, or accesses kernel internals without holding the proper locks, 
or does a million other things wrong, BECAUSE A KERNEL MODULE IS VERY 
INTIMATELY LINKED WITH THE KERNEL.

A kernel module is _not_ a separate work, and can in _no_ way be seen as 
"part of the hardware". It's very much a part of the _kernel_. And the 
kernel developers require that such code be GPL'd so that it can be fixed, 
or if there's a valid argument that it's not a derived work and not GPL'd, 
then the kernel developers who have to support the end result mess most 
definitely do need to know about the taint.

You are not the first (and sadly, you likely won't be the last) person to 
equate binary kernel modules with binary firmware. And I tell you that 
such a comparison is ABSOLUTE CRAPOLA. There's a damn big difference 
between running firmware on another chip behind a PCI bus, and linking 
into the kernel directly.

And if you don't see that difference, then you are either terminally 
stupid, or you have some ulterior reason to claim that they are the same 
case even though they clearly are NOT.

> Can you honestly tell apart the two cases, if you don't make a it a case 
> of "religion war"?

It has absolutely nothing to do with religion.

		Linus
