Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129419AbRBVEEI>; Wed, 21 Feb 2001 23:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129283AbRBVEDu>; Wed, 21 Feb 2001 23:03:50 -0500
Received: from SMTP1.ANDREW.CMU.EDU ([128.2.10.81]:53951 "EHLO
	smtp1.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S129419AbRBVEDc>; Wed, 21 Feb 2001 23:03:32 -0500
Date: Wed, 21 Feb 2001 23:03:13 -0500
From: "Eloy A. Paris" <eparis@andrew.cmu.edu>
To: Billy.Harvey@thrillseeker.net, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.2
Message-ID: <20010221230313.A750@antenas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Billy Harvey wrote:

> I get the following error in a make bzImage:
>
> nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw]\)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
> make[1]: Entering directory `/usr/src/linux/arch/i386/boot'
> ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
> ld: cannot open binary: No such file or directory
> make[1]: *** [bbootsect] Error 1
> make[1]: Leaving directory `/usr/src/linux/arch/i386/boot'
> make: *** [bzImage] Error 2

Are you running Debian and follow unstable? I think ldso got updated
today or yesterday and probably the problems started after that.

I solved the problem by changing all calls to ld in
/usr/src/linux/arch/i386/boot/Makefile from "ld ... -oformat ..." to
"ld ... --oformat ..."

Cheers,

Eloy.-
