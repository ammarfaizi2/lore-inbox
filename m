Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbSIPOJ7>; Mon, 16 Sep 2002 10:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbSIPOJ7>; Mon, 16 Sep 2002 10:09:59 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:54520 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261619AbSIPOJ7>; Mon, 16 Sep 2002 10:09:59 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020916090616.GF12364@suse.de> 
References: <20020916090616.GF12364@suse.de>  <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com> <E17qejV-00008L-00@starship> 
To: Jens Axboe <axboe@suse.de>
Cc: Daniel Phillips <phillips@arcor.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Sep 2002 15:14:03 +0100
Message-ID: <24433.1032185643@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


axboe@suse.de said:
>  See, even though I'm not fundamentally against using kernel
> debuggers, I think this is very wrong. Where are you now? You are just
> learning about the bio interface and the changes needed to make it
> run. And this is definitely the most wrong point to start using a
> debugger, and can only result in a dac960 that works by trial and
> error.

Nevertheless, the existence of a case where it's not sensible to use a 
debugger does not prove the non-existence of cases where it _is_ sensible 
to use a debugger. 

A case that happened to me recently -- tail-call optimisations screwed up
the return value of a function somewhere deep in the routing code. Adding a
printk made the problem go away. Staring at the C code was also of no use --
the C code was just fine.

Now, are you seriously suggesting that instead of using GDB to work out WTF 
was going on I should have spent three weeks starting at the output of 
'objdump -d vmlinux' ?

While my balls are big enough and hairy enough that I don't need to use GDB
to debug my own code, I feel no shame in admitting that I'm so much of a
pussy I can't deal with the above case without GDB.

--
dwmw2


