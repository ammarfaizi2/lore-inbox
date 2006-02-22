Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWBVPqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWBVPqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWBVPqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:46:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29861 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750790AbWBVPqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:46:19 -0500
Date: Wed, 22 Feb 2006 07:44:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kay Sievers <kay.sievers@suse.de>
cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
In-Reply-To: <20060222152743.GA22281@vrfy.org>
Message-ID: <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> <20060217231444.GM4422@stusta.de>
 <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
 <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost>
 <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost>
 <20060221225718.GA12480@vrfy.org> <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI>
 <20060222152743.GA22281@vrfy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Feb 2006, Kay Sievers wrote:
> 
> Well, that's part of the contract by using an experimental version of HAL,
> it has nothing to do with the kernel

NO NO NO!

Dammit, if this is the logic and mode of operation of HAL people, then we 
must stop accepting patches to the kernel from HAL people.

THIS IS NOT DEBATABLE.

If you cannot maintain a stable kernel interface, then you damn well 
should not send your patches in for inclusion in the standard kernel. Keep 
your own "HAL-unstable" kernel and ask people to test it there.

It really is that easy. Once a system call or other kernel interface goes 
into the standard kernel, it stays that way. It doesn't get switched 
around to break user space.

Bugs happen, and sometimes we break user space by mistake. Sometimes it 
really really is inevitable. But we NEVER EVER say what you say: "it's 
your own fault". It's _our_ fault, and it's _our_ problem to work out.

Guys: you now have two choices: fix it by sending me a patch and an 
explanation of what went wrong, or see the patch that broke things be 
reverted. And STOP THIS DAMN APOLOGIA. 

I'm fed up with hearing how "breaking user space is ok because it's HAL or 
hotplug". IT IS NOT OK. Get your damn act together, and stop blaming other 
people. 

If the interfaces were bad, we keep them around. Look in fs/stat.c some 
day. Realize that some of those interfaces are from 1991. They were bad, 
but that doesn't change _anything_. People used them, and we had 
implemented them.

			Linus
