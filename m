Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbTCGXhc>; Fri, 7 Mar 2003 18:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261920AbTCGXhT>; Fri, 7 Mar 2003 18:37:19 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:22284 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261911AbTCGXgS>;
	Fri, 7 Mar 2003 18:36:18 -0500
Date: Fri, 7 Mar 2003 15:36:53 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
Message-ID: <20030307233653.GD21315@kroah.com>
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv> <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 03:05:32PM -0800, Linus Torvalds wrote:
> 
> However, I also have to say that klibc is pretty late in the game, and as 
> long as it doesn't add any direct value to the kernel build the whole 
> thing ends up being pretty moot right now. It might be different if we 
> actually had code that needed it (ie ACPI in user space or whatever).

I know it's late, sorry.
But a lot of code that will need klibc, has not been converted to need
it yet, due to it not being there :)

If we add klibc to the build process, then those early boot processes
(like network boot, mounting of the root fs, acpi userspace parsers,
etc.) can later be added.  Without it, the whole initramfs code is
pretty worthless right now.  I purposely made these changesets up to
show how to use klibc, but not move any required functions over to it.

If you want to wait, and have me work on moving some of the existing
kernel code to userspace, using klibc, to prove it is needed in the
tree, I will be glad to do that.  But in talking previously, I thought
the goal was to provide the functionality so that people can slowly move
those functions out of kernelspace, over time.

thanks,

greg k-h
