Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWF2XyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWF2XyV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWF2XyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:54:21 -0400
Received: from terminus.zytor.com ([192.83.249.54]:40388 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751312AbWF2XyU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:54:20 -0400
Message-ID: <44A4681B.8020406@zytor.com>
Date: Thu, 29 Jun 2006 16:54:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       klibc@zytor.com
Subject: Re: [klibc 07/31] i386 support for klibc
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <klibc.200606272217.07@tazenda.hos.anvin.org> <Pine.LNX.4.61.0606280937150.29068@yvahk01.tjqt.qr> <44A2A147.9020501@zytor.com> <Pine.LNX.4.64.0606290207580.17704@scrub.home> <44A322BB.2010006@zytor.com> <Pine.LNX.4.64.0606300133050.12900@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0606300133050.12900@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

>> The way libgcc is handled inside gcc is, indeed, completely screwed up; even
>> the gcc people admit that.  They pretty much don't have a way to handle the
>> effects of compiler options on libgcc, especially the ones that affect binary
>> compatibility.
> 
> Nobody said it's perfect. Especially the last point speaks against 
> multiple versions of the same library, as it makes it hard to mix 
> binaries/libraries. With a single kinit binary it's not really a problem 
> yet, but will it stay this way?

What on earth are you talking about?

a. The semantics of these functions are well-defined, stable, and 
documented in the gcc documentation.  It's not like they have 
compiler-version-specific definitions that could change.

b. For static binaries, this is no issue.  klibc is shared, not dynamic 
(thus eliminating the need for a space-consuming dynamic linker), but it 
also means that there is no cross-version calling; each build of the 
shared klibc library has a hashed filename, thus allowing multiple 
versions of klibc to coexist if absolutely necessary.

Either way, this is a red herring.

>>> The standard libgcc may not be as small as you like, but it still should be
>>> the first choice. If there is a problem with it, the gcc people do accept
>>> patches.
>> That's just an asinine statement.  Under that logic we should just forget
>> about the kernel and go hack the gcc bugs du jour; we certainly have enough
>> workarounds for gcc bugs in the kernel.
> 
> Sorry, but I can't follow this logic.

I'm not entirely surprised.

	-hpa
