Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132895AbRDYWmw>; Wed, 25 Apr 2001 18:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132991AbRDYWmm>; Wed, 25 Apr 2001 18:42:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17084 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132895AbRDYWmg>;
	Wed, 25 Apr 2001 18:42:36 -0400
Date: Wed, 25 Apr 2001 18:42:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Doug McNaught <doug@wireboard.com>,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, tim@tjansen.de,
        linux-kernel@vger.kernel.org
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
In-Reply-To: <20010426000325.A6621@werewolf.able.es>
Message-ID: <Pine.GSO.4.21.0104251838440.13090-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, J . A . Magallon wrote:

> 
> On 04.25 Doug McNaught wrote:
> > "J . A . Magallon" <jamagallon@able.es> writes:
> > 
> > > Question: it is possible to redirect the same fs call (say read) to
> > different
> > > implementations, based on the open mode of the file descriptor ? So, if
> > > you open the entry in binary, you just get the number chunk, if you open
> > > it in ascii you get a pretty printed version, or a format description like
> > 
> > There is no distinction between "text" and "binary" modes on a file
> > descriptor.  The distinction exists in the C stdio layer, but is a
> > no-op on Unix systems.
> > 
> 
> Yep, realized after the post, fopen() is a wrapper for open(). The idea
> is to (someway) set the proc entry in verbose vs fast-binary mode for
> reads. Perhaps an ioctl() or an fcntl() or something similar.
> So the verbose mode gives the field names, and the binary mode just
> gives the numbers. Applications that know what are reading can just
> read binary data, and fast.

OK, _what_ applications spend a considerable time (and considerable
percentage of the total execution time) parsing stuff in /proc?
ps(1)? top(1)? Fine. They touch how many files outside of /proc/<pid>/* ?
Exactly.

_Please_, drop this idiotic "parsing ASCII is slow" strawman. Or show some
valid examples.

