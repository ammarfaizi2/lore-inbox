Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315233AbSEBSdk>; Thu, 2 May 2002 14:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315256AbSEBSdj>; Thu, 2 May 2002 14:33:39 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:28064 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315233AbSEBSdi>;
	Thu, 2 May 2002 14:33:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: discontiguous memory platforms
Date: Thu, 2 May 2002 20:32:07 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, Ralf Baechle <ralf@uni-koblenz.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205021539460.23113-100000@serv> <E172yOR-00026G-00@starship> <3CD184BB.ED7F349F@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173LNK-00027F-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 20:26, Roman Zippel wrote:
> Hi,
> 
> Daniel Phillips wrote:
> 
> > > Most of the time there are only a few nodes, I just don't know where and
> > > how big they are, so I don't think a hash based approach will be a lot
> > > faster. When I'm going to change this, I'd rather try the dynamic table
> > > approach.
> > 
> > Which dynamic table approach is that?
> 
> I mean calculating the lookup table and patching the kernel at startup.

Patching the kernel how, and where?

Calculating the lookup table automatically at startup is definitely planned,
and yes, essential to avoid an unmanageble proliferation of configuration
files.  It's also possible to pass the configuration as a list of
mem=size@physaddr kernel command line entries, which is a pragmatic solution
for configurations with unusual memory mappings, but not too many of them.

> Anyway, I agree with Andrea, that another mapping isn't really needed.
> Clever use of the mmu should give you almost the same result.

We *are* making clever use of the mmu in config_nonlinear, it is doing the
nonlinear kernel virtual mapping for us.  Did you have something more clever
in mind?

-- 
Daniel
