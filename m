Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTJNRfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 13:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTJNRfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 13:35:47 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:35714 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262674AbTJNRfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 13:35:45 -0400
Date: Tue, 14 Oct 2003 18:33:49 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk>
To: Maciej Zenczykowski <maze@cela.pl>, jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>
References: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On one hand I agree with you - OTOH: why not run an older version of the
> kernel?

Security issues.  That applies for userspace as well.  Not upgrading,
or at least disabling the functionality with the security issue is
irresponsible.

Actually, this is one thing we could do to make Linux systems more
usable on low spec hardware - fix all the security issues in ancient
versions of the kernel and popular userspace applications.

> Are kernel versions 2.2 or even 2.0 really not sufficient for such
> a situation?  It should be noted that newer kernels are adding a whole lot
> of drivers which aren't much use with old hardware anyway and only a
> little actual non-driver related stuff (sure it's an oversimplification,
> but...).  Just like you don't expect to run the latest
> games/X/mozilla/kde/gnome on old hardware perhaps you shouldn't run the
> latest kernel... perhaps you should...

No, 2.6 should run on a 4MB 386 with no significant performance
penalty against 2.0, in my opinion.

> Sure I would really like to be able to compile a 2.6 for my 
> firewall (486DX33+40MB-2MB badram) - but is this the way to go?

Why not?

> As for making the kernel smaller - perhaps a solution would be to code all 
> strings as error codes and return ERROR#42345 or something instead of the 
> full messages - there seem to be quite a lot of them.  I don't mean to 
> suggest this solution for all compilations but perhaps a switch to remove 
> strings and replace them with ints and then a seperately generated file of 
> errnum->string. I'd expect that between 10-15% of the uncompressed kernel 
> is currently pure text.

I agree, error codes would be nice, but this discussion has come up
before and I doubt they will ever get in to mainline.

> Perhaps int->string conversion could be done by a loadable module or a 
> userspace program?

Not really going to help much, in my opinion, it'll just add overhead.

John.
