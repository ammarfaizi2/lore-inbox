Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287388AbRL3MGN>; Sun, 30 Dec 2001 07:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287387AbRL3MGD>; Sun, 30 Dec 2001 07:06:03 -0500
Received: from ns.caldera.de ([212.34.180.1]:43705 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S287386AbRL3MFw>;
	Sun, 30 Dec 2001 07:05:52 -0500
Date: Sun, 30 Dec 2001 13:05:29 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20011230130529.A27210@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0112281416290.23445-100000@penguin.transmeta.com> <Pine.LNX.4.33.0112290005110.2889-100000@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112290005110.2889-100000@vaio>; from kai@tp1.ruhr-uni-bochum.de on Sat, Dec 29, 2001 at 12:44:06AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 12:44:06AM +0100, Kai Germaschewski wrote:
> But yes, it seems possible to replace the -MD dependency file, which
> depends on a specific config, with a generic dependency file, which knows
> about our #ifdef CONFIG_XXX and translates them to the corresponding
> ifeq(CONFIG_,) Makefile syntax. It'd make an interesting project, but it
> effectively means re-implementing a C preprocessor.

Michael already wrote such a program.  It's part of the dancing
makefiles patch, which btw is a kernel build system that is not only
correct but also faster than the old one..

It's scripts/mk/fix_dep.c in a kernel tree with the following patch
applied:

	ftp://ftp.kernel.org/pub/linux/kernel/projects/kbuild/dancing-makefiles-2.4.0-test10.bz2

