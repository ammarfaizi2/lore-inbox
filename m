Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTJNQ1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 12:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTJNQ1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 12:27:22 -0400
Received: from gaia.cela.pl ([213.134.162.11]:54544 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262529AbTJNQ1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 12:27:20 -0400
Date: Tue, 14 Oct 2003 18:27:05 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: jlnance@unity.ncsu.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
In-Reply-To: <20031014143047.GA6332@ncsu.edu>
Message-ID: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me concur with the sentiments on this thread.
> 
> When I started using Linux, it was on a 40 MHz 386 with 8Megs of ram and
> a 200 Meg HD.  This was a reasonably typical machine for the time (1993).
> I ran X on this machine, and it was fine running several Xterms and you
> could play the X version of Tetris or gnuchess.  I used this machine to
> write the program I was working on for my Masters degree.
> 
> Today, a machine with specs like I quoted above seems hopelessly slow.
> However, I was able to do useful work on it in 1993, and the same sort
> of work would still be useful today.  You of course are not going to be
> able to run mozilla and KDE on it, but lynx, slrn, mutt, and fvwm will
> work fine.  There are many people who will never be able to afford
> to buy a computer but could find someone to give them one of these
> "hopelessy outdated" machines for nothing.  If we can ensure that
> Linux keeps working on these machines, it will be a good thing.

On one hand I agree with you - OTOH: why not run an older version of the
kernel? Are kernel versions 2.2 or even 2.0 really not sufficient for such
a situation?  It should be noted that newer kernels are adding a whole lot
of drivers which aren't much use with old hardware anyway and only a
little actual non-driver related stuff (sure it's an oversimplification,
but...).  Just like you don't expect to run the latest
games/X/mozilla/kde/gnome on old hardware perhaps you shouldn't run the
latest kernel... perhaps you should...

Sure I would really like to be able to compile a 2.6 for my 
firewall (486DX33+40MB-2MB badram) - but is this the way to go?

As for making the kernel smaller - perhaps a solution would be to code all 
strings as error codes and return ERROR#42345 or something instead of the 
full messages - there seem to be quite a lot of them.  I don't mean to 
suggest this solution for all compilations but perhaps a switch to remove 
strings and replace them with ints and then a seperately generated file of 
errnum->string. I'd expect that between 10-15% of the uncompressed kernel 
is currently pure text.

Perhaps int->string conversion could be done by a loadable module or a 
userspace program?

Just my 3c and some ideas.

Of course part of the problem is that by designing the kernel for high mem 
situations we're using more memory hogging algorithms.  It's a simple 
matter of features vs mem footprint.

I'm not convinced either way - and I'm just posting this 
as a voice in this discussion...

Cheers,
MaZe.

