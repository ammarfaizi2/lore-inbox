Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbSIWSsj>; Mon, 23 Sep 2002 14:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbSIWSsG>; Mon, 23 Sep 2002 14:48:06 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261413AbSIWSmi>;
	Mon, 23 Sep 2002 14:42:38 -0400
Date: Mon, 23 Sep 2002 07:55:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Remco Post <r.post@sara.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38 on ppc/prep
Message-ID: <20020923145519.GP726@opus.bloom.county>
References: <20020923142951.GO726@opus.bloom.county> <4FDC416F-CF02-11D6-A08A-000393911DE2@sara.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FDC416F-CF02-11D6-A08A-000393911DE2@sara.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 04:39:49PM +0200, Remco Post wrote:
> 
> On maandag, september 23, 2002, at 04:29 , Tom Rini wrote:
> 
> >On Mon, Sep 23, 2002 at 02:03:02PM +0200, Remco Post wrote:
> >
> >>after some tiny fixes to reiserfs and the makefile for prep bootfile
> >>(using ../lib/lib.a vs. ../lib/libz.a) I managed to succesfully compile
> >>a kernel. It even boots to the point where it frees unused kernel 
> >>memory
> >>and then stops... this includes succesfully mounting the root
> >>filesystem...
> >
> >What typo exactly?  The only 'lib' in the Makefile
> >(arch/ppc/boot/prep/Makefile) is:
> >LIBS = ../lib/zlib.a
> 
> That one exactly... I don't recall calling it a typo, though ;-) I guess 
> that is more a relic from when the only lib routines were libz ones and 
> we called the lib to be linked libz.a....

It's not a relic, it's design.  We don't want the kernel's zlib routines
right now, we want our own.  Did it not link the way it was?  It's been
a few releases since I last compiled for my PReP box, but it was well
after the zlib changes had gone in.

> There is a simular entry in arch/ppc/boot/openfirmware/Makefile... 
> removing the z helped over there as well (don't recall exactly, I'm at 
> work now... ) (not that I dare booting Linus's 2.5 tree on my build 
> machine, it's falling apart even with stable software....  ;-(

Again, we don't want the 'normal' zlib there either.  Was it not
linking?  If so, what was the error?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
