Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbTBQRwu>; Mon, 17 Feb 2003 12:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbTBQRwu>; Mon, 17 Feb 2003 12:52:50 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:4111 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267209AbTBQRwt>;
	Mon, 17 Feb 2003 12:52:49 -0500
Date: Mon, 17 Feb 2003 19:02:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] klibc for 2.5.59 bk
Message-ID: <20030217180246.GA26112@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <20030209125759.GA14981@kroah.com> <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 09:06:09PM -0600, Kai Germaschewski wrote:

> I did some work on integrating klibc into kbuild now. I used your patch as 
> guide line, though I started from scratch with klibc-0.77. The build 
> should work fine (reminder: "make KBUILD_VERBOSE=0 ..." will give you much 
> more readable output), but I probably broke some non-x86 architectures 
> in the process.

Got this output when compiling user programs:
  USERCC  usr/lib/snprintf.o
cc1: warning: -malign-loops is obsolete, use -falign-loops
cc1: warning: -malign-jumps is obsolete, use -falign-jumps
cc1: warning: -malign-functions is obsolete, use -falign-functions

$gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --disable-checking --host=i386-redhat-linux --with-system-zlib --enable-__cxa_atexit
Thread model: posix
gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)

It mostly look OK. I assume the duplication used for host-progs is
momentary?

	Sam
