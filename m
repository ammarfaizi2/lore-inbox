Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292251AbSBBIBt>; Sat, 2 Feb 2002 03:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292252AbSBBIBk>; Sat, 2 Feb 2002 03:01:40 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:61105 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S292251AbSBBIBb>;
	Sat, 2 Feb 2002 03:01:31 -0500
Date: Sat, 2 Feb 2002 03:01:29 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
Message-ID: <20020202030129.B20865@havoc.gtf.org>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <20020201124300.G763@lynx.adilger.int> <3C5AF6B5.5080105@zytor.com> <20020201152829.A2497@havoc.gtf.org> <a3ffls$tsv$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a3ffls$tsv$1@abraham.cs.berkeley.edu>; from daw@mozart.cs.berkeley.edu on Sat, Feb 02, 2002 at 01:33:48AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 01:33:48AM +0000, David Wagner wrote:
> Hmm.  I don't quite follow your reasoning.  Does the kernel already
> perform fitness tests on random data from other drivers?  I don't
> think so.
> 
> The i810 rng seems much less prone to entropy failure than the data
> currently collected from I/O events.  Why are fitness tests for it more
> important than for the existing entropy sources that are currently in
> the kernel?
> 
> What am I missing?

The "random" data from the RNG might suddenly become non-random.  If you
are telling the system you are trusting this source, you better make
sure it truly is random.

RNGs are different than other entropy sources in the kernel because it's
a black box.

	Jeff



