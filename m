Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265647AbRGKTNG>; Wed, 11 Jul 2001 15:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265586AbRGKTM4>; Wed, 11 Jul 2001 15:12:56 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:2822 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265005AbRGKTMt>; Wed, 11 Jul 2001 15:12:49 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Switching Kernels without Rebooting?
Date: 11 Jul 2001 12:12:35 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ii8f3$pc9$1@cesium.transmeta.com>
In-Reply-To: <3B4C21DA.5FFCBE2@uni-mb.si> <JKEGJJAJPOLNIFPAEDHLGEEFDFAA.laramie.leavitt@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <JKEGJJAJPOLNIFPAEDHLGEEFDFAA.laramie.leavitt@btinternet.com>
By author:    "Laramie Leavitt" <laramie.leavitt@btinternet.com>
In newsgroup: linux.dev.kernel
> 
> So if the Two Kernel Monte patch was combined with the
> system suspend/resume in swap patch then you add some
> transitions so that the code path does this:
> 
> 1-  Suspend->Monte
> 2-  Monte->Load new Kernel
> 3-  Load->Resume.
> 
> If it was just for very similar kernels, i.e. most
> -pre and -ac kernels it would probably work fine.
> If not, then you could just do the Monte route.
> 

The problem is that "freezing" the kernel state and then
reconstructing it into a form USABLE BY ANOTHER KERNEL (not even
necessarily another kernel version) is unbelievably hard; furthermore,
it imposes a severe constrains about the kind of changes you're
allowed to make during your kernel development.

It's a bad idea, folks. Give it up.

     -hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
