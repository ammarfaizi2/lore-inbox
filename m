Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280132AbRLWUzJ>; Sun, 23 Dec 2001 15:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280190AbRLWUzA>; Sun, 23 Dec 2001 15:55:00 -0500
Received: from boden.synopsys.com ([204.176.20.19]:55003 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S280132AbRLWUyv>; Sun, 23 Dec 2001 15:54:51 -0500
Message-ID: <3C26448D.A2F5DC1B@Synopsys.COM>
Date: Sun, 23 Dec 2001 21:54:37 +0100
From: Harald Dunkel <harri@synopsys.COM>
Reply-To: harri@synopsys.COM
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: Support for grub at installation time
In-Reply-To: <24997.1009119951@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sun, 23 Dec 2001 15:39:59 +0100,
> Harald Dunkel <harri@synopsys.COM> wrote:
> >Below you can find a tiny patch to add 2 new targets to the top level
> >Makefile: bzgrub and zgrub. This is a suggestion about how the Grub
> 
> I am removing all the special targets that have crept into kbuild,
> including zlilo, I do not want to add any new boot targets.  It is the
> job of the kernel makefiles to build the kernel, install the kernel and
> modules and that is all.  Anything after the kernel and modules have
> been installed is not the job of kbuild.  There is too much special
> case code in the kernel makefiles, some of which only works for a few
> users.
> 
> All is not lost, however.  kbuild 2.5 has a config option to run a
> post-install script.  You can specify any script that you want and that
> script is responsible for doing whatever you want after the kernel and
> modules install.  There is a sample in scripts/lilo_new_kernel:
> 

Currently there are just 2 ways to install the freshly build kernel
outside of the source tree: 'make bzlilo' and 'make install'. Both 
call lilo, if the executable can be found. Its good to hear that this
is going to be removed. 

My patch is not for kbuild 2.5, but for the current Makefiles in the
kernel sources. I am eager to check the new features you provide when
kbuild 2.5 or a newer version is included for one of the future kernels, 
but since then I would suggest to consider my patch.

If you have kbuild for 2.4.16 completed, please send me a note. I would
like to try it.


Regards

Harri
