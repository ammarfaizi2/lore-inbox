Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264967AbSJ3UQt>; Wed, 30 Oct 2002 15:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264968AbSJ3UQt>; Wed, 30 Oct 2002 15:16:49 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:17064 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S264967AbSJ3UQs>; Wed, 30 Oct 2002 15:16:48 -0500
Date: Wed, 30 Oct 2002 13:23:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: post-halloween 0.2
Message-ID: <20021030202306.GB27472@opus.bloom.county>
References: <20021030171149.GA15007@suse.de> <1036006381.5297.108.camel@irongate.swansea.linux.org.uk> <765420000.1036005439@flay> <20021030195034.GA27472@opus.bloom.county> <770420000.1036007878@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <770420000.1036007878@flay>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 11:57:58AM -0800, Martin J. Bligh wrote:
> >> > Can you also mention not using gcc 3.0.x (stack pointer handling bug)
> >> 
> >> Any chance of putting this sort of thing as #error detection
> >> in the compile so it auto-breaks? I seem to recall that's done
> >> for some versions of GCC already ...
> > 
> > And what arch is that for?  Adding a nice facility for per-arch (and
> > maybe global) compiler / binutils testing would be nice, if we're going
> > to go down that road..
> 
> Alan, would you consider something like (TOTALLY untested):
[snip]

So it's a global thing then?
 
> If you like it, I'll get it tested.
> 
> Probably some things are per-arch and some are global, at a guess.
> Currently we have:
[snip]

And then ppc32 does some binutils checks, not-in-C and before we let the
kernel get too far.  What I was proposing is we add something outside of
the direct kernel src (something in scripts?  Generic make magic?) to
verify that a compiler / binutils / whatever tool is a good version.
This is rather easy for binutils + obvious instruction problem (missing
/ incorrect operands), and for compiler versions, something to generate
a test-file and then see if it compiles.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
