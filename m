Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWAANQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWAANQQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 08:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWAANQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 08:16:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13328 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751342AbWAANQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 08:16:15 -0500
Date: Sun, 1 Jan 2006 14:16:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bradley Reed <bradreed1@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
Message-ID: <20060101131615.GT3811@stusta.de>
References: <20051231202933.4f48acab@galactus.example.org> <1136106861.17830.6.camel@laptopd505.fenrus.org> <20060101115121.034e6bb7@galactus.example.org> <20060101115038.GR3811@stusta.de> <20060101145402.0c6292bb@galactus.example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060101145402.0c6292bb@galactus.example.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 02:54:02PM +0200, Bradley Reed wrote:
> On Sun, 1 Jan 2006 12:50:38 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > MPlayer has more than enough output drivers including some that work 
> > without the nvidia module.
> > 
> > If your problem was an RTC one, it might have even trigger using the 
> > AAlib output driver.
> 
> True, I can reproduce this kernel bug by running mplayer with AAlib
> output without nvidia's module loaded. I never run mplayer under usual
> use with the aalib library and never thought to test with it. If I had
> been asked to try that, I would have.
> 
> Yes, I understand that GPL fanatics like Arjan refuse to look at bugs
> from tainted kernels, regardless of whether the tainted kernel module
> is at fault. That is his right. So be it. 
>...

It's not about the GPL, it's simply a matter of fact that noone can 
debug a kernel if any binary-onluy module was ever loaded.

There have been too many problems in the past where after hours of 
debugging it turned out that it wasn't reproducible without the nvidia 
module.

> Reporting all kernel bugs SOLELY to the source of a binary kernel
> module (NVidia in my case) is rather pointless as the only thing that
> changed in my system is the kernel. Their logical conclusion is the bug
> is in the part of the system that changed, i.e. the kernel. In this
> case it was a kernel bug as Mr. Rostedt's patch showed.
>...

A kernel module can do _anything it wants_ in the whole kernel.

If the nvidia module did something in a strange and completely 
unsupported way or if the nvidia module contained a bug that only
wasn't triggered before a bug might not be in the changed kernel.

In your case the bug was in the kernel, but who can debug such bugs?

We don't have the sources for the nvidia module.
The nvidia developers have the source of the kernel.

Guess who has the source of everything involved and can therefore 
debug the problem...

> Brad

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

