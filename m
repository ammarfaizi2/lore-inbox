Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbSKSLM4>; Tue, 19 Nov 2002 06:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265191AbSKSLM4>; Tue, 19 Nov 2002 06:12:56 -0500
Received: from mta04ps.bigpond.com ([144.135.25.136]:20469 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S265190AbSKSLMz>; Tue, 19 Nov 2002 06:12:55 -0500
Message-ID: <3DDA1E8A.9000508@bigpond.com>
Date: Tue, 19 Nov 2002 22:20:42 +1100
From: Allan Duncan <allan.d@bigpond.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: modutils url for: Re: Linux v2.5.48
References: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com> <20021118063229.GA7327@outpost.ds9a.nl>
In-Reply-To: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

> On Sun, Nov 17, 2002 at 08:41:05PM -0800, Linus Torvalds wrote:
>
>
> >Hmm.. All over the place, best you see the changelog. Lots of small
> >cleanups (remove unnecessary header files etc), but a few more fundamental
> >changes too. Times in nsecs in stat64(), for example, and the
> >oft-discussed kernel module loader changes..
>
>
> To get this to load modules, you need:
> http://www.kernel.org/pub/linux/kernel/people/rusty/module-init-tools-0.7.tar.gz

Does this then make depmod happy?

Without it I get heaps of (eg)
depmod: *** Unresolved symbols in /lib/modules/2.5.48/kernel/zlib_deflate.o

I tried applying Adam Richter's module device ID tables patch without success.


#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_KMOD=y

Turning off KMOD, or turning on UNLOAD makes no difference.

depmod version 2.4.18  I tried the latest 2.4.21 as well.

