Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292342AbSBULkl>; Thu, 21 Feb 2002 06:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292344AbSBULkb>; Thu, 21 Feb 2002 06:40:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15108 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292342AbSBULkT>;
	Thu, 21 Feb 2002 06:40:19 -0500
Message-ID: <3C74DCA1.B1DA0C30@mandrakesoft.com>
Date: Thu, 21 Feb 2002 06:40:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <Pine.LNX.4.21.0202210011080.32476-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> At http://www.xs4all.nl/~zippel/lkcc.tar.gz there is a small program which
> converts the config files into an alternative format. The tool expects a
[...]
> The current output looks like this:
> 
> config: ULTRIX_PARTITION
>   define_bool
>     default: y
>     dep: ((!PARTITION_ADVANCED?) && DECSTATION=y)
>   bool
>     prompt:   Ultrix partition table support
>     dep: PARTITION_ADVANCED?
>   help:
>   Say Y here if you would like to be able to read the hard disk
>   partition table format used by DEC (now Compaq) Ultrix machines.
>   Otherwise, say N.
[...]
> What am I missing now, that we can't convert the current configs into
> something like above and add new features later to it?

Interesting...

FWIW a much better transition path is very close to what your tool does,
and is a suggestion made by mec (kbuild maintainer) near the end of the
recent flamewar:  convert config.in files one at a time, like we did the
old makefiles.

That would imply a rewrite of make [old]config, and an updating of make
menu|xconfig, to handle the new format...

As it happened with the conversion to new-style Makefiles, Linus may say
"bah" when the conversion 80% there, and remove support for the old
config format completely.  :)

	Jeff




-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
