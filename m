Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264876AbSKEPzz>; Tue, 5 Nov 2002 10:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264881AbSKEPzz>; Tue, 5 Nov 2002 10:55:55 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:64136 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264876AbSKEPzy>; Tue, 5 Nov 2002 10:55:54 -0500
Date: Tue, 5 Nov 2002 10:02:26 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "David S. Miller" <davem@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.46
In-Reply-To: <1036477834.31982.0.camel@rth.ninka.net>
Message-ID: <Pine.LNX.4.44.0211050958470.20254-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Nov 2002, David S. Miller wrote:

> On Mon, 2002-11-04 at 18:37, Kai Germaschewski wrote:
> > On Mon, 4 Nov 2002, george anzinger wrote:
> > 
> > > I think we need a newer objcopy :(
> > 
> > Alternatively, use this patch. (It's not really needed to force people to 
> > upgrade binutils when ld can do the job, as it e.g. does in 
> > arch/i386/boot/compressed/Makefile already).
> 
> Does not work for me at all on sparc64, it complains that *.gz has an
> unknown file format.

I suppose that's because sparc64 doesn't properly define LDFLAGS_BLOB (nor 
did it define ARCHBLOBFLAGS, which is replaced by the former now). Look 
at arch/i386/Makefile::LDFLAGS_BLOB and adapt accordingly ;)

> Why not just hexdump the thing into an array of char foo.c file,
> then compile that.

Well, I wouldn't think there's any toolchain which doesn't support the 
current way when given the right flags, so that looks faster and cleaner 
to me.

--Kai


