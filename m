Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267203AbSLKTVW>; Wed, 11 Dec 2002 14:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbSLKTVW>; Wed, 11 Dec 2002 14:21:22 -0500
Received: from ostia.INS.CWRU.Edu ([129.22.8.4]:29907 "EHLO ostia.INS.cwru.edu")
	by vger.kernel.org with ESMTP id <S267203AbSLKTVV>;
	Wed, 11 Dec 2002 14:21:21 -0500
Date: Wed, 11 Dec 2002 14:30:49 -0500
From: Justin Hibbits <jrh29@po.cwru.edu>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Destroying processes
Message-ID: <20021211193049.GH147@lothlorien.cwru.edu>
References: <20021211190132.GF147@lothlorien.cwru.edu> <1039634515.833.57.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039634515.833.57.camel@phantasy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 02:21:55PM -0500, Robert Love wrote:
> Cases where kill -9 fail to work are cases where it is supposed to fail.
> 
> You cannot kill zombies, that would break POSIX compliance when the
> parent's called wait.  If you task's parents are not properly calling
> wait() that is an application bug.  If the parent exits, the children
> should be reparented to init and init will reap them via wait().
> 
> You also cannot kill tasks that are sleeping (D in ps/top).  They may
> hold a semaphore or otherwise be in the middle of a critical section. 
> Killing them would be bad bad bad.
> 
> 	Robert Love

Ok, thanks for clearing that up.  My reasoning for wanting this is because a CD
I had mounted with cdfs was screwed up in the mount (file sizes were
misreported, etc), and I couldn't umount it, even tho I could eject it with
cdrecord -eject.  The umount process then went to sleep (with teh 'D' showing
in ps/top), and I couldn't use that drive again until after a reboot.  That's
when I got the idea that I should be able to destroy the process completely,
annihilating everything with it, destroying any connections it has with the
kernel, etc.  I guess it's a bad idea, given your statement :P

Anyway, thanks for the reply,

Justin

-- 
Registered Linux user 260206

"One World, One Web, One Program"
	- Microsoft Promo Ad
"Ein Volk, Ein Reich, Ein Fuhrer"
	- Adolf Hitler

I'm not paranoid.  They really *are* out to get me!

