Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313854AbSDFCD7>; Fri, 5 Apr 2002 21:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313888AbSDFCDt>; Fri, 5 Apr 2002 21:03:49 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:51973 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313854AbSDFCDa>;
	Fri, 5 Apr 2002 21:03:30 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available 
In-Reply-To: Your message of "Fri, 05 Apr 2002 21:26:08 +1000."
             <7022.1018005968@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Apr 2002 12:03:15 +1000
Message-ID: <12641.1018058595@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Apr 2002 21:26:08 +1000, 
Keith Owens <kaos@ocs3.intra.ocs.com.au> wrote:
>kbuild 2.4:
>  make oldconfig		 0:07
>  make dep			 0:37 (make -j dep is unsafe on some architectures)
>  make -j8 bzImage modules	14:16
>  Total			        15:00
>  make -j8 bzImage modules	 2:10 (second run, no changes, spurious rebuilds)
>
>kbuild 2.5:
>  make -j8 oldconfig installable 8:51 (no make dep needed :)
>  make -j8 oldconfig installable  :14 (second run, no changes)

Just to avoid any confusion.  kbuild 2.4 is the existing kernel build
system, as used in Marcelo's and Linus's kernels.  kbuild 2.5 is the
complete rewrite of the kernel build system.  Although it says 2.5,
kbuild 2.5 will run on 2.4 kernels, it was developed on 2.4.

The timings above were for exactly the same .config on the same build
machine, building a 2.4.16 kernel, using the existing and new kernel
build system.  Compared to the existing build system, kbuild 2.5 is
much more robust (I found several bugs in the 2.4 rules while
developing kbuild 2.5), provides more facilities, has debugging
information, is more accurate (2.5 tracks everything, 2.4 only managed
about 80% tracking accuracy) and still manages to run 30% faster than
the existing build system.

Although kbuild 2.5 will run on 2.4 kernels, I have no plans to send
all of kbuild 2.5 to Marcelo.  Changing the kernel build on a stable
kernel is a bad idea.  I will be sending some kbuild 2.4 bug fixes to
Marcelo but not the rest of kbuild 2.5.  I am now working on kbuild 2.5
patches for 2.4.18, 2.4.19-pre6, 2.5.7 and 2.5.8-pre1 as well as for
other architectures, see http://sourceforge.net/projects/kbuild for
updates.

