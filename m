Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbTBQDXr>; Sun, 16 Feb 2003 22:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbTBQDXr>; Sun, 16 Feb 2003 22:23:47 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:51148 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S266453AbTBQDXp>;
	Sun, 16 Feb 2003 22:23:45 -0500
Date: Mon, 17 Feb 2003 09:03:30 +0530 (IST)
From: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
In-Reply-To: <20030216182512.GB4861@nevyn.them.org>
Message-ID: <Pine.SOL.3.96.1030217085753.27558A-100000@osiris.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The command ./gcc -v -iwithprefix include -E - < /dev/null
from the directory containing the actual gcc file.

Reading specs from ./../lib/gcc-lib/i686-pc-linux-gnu/3.2/specs
Configured with: ../gcc-3.2/configure --prefix=/usr/local/gcc-3.2
Thread model: posix
gcc version 3.2
 ./../lib/gcc-lib/i686-pc-linux-gnu/3.2/cpp0 -lang-c -v -iprefix
./../lib/gcc-lib/i686-pc-linux-gnu/3.2/ -D__GNUC__=3 -D__GNUC_MINOR__=2
-D__GNUC_PATCHLEVEL__=0
 -D__GXX_ABI_VERSION=102 -D__ELF__ -Dunix -D__gnu_linux__ -Dlinux
-D__ELF__ -D__
unix__ -D__gnu_linux__ -D__linux__ -D__unix -D__linux -Asystem=posix
-D__NO_INLI
NE__ -D__STDC_HOSTED__=1 -Acpu=i386 -Amachine=i386 -Di386 -D__i386
-D__i386__ -D
__tune_i686__ -D__tune_pentiumpro__ -iwithprefix include -
GNU CPP version 3.2 (cpplib) (i386 Linux/ELF)
ignoring nonexistent directory "../i686-pc-linux-gnu/include"
ignoring nonexistent directory
"/usr/local/gcc-3.2/i686-pc-linux-gnu/include"
ignoring duplicate directory
"../lib/gcc-lib/i686-pc-linux-gnu/3.2/include"
ignoring duplicate directory
"/usr/local/gcc-3.2/lib/gcc-lib/i686-pc-linux-gnu/3
.2/include"
#include "..." search starts here:
#include <...> search starts here:
 ../lib/gcc-lib/i686-pc-linux-gnu/3.2/include
 /usr/local/include
 /usr/local/gcc-3.2/include
 /usr/include
End of search list.
# 1 "<stdin>"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "<stdin>"

Please CC to rahulv@csa.iisc.ernet.in
--
Rahul Vaidya
Hostel Room G46,
Ph.3942451

"Life can only be understood going backwards, 
	            but it must be lived going forwards"
						-Kierkegaard

On Sun, 16 Feb 2003, Daniel Jacobowitz wrote:

> On Sun, Feb 16, 2003 at 05:44:11PM +0000, Russell King wrote:
> > Please copy replies back to lkml.
> > 
> > On Sun, Feb 16, 2003 at 10:43:01PM +0530, Rahul Vaidya wrote:
> > > the command is giving me the following:
> > > 
> > > Reading specs from
> > > /usr/local/gcc-3.2/lib/gcc-lib/i686-pc-linux-gnu/3.2/specs
> > > Configured with: ../gcc-3.2/configure --prefix=/usr/local/gcc-3.2
> > > Thread model: posix
> > > gcc version 3.2
> > >  /usr/local/gcc-3.2/lib/gcc-lib/i686-pc-linux-gnu/3.2/cpp0 -lang-c -v
> > > -iprefix /usr/local/bin/../lib/gcc-lib/i686-pc-linux-gnu/3.2/
> >                       ^^^^^^^^^^
> > 
> > It looks like gcc 3.2 thinks its compiler prefix is in a place where it
> > is not.  I'd suggest you report this to the gcc people; at a guess, it
> > may be due to gcc getting confused during its configuration:
> > 
> > 	../gcc-3.2/configure --prefix=/usr/local/gcc-3.2
> >         ^^^
> 
> No, that doesn't affect the search path.  It's detecting a GCC in
> /usr/local and assuming the installation was moved.  Rahul, what does
> it say when you run it from its real location?
> 
> -- 
> Daniel Jacobowitz
> MontaVista Software                         Debian GNU/Linux Developer
> 

