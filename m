Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314019AbSDKKmW>; Thu, 11 Apr 2002 06:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314020AbSDKKmV>; Thu, 11 Apr 2002 06:42:21 -0400
Received: from sebula.traumatized.org ([193.121.72.130]:28549 "EHLO
	sparkie.is.traumatized.org") by vger.kernel.org with ESMTP
	id <S314019AbSDKKmV>; Thu, 11 Apr 2002 06:42:21 -0400
Date: Thu, 11 Apr 2002 12:34:44 +0200
From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
To: linux-kernel@vger.kernel.org
Subject: Re: arch/sparc64/kernel/traps.c
Message-ID: <20020411103444.GA7280@sparkie.is.traumatized.org>
In-Reply-To: <20020409212000.GK9996@sparkie.is.traumatized.org> <20020409.155757.34666328.davem@redhat.com> <20020410133908.GJ11858@sparkie.is.traumatized.org> <200204110547.g3B5l3X08802@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i (Linux 2.4.19-pre5 sparc64)
X-Files: the truth is out there
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 08:00:08AM +0200, Denis Vlasenko wrote:

> > > ksymoops should be already installed on your system
> > > at /usr/bin/ksymoops, if it isn't find the package
> > > to install or complain to your distribution maintainer :-)
> > >
> > > If you still want to compile ksymoops from source you need to update
> > > and install a new binutils to get the latest BFD library.
> >
> > allright, ksymoops doesn't come with my distribution (Splack)
> > so i got the source, and went from there.
> >
> > now it compiled nicely.
> >
> > here's the output that i get (i'm not quite sure what to expect, so i
> > hope this is what you need:)
> 
> [snip]
> 
> > Error (Oops_bfd_perror): set_section_contents Bad value
> 
> [snip]
> 
> I've seen the same when ksymoops was linked against old libbfd.
> It builds without errors but could not disassemble oopsed code.
> Check for old libbfd lying around.

sorry for the long lines, but it would't be very readable otherwise
:)

$ locate libbfd | xargs ls -ld
-rwxr-xr-x    1 root     root       632951 Apr 10 15:18 /usr/lib/libbfd-2.12.so
-rw-r--r--    1 root     root       737648 Apr 10 15:18 /usr/lib/libbfd.a
-rwxr-xr-x    1 root     root          771 Apr 10 15:18 /usr/lib/libbfd.la
lrwxrwxrwx    1 root     root           14 Apr 10 15:24 /usr/lib/libbfd.so -> libbfd-2.12.so

$ locate bfd.h | xargs ls -ld
-rw-r--r--    1 root     root       134077 Apr 10 15:18 /usr/include/bfd.h

it all looks like the new version to me


ps: it's the first time i actually use ksymoops, so excuse my
newbie-like behaviour :)

Jurgen.
