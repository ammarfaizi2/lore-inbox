Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbSASMaA>; Sat, 19 Jan 2002 07:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287200AbSASM3u>; Sat, 19 Jan 2002 07:29:50 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:11448 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274862AbSASM3e>;
	Sat, 19 Jan 2002 07:29:34 -0500
Date: Sat, 19 Jan 2002 07:29:33 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Matthias Schniedermeyer <ms@citd.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rm-ing files with open file descriptors
In-Reply-To: <1011442962.25240.3.camel@bip>
Message-ID: <Pine.GSO.4.21.0201190728120.3523-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 19 Jan 2002, Xavier Bestel wrote:

> On Sat, 2002-01-19 at 13:16, Matthias Schniedermeyer wrote:
> > > > Well no. new_fd will refer to a completely new, empty file
> > > > which has no relation to the old file at all.
> > > > 
> > > > There is no way to recreate a file with a nlink count of 0,
> > > > well that is until someone adds flink(fd, newpath) to the kernel.
> > > > 
> > > 
> > > This *might* work:
> > > 
> > > link("/proc/self/fd/40", newpath);
> > 
> > cat /proc/<id>/fd/<nr> > whatever
> > actually works.
> 
> Once it's unliked ? I doubt it.

Egads...  It certainly works, unlinked or not.  Please learn the basics of
Unix filesystem semantics.

