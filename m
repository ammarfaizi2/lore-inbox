Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265280AbTLLQDa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbTLLQD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:03:29 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:12483 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265280AbTLLQD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:03:27 -0500
Date: Fri, 12 Dec 2003 17:03:25 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031212160325.GI6112@wohnheim.fh-wedel.de>
References: <20031211125806.B2422@hexapodia.org> <017c01c3c01b$232bd130$d43147ab@amer.cisco.com> <20031211194815.GA10029@wohnheim.fh-wedel.de> <20031211135854.A29359@hexapodia.org> <20031212121824.GA6112@wohnheim.fh-wedel.de> <20031212094031.B1303@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031212094031.B1303@hexapodia.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 December 2003 09:40:31 -0600, Andy Isaacson wrote:
> 
> A related idea was reportedly used in the Venti filesystem, which was
> discussed on linux-kernel back in October; look for the thread
> "Transparent compression in the FS".
> 
> The downsides are pretty substantial (but the upsides are too).  You
> don't know how many blocks are available on the filesystem for you to
> write, because when you write you might not allocate blocks.  And you
> lose disk-streaming-perfomance, because you're going to be seeking all
> over the disk picking up the blocks for your files.

Right - to some degree.  I'm sure many problems can be dealt with, but
it takes a lot of time to sort out the details.  For streaming
performance, I guess in most cases you will get the same performance
because you won't find a single duplicate block in those files.  Two
competing readers should be a much bigger problem.

Still, there are more problems, no doubt.

> > But we should get there some day.  Having 15 nearly identical copies
> > of the kernel on my notebook is a pain and hard links simply have the
> > wrong semantics.
> 
> I don't know about you, but I don't have 15 nearly identical copies of
> the kernel; I have 30 copies that have almost no text in common, and
> certainly have no blocks in common -- they result from independent
> compilations, and the resulting bzImage files are not duplicates.

s/kernel/kernel source/

If it was just the images, I couldn't care less.  But 15x 200-300 Megs
does hurt a bit. :)
grep -r over multiple trees hurts even more, when RAM spills over.

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
