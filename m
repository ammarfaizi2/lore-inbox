Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266454AbSKGGAl>; Thu, 7 Nov 2002 01:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266457AbSKGGAl>; Thu, 7 Nov 2002 01:00:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40260 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266454AbSKGGAj>; Thu, 7 Nov 2002 01:00:39 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: Alexander Viro <viro@math.psu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [lkcd-devel] Re: What's left over.
References: <20021105221050.A10679@almesberger.net>
	<Pine.GSO.4.21.0211052017320.6521-100000@steklov.math.psu.edu>
	<20021105230505.D10679@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Nov 2002 23:04:48 -0700
In-Reply-To: <20021105230505.D10679@almesberger.net>
Message-ID: <m18z05ewzj.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> Alexander Viro wrote:
> > That's not obvious.  By the same logics, we would need syscalls for
> > turning off overcommit, etc., etc.
> 
> Okay okay, add file system specific ioctls and sysctl to my list
> of alternative mechanisms :-)
> 
> > FWIW, I suspect that
> > 	open("/proc/image", O_EXCL|O_WRONLY);
> > 	bunch of lseek()/write()
> > 	close()
> 
> Hmm, interesting. Yes, that should work. One would of course have
> to retain the current interface for in-kernel use (e.g. MCORE), but
> that's probably okay. Let's see what Eric thinks about it - it's
> his code after all.

For the record my opinion is there is extra code bloat but it is ok
if it is built as kexecfs.  Any other way of getting a magic file
to work with seems currently insane.

Eric
