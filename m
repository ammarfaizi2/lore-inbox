Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760575AbWLFM6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760575AbWLFM6J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 07:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760576AbWLFM6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 07:58:08 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:47562 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760575AbWLFM6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 07:58:07 -0500
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
From: Kasper Sandberg <lkml@metanurb.dk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ak@muc.de, vojtech@suse.cz
In-Reply-To: <200612052134_MC3-1-D40B-A5DB@compuserve.com>
References: <200612052134_MC3-1-D40B-A5DB@compuserve.com>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 13:58:00 +0100
Message-Id: <1165409880.15706.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 21:31 -0500, Chuck Ebbert wrote:
> In-Reply-To: <26586.1165356671@redhat.com>
> 
> On Tue, 05 Dec 2006 22:11:11 +0000, David Howells wrote:
> 
> > > I only have 32-bit userspace.  When I run your program against
> > > a directory on a JFS filesystem (msdos ioctls not supported)
> > > I get this on vanilla 2.6.19:
> > 
> > Can I just check?  You're using an x86_64 CPU in 64-bit mode with a 64-bit
> > kernel, but with a completely 32-bit userspace?
> 
> It's FC5 i386 so there's no way any 64-bit userspace code is in there.
> (I have a cross-compiler only for building kernels.)  Having a pure
> 32-bit userspace lets me switch between i386 and x86_64 kernels
> without having to maintain two separate Linux installs.
> 
> > A question for you: Why is userspace assuming that it'll get ENOTTY rather
> > than EINVAL?
> 
> I'm not sure it is, but that's what it used to get.
> 
> Kasper, what problems (other that the annoying message) are you having?
if it had only been the messages i wouldnt have complained.
the thing is, when i get these messages, the app provoking them acts
very strange, and in some cases, my system simply hardlocks.

and i am very very sure its because of this, i can run with the kernel
(atleast with rc5 i had that long) for 10 days, and then chroot in, run
the 32bit apps, and within hours of using, hardlock.

wine seems to be worst at provoking hardlock, however i encountered one
i am sure was caused by java(the 32bit one inside chroot).

as i said in my post yesterday, my chroot doesent have access to my vfat
partitions, so i dont believe thats it.
> 

