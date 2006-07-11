Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWGKQY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWGKQY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWGKQY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:24:26 -0400
Received: from terminus.zytor.com ([192.83.249.54]:7048 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751018AbWGKQYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:24:25 -0400
Message-ID: <44B3D0A0.7030409@zytor.com>
Date: Tue, 11 Jul 2006 09:24:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       torvalds@osdl.org, klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de>
In-Reply-To: <20060711112746.GA14059@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> 
>>> The other group is the one that uses some sort of initrd (loop mount or cpio),
>>> created with tools from their distribution.
>>> Again, they should install that kinit binary as well because kinit emulates
>>> the loop mount handling of /initrd.image. This is for older distributions
>>> that still create a loop mounted initrd.
>> There's no need for loop-mounting of any initrd.images.  Initramfs (cpio image,
>> possible gzipped) works just fine, and it will NOT go away because something
>> should do the unpacking/loading of that image so that kinit &Co will run.
>> There's no need for old initrd+pivot_root at all.  Only the ones who are,
>> for some reason, didn't switch to initramfs yet.  And I personally see no
>> reasons not to switch - initramfs (rootfs) concept is much more clean and
>> easy to handle and gives more possibilities than initrd.
> 
> Are you saying that everyone now suddenly is forced to use a cpio image?
> Why did hpa add the loop mount code to kinit?
> So if you force people who build kernels to use newer tools, one more
> external binary will surely not hurt.

When you say "loop mount code" I presume you mean legacy initrd support 
(which doesn't use loop mounting.)  Legacy initrd support is provided to 
be as compatible as possible, obviously.

And yes, it should be a configurable.  Chopping kinit into configurable 
pieces is on my short list.

	-hpa
