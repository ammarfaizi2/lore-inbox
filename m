Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319190AbSHGSxg>; Wed, 7 Aug 2002 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319191AbSHGSxg>; Wed, 7 Aug 2002 14:53:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18695 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319190AbSHGSxf>; Wed, 7 Aug 2002 14:53:35 -0400
Date: Wed, 7 Aug 2002 11:57:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: mingo@elte.hu, <linux-kernel@vger.kernel.org>, <julliard@winehq.com>,
       <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.30-A1
In-Reply-To: <20020808044343.4e48268c.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0208071149030.5194-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Aug 2002, Stephen Rothwell wrote:

> On Wed, 7 Aug 2002 11:33:23 -0700 (PDT) Linus Torvalds <torvalds@transmeta.com> wrote:
> >
> >  - keep the TLS entries contiguous, and make sure that segment 0040 (ie
> >    GDT entry #8) is available to a TLS entry, since if I remember
> >    correctly, that one is also magical for old Windows binaries for all
> >    the wrong reasons (ie it was some system data area in DOS and in 
> >    Windows 3.1)
> 
> segment 0040 is used by the APM driver to work around bugs in some BIOS
> implementations where some (brain-dead) BIOS writer has assume that the
> BIOS data area is still available in protected mode ...

Ok, sounds like that one ends up having to be a fixed segment (I wonder if
Wine can take advantage of it? looks like it is hardcoded to base 0x400,
which is probably fine for Wine anyway - just map something at the right
address - but it looks CPL0 only? Might be ok to just make it available to
user space).

		Linus

