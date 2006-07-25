Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWGYGAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWGYGAS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 02:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWGYGAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 02:00:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23450 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751111AbWGYGAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 02:00:15 -0400
Date: Mon, 24 Jul 2006 23:00:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Edgar Hucek <hostmaster@ed-soft.at>, ebiederm@xmission.com, hpa@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add efi e820 memory mapping on x86 [try #1]
In-Reply-To: <Pine.LNX.4.64.0607242227340.29649@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0607242246530.29649@g5.osdl.org>
References: <44A04F5F.8030405@ed-soft.at> <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
 <44A0CCEA.7030309@ed-soft.at> <Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
 <44A304C1.2050304@zytor.com> <m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
 <44A8058D.3030905@zytor.com> <m11wt3983j.fsf@ebiederm.dsl.xmission.com>
 <44AB8878.7010203@ed-soft.at> <m1lkr83v73.fsf@ebiederm.dsl.xmission.com>
 <44B6BF2F.6030401@ed-soft.at> <Pine.LNX.4.64.0607131507220.5623@g5.osdl.org>
 <44B73791.9080601@ed-soft.at> <Pine.LNX.4.64.0607140901200.5623@g5.osdl.org>
 <44B9FF02.3020600@ed-soft.at> <20060724212911.32dd3bc0.akpm@osdl.org>
 <Pine.LNX.4.64.0607242227340.29649@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Jul 2006, Linus Torvalds wrote:
> 
> Sadly, Apple bought into the whole "BIOS bad, EFI good" hype, so we now 
> have x86 machines with EFI as the native boot protocol.

Btw, that's not totally new. I think some people played around with EFI on 
x86 even before Apple came around. And don't get me wrong - the problem 
with EFI is that it actually superficially looks much better than the 
BIOS, but in practice it ends up being one of those things where it has 
few real advantages, and often just a lot of extra complexity because of 
the "new and improved" interfaces that were largely defined by a 
committee.

I think a lot of the "new standards" tend to be that way. Trying to solve 
a lot of problems and allow everybody to add their own features, instead 
of just saying that it's better to just standardize the hardware.

For example, instead of ACPI, we could just have had standardized hardware 
(and a few tables to define things like numbers of CPU's etc). It would 
have been simpler for everybody. But no, people seem to think that it's 
somehow "better" to have wild and crazy hardware, and then have a really 
complicated way of describing it - and driving it - dynamically.

So EFI has this cool shell, a loadable driver framework, and other nice 
features. Where "nice" obviously means "much more complex than the simple 
things they designed in the late seventies back when people were stupid 
and just wanted things to work".

Of course, it's somewhat questionable whether people have actually gotten 
smarter or stupider in the last 30 years. It's not enough time for 
evolution to have increased our brain capacity, but it certainly _is_ 
enough time for most people to no longer understand how hardware works any 
more.

Not a good combination, in other words.

Not that I'd ever claim that the BIOS is wonderful either, but at least 
everybody knows that the BIOS is just a bootloader, and doesn't try to 
make it anything else. 

The absolutely biggest advantage of a BIOS is that it's _so_ inconvenient 
and obviously oldfashioned, that you have to be crazy to want to do 
anything serious in it. Real mode, 16-bit code is actually an _advantage_ 
in that sense. People know how to treat it, and don't get any ideas about 
it being some grandiose framework for anything else than "just load the OS 
and get the hell out of there".

			Linus
