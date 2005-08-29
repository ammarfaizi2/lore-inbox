Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbVH2SJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVH2SJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVH2SJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:09:59 -0400
Received: from mail-fra.bigfish.com ([62.209.45.166]:53371 "EHLO
	mail16-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751254AbVH2SJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:09:58 -0400
X-BigFish: V
Message-ID: <43134F6D.1080602@am.sony.com>
Date: Mon, 29 Aug 2005 11:09:49 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Pekka Enberg <penberg@cs.helsinki.fi>, linuxppc64-dev@ozlabs.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] spufs: The SPU file system
References: <200508260003.40865.arnd@arndb.de>	<84144f02050826011778e1142@mail.gmail.com> <200508281844.18187.arnd@arndb.de>
In-Reply-To: <200508281844.18187.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Freedag 26 August 2005 10:17, Pekka Enberg wrote:
> 
>>I am confused. The code is architecture specific and does device I/O. Why do
>>you want to put this in fs/ and not drivers/?
> 
> 
> I never really thought of it as a device driver but rather an architecture
> extension, so it started out in arch/ppc64/kernel. Since most of the code
> is interacting with VFS, it is now in fs/spufs. I don't really care about
> the location, but I among the possible places to put the code (with the
> unified arch/powerpc tree), I'd suggest (best first)
> 
> 1) arch/powerpc/platforms/cell
> 2) arch/powerpc/spe
> 3) fs/spufs
> 4) drivers/spe
> 
> 1) would be the place where I want to have the low-level code
> (currently arch/ppc64/kernel/spu_base.c) anyway, so it makes
> sense to have everything in there that I maintain.
> 2) might work better if we at a later point have multiple platform
> types in arch/powerpc that use SPEs, e.g if we want to keep 
> Playstation code separate from generic Cell.
> 

I think putting it in 'arch/powerpc/platforms/cell' is fine for now.  We'll 
be better able to judge if we need to and how to split off platform specifics 
when we have code for more cell platforms.

-Geoff

