Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269718AbRHCXxz>; Fri, 3 Aug 2001 19:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269719AbRHCXxp>; Fri, 3 Aug 2001 19:53:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51688 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269718AbRHCXxj>;
	Fri, 3 Aug 2001 19:53:39 -0400
Date: Fri, 3 Aug 2001 19:53:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic
 change patch)
In-Reply-To: <20010804114626.B18042@weta.f00f.org>
Message-ID: <Pine.GSO.4.21.0108031947080.5264-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Aug 2001, Chris Wedgwood wrote:

> On Fri, Aug 03, 2001 at 07:41:40PM -0400, Alexander Viro wrote:
> 
>     file->f_cred. Different people opening the same file can have
>     different credentials (e.g. credentials can be revoked)
> 
> Sure, but if I
> 
>         f = open("/home/viro/file", ... );
>         fsync(f);
> 
> I only have creds for 'file' --- I have no such thing for 'viro' or
> 'home', so I can't do anything sensible here.

Credentials are about "I'm foo", not "I'm allowed to do this with that".
Server decides what you can do.

