Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWF2Ap7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWF2Ap7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWF2Ap7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:45:59 -0400
Received: from terminus.zytor.com ([192.83.249.54]:16363 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932096AbWF2Ap7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:45:59 -0400
Message-ID: <44A322BB.2010006@zytor.com>
Date: Wed, 28 Jun 2006 17:45:47 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       klibc@zytor.com
Subject: Re: [klibc 07/31] i386 support for klibc
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <klibc.200606272217.07@tazenda.hos.anvin.org> <Pine.LNX.4.61.0606280937150.29068@yvahk01.tjqt.qr> <44A2A147.9020501@zytor.com> <Pine.LNX.4.64.0606290207580.17704@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0606290207580.17704@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Wed, 28 Jun 2006, H. Peter Anvin wrote:
> 
>> The i386 ones are a bit special... usually the reason I have added libgcc
>> functions is that on some architectures, gcc has various problems linking with
>> libgcc in some configurations.
> 
> If gcc has problems to link its own libgcc you really have a serious 
> problem...

The way libgcc is handled inside gcc is, indeed, completely screwed up; 
even the gcc people admit that.  They pretty much don't have a way to 
handle the effects of compiler options on libgcc, especially the ones 
that affect binary compatibility.

However, that affects only a small minority of configurations (MIPS is one.)

> The standard libgcc may not be as small as you like, but it still should 
> be the first choice. If there is a problem with it, the gcc people do 
> accept patches.

That's just an asinine statement.  Under that logic we should just 
forget about the kernel and go hack the gcc bugs du jour; we certainly 
have enough workarounds for gcc bugs in the kernel.

There is absolutely nothing wrong with providing an override for a 
function which has well-defined semantics.  If new functions are needed, 
they are pulled from libgcc.

	-hpa
