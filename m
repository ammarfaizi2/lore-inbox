Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263181AbREWRfw>; Wed, 23 May 2001 13:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263179AbREWRfm>; Wed, 23 May 2001 13:35:42 -0400
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:64998
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S263178AbREWRf3>; Wed, 23 May 2001 13:35:29 -0400
Date: Wed, 23 May 2001 19:35:22 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@mimas.fachschaften.tu-muenchen.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: CML2 <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: What's up with GT96100 in the MIPS config file?
In-Reply-To: <20010523132346.A16993@thyrsus.com>
Message-ID: <Pine.NEB.4.33.0105231932420.986-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2001, Eric S. Raymond wrote:

> Near line 55 of drivers/net/Config.in there is code that reads like this:
>
>    if [ "$CONFIG_MIPS_GT96100" = "y" ]; then
>       bool '  MIPS GT96100 Ethernet support' CONFIG_MIPS_GT96100ETH
>    fi
>
> All very well except that CONFIG_MIPS_GT96100 is never set (or even
>...
> The simplest guess is that the guard part is just wrong.  Can anybody shed
> any light on this?


The problem seems to be that the MIPS kernel tree isn't fully merged into
the official kernel tree. In the MIPS kernel tree arch/mips/config.in
includes:


...
if [ "$CONFIG_MIPS_EV96100" = "y" ]; then
   define_bool CONFIG_PCI y
   define_bool CONFIG_MIPS_GT96100 y
   define_bool CONFIG_SWAP_IO_SPACE y
fi
...


cu
Adrian

-- 
A "No" uttered from deepest conviction is better and greater than a
"Yes" merely uttered to please, or what is worse, to avoid trouble.
                -- Mahatma Ghandi

