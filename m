Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269312AbRHHLdr>; Wed, 8 Aug 2001 07:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270455AbRHHLdg>; Wed, 8 Aug 2001 07:33:36 -0400
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:32762
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S269312AbRHHLd2>; Wed, 8 Aug 2001 07:33:28 -0400
Message-ID: <3B712392.A7CFEEC9@math.ethz.ch>
Date: Wed, 08 Aug 2001 13:33:38 +0200
From: Giacomo Catenazzi <cate@math.ethz.ch>
Reply-To: cate@dplanet.ch
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Announce: Kernel Build for 2.5, Release 1 is 
 available.
In-Reply-To: <31408.997253881@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
>   Supports a common source and object directory.  The default mode is
>   the same as kbuild 2.4, to use the same tree for both source and
>   object.  Even in this mode, kbuild 2.5 treats almost all the source
>   files as read only, no more time stamp fiddling with .h files.  The
>   exceptions are files that are generated at run time and are
>   incorrectly being shipped as part of the kernel tar ball.  I will be
>   sending patches to remove these files from the 2.4 tar ball.
>   Obviously you can only compile one kernel at a time in this mode.
 
Warning:
If generating some support files requires some non common tools,
it is the right thing to ship the two files (source and generated).
(also GNU std requires it (IIRC compiling a package
should not require m4, autoconfig, automake, and some tex preprocessing
for info files).

I agree with GNU, thus compiling kernel should not require
some non-common tools (python, gawk are 'common' tools for me).

BTW we cannot ship the generated file without the source files,
because of GPL.

	giacomo
