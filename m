Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288173AbSACDtl>; Wed, 2 Jan 2002 22:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288176AbSACDtb>; Wed, 2 Jan 2002 22:49:31 -0500
Received: from bexfield.research.canon.com.au ([203.12.172.125]:58985 "HELO
	b.mx.canon.com.au") by vger.kernel.org with SMTP id <S288173AbSACDtP>;
	Wed, 2 Jan 2002 22:49:15 -0500
Date: Thu, 3 Jan 2002 14:49:04 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Lionel Bouton <Lionel.Bouton@free.fr>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020103144904.A644@zapff.research.canon.com.au>
Reply-To: cs@zip.com.au
In-Reply-To: <20020102170833.A17655@thyrsus.com> <E16Lu2i-0005nd-00@the-village.bc.nu> <20020102172448.A18153@thyrsus.com> <3C339219.4040808@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C339219.4040808@free.fr>; from Lionel.Bouton@free.fr on Thu, Jan 03, 2002 at 12:04:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 12:04:57AM +0100, Lionel Bouton <Lionel.Bouton@free.fr> wrote:
| Eric S. Raymond wrote:
|  > Alan Cox <alan@lxorguk.ukuu.org.uk>:
|  >>So you want the lowest possible priviledge level. Because if so thats
|  >>setuid app not kernel space. Arguing about the same code in either kernel
|  >>space verus setuid app space is garbage.
|  >>
|  > But you're thinking like a developer, not a user.  The right question
|  > is which approach requires the lowest level of *user* privilege to get
|  > the job done.  Comparing world-readable /proc files versus a setuid app,
|  > the answer is obvious.
| 
| Reading proc files requires running kernel space code, do we have kernel
| space code running with *user* priviledge now?

Oh please don't inject (more) noise into this1 Doing ANYTHING involves
running kerel space code somewhere. It is still possible to talk
meaningfully about:

	- opening a publicly readable file in /proc to get some info,
	  which will run some kernel code (which can presumably be trusted;
	  if you don't trust your kernel you have a serious problem)

    versus

	- running a setuid binary (however audited) to get the info; said
	  binary may have bugs, security holes, race conditions etc; it may be
	  hacked post boot (no so easy to do to the live kernel image), etc

Further, binaries which grovel in /dev/kmem tend to have to be kept in sync
with the kernel; in-kernel code is fundamentally in sync.
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

Although it does not mindfully keep guard, in the small mountain fields the
scarecrow does not stand in vain.	- trans. Bukkoku Kokushi
