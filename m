Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314088AbSDZR3j>; Fri, 26 Apr 2002 13:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314089AbSDZR3i>; Fri, 26 Apr 2002 13:29:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60638 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314088AbSDZR3h>;
	Fri, 26 Apr 2002 13:29:37 -0400
Date: Fri, 26 Apr 2002 13:29:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@ucw.cz>
cc: Michael Dreher <dreher@math.tu-freiberg.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre7: rootfs mounted twice
In-Reply-To: <20020426161540.GF3783@elf.ucw.cz>
Message-ID: <Pine.GSO.4.21.0204261326580.22065-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Apr 2002, Pavel Machek wrote:

> > does statfs("/", &buf); for both.  Surprise, surprise, results of
> > two calls of statf2(2) are identical - what with arguments being
> > the same both times - and refer to the filesystem where your "/"
> > lives.  I.e. to ext3.
> 
> df might be wrong, but lets say that this /proc/mounts become
> interesting. This could not have happened in the past. That means you

This _could_ happen in past - as the matter of fact, I can reproduce it
on any 2.4 kernel.  Mount something over the root of already mounted
filesystem and watch the show.

Now, we could disable showing rootfs in /proc/mounts and it might be a
good idea for 2.4,  I'm not all that sure that it's a right thing, though.

