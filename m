Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262297AbSIPOtc>; Mon, 16 Sep 2002 10:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbSIPOtc>; Mon, 16 Sep 2002 10:49:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36532 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262297AbSIPOtb>;
	Mon, 16 Sep 2002 10:49:31 -0400
Date: Mon, 16 Sep 2002 16:53:44 +0200
From: Jens Axboe <axboe@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Daniel Phillips <phillips@arcor.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020916145344.GN12364@suse.de>
References: <20020916090616.GF12364@suse.de> <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com> <E17qejV-00008L-00@starship> <24433.1032185643@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24433.1032185643@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16 2002, David Woodhouse wrote:
> 
> axboe@suse.de said:
> >  See, even though I'm not fundamentally against using kernel
> > debuggers, I think this is very wrong. Where are you now? You are just
> > learning about the bio interface and the changes needed to make it
> > run. And this is definitely the most wrong point to start using a
> > debugger, and can only result in a dac960 that works by trial and
> > error.
> 
> Nevertheless, the existence of a case where it's not sensible to use a 
> debugger does not prove the non-existence of cases where it _is_ sensible 
> to use a debugger. 
> 
> A case that happened to me recently -- tail-call optimisations screwed up
> the return value of a function somewhere deep in the routing code. Adding a
> printk made the problem go away. Staring at the C code was also of no use --
> the C code was just fine.
> 
> Now, are you seriously suggesting that instead of using GDB to work out WTF 
> was going on I should have spent three weeks starting at the output of 
> 'objdump -d vmlinux' ?

I'm not suggesting anything for your case, and I'm not arguing against
kernel debuggers. Please re-read what I wrote: using a debugger for what
Daniel is attempting right now is stupid. Are you seriously suggesting
that you would trust your data to a driver that had been ported to 2.5,
not by studying the interface changes but by 'code blow up, gdb
inspection' method? I hope not.

I've used a kernel debugger a few times, for the things I tend to do
it's not very helpful. Or let me rephrase that into saying that it's not
more helpful than simply having the kernel compiled with -g and using
gdb on the resulting vmlinux just for backtraces and code inspection. So
I'm fine, and so I don't care very much about the typical pro/con
integrated debugger debates.

-- 
Jens Axboe

