Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWJDVOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWJDVOb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWJDVOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:14:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64013 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751137AbWJDVOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:14:31 -0400
Date: Wed, 4 Oct 2006 23:14:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: removed sysctl system call - documentation and timeline
Message-ID: <20061004211428.GB16812@stusta.de>
References: <9a8748490610041335t519678d1u61f5775293c061e4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490610041335t519678d1u61f5775293c061e4@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 10:35:01PM +0200, Jesper Juhl wrote:
> Hi,
> 
> With recent kernels I'm getting a lot of warnings about programs using
> the removed sysctl syscal.
> 
> Examples (after 5 min of uptime here) :
> root@dragon:/home/juhl# dmesg | grep "used the removed sysctl system
> call" | sort | uniq
> warning: process `dd' used the removed sysctl system call
> warning: process `ls' used the removed sysctl system call
> warning: process `touch' used the removed sysctl system call
> 
> and more can be found...
> 
> 
> I'm not, as such, opposed to removing sysctl (and yes, I know what it
> is and what it does). What I am a little opposed to is that it is
> being removed on such short notice (unless I missed the memo) and that
> it is hidden inside EMBEDDED.
> 
> I would like to propose that, at least for 2.6.19, it be default on
> (as it is now), not hide it in EMBEDDED where people usually don't go,

This abuse of EMBEDDED is nonsense.

SYSCTL_SYSCALL should be moved above EMBEDDED (for not breaking the 
menu), and the "if EMBEDDED" removed.

> some huge deprecation warnings be added, and that it then gets the
> usual 6-12months before being removed (did it already get that and I'm
> just slow?)...  ohhh, and correct the help text; it currently says

It seems you are slow...

It's entry in Documentation/feature-removal-schedule.txt fulfills the
6 months.

> "...Nothing has been using the binary sysctl interface for some time
> now so nothing should break if you disable sysctl syscall support" -
> that's obviously false as demonstrated by the above extract from my
> dmesg...

What did actually break (a dmesg message is not a breakage)?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

