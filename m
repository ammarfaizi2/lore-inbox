Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbVIOKps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbVIOKps (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 06:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVIOKps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 06:45:48 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:15073 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932579AbVIOKps
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 06:45:48 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Valdis.Kletnieks@vt.edu
Cc: marekw1977@yahoo.com.au, linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Thu, 15 Sep 2005 03:44:24 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Automatic Configuration of a Kernel 
In-Reply-To: <200509150618.j8F6I9ji020578@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.62.0509150341290.9384@qynat.qvtvafvgr.pbz>
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com>
 <Pine.LNX.4.62.0509141900280.8469@qynat.qvtvafvgr.pbz>
 <1126753444.13893.123.camel@mindpipe><200509151418.13927.marekw1977@yahoo.com.au>
 <200509150618.j8F6I9ji020578@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2005 Valdis.Kletnieks@vt.edu wrote:

> On Thu, 15 Sep 2005 14:18:13 +1000, Marek W said:
>
>> Not so much the kernel. When compiling the kernel I'd prefer not to waste time
>> and space compiling the 100+ modules I will never ever use on my laptop.
>
> It's actually  a lot worse than that - here's my minimized custom kernel that
> drives everything on my laptop and then some, and a recent Fedora kernel:
>
> [/lib/modules]2 find 2.6.13-mm1/kernel/drivers -name '*.ko' | wc -l
> 37
> [/lib/modules]2 find 2.6.12-1.1400_FC5/kernel/drivers/ -name '*.ko' | wc -l
> 832
>
> (OK, so I *do* have a few builtins that Fedora builds as modules. That's gonna
> change the numbers by half a dozen or so...)
>
>>                                                                          I'd
>> prefer for something to select the modules necessary for my hardware. I can't
>> afford the time to keep up to date with that's new and what isn't, what has
>> changed, what has been superseded, which module works with which device,
>> chipset even, etc...
>
> I'm of the opinion that if you don't have that much time, you should be using a
> distro kernel where somebody *else* is taking the time.  If you're the type
> that builds their own kernel, the *last* thing you want is a tool glossing over
> the fact that a module has been superceded.  Who's going to take care of the
> matching changes for /etc/modprobe.conf and similar userspace changes, and
> other stuff like that? (I figure if 'make oldconfig' asks a question, I should
> take notice, and any userspace changes that don't get made are my fault - and
> if 'make oldconfig' switches drivers on me without asking, that's a *bug* that
> lkml will hear about.. ;)

sometimes tracking down exactly what options need to be enabled to let you 
at other options that apply to your system can be quite a chore, a tool to 
start from no .config file and get you one that is tailered to your system 
could be useful.

I agree that make oldconfig shouldn't do this type of thing, but that 
requires that youhave an existing .config for the box. if you do a make 
autoconfig you are explicitly asking the software to do this for you.

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
