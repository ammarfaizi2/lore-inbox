Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261702AbTCZOWQ>; Wed, 26 Mar 2003 09:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261705AbTCZOWQ>; Wed, 26 Mar 2003 09:22:16 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:36800 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S261702AbTCZOWP>; Wed, 26 Mar 2003 09:22:15 -0500
From: Erik Hensema <usenet@hensema.net>
Subject: Re: LVM/Device mapper breaks with -mm (was: Re: 2.5.66-mm1)
Date: Wed, 26 Mar 2003 14:33:25 +0000 (UTC)
Message-ID: <slrnb83ehl.196.usenet@bender.home.hensema.net>
References: <20030326013839.0c470ebb.akpm@digeo.com> <slrnb8373s.19a.usenet@bender.home.hensema.net> <20030326134834.GA11173@win.tue.nl>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer (aebr@win.tue.nl) wrote:
> On Wed, Mar 26, 2003 at 12:26:37PM +0000, Erik Hensema wrote:
>> Andrew Morton (akpm@digeo.com) wrote:
>> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.66/2.5.66-mm1/
> 
>> LVM or device mapper seems to be broken in -mm. I've only tried the
>> following kernels so far:
>> 2.5.64 - works
>> 2.5.65-mm2 - doesn't work
>> 2.5.66 - works
>> 2.5.66-mm1 - doesn't work
> 
> Probably you are hit by
> 
>   dev_t-32-bit.patch
>     [for playing only] change type of dev_t
[...]
> You can revert this single patch and probably all will be fine.

For now I've reverted this patch and LVM is working again.

> More interesting would be to apply
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103956089203199&w=3

I'd rather not change the ioctl interface, since that would make dual
booting with 2.5-vanilla harder.

-- 
Erik Hensema <erik@hensema.net>
