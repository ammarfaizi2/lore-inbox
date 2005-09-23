Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVIWDKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVIWDKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 23:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVIWDKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 23:10:08 -0400
Received: from web8401.mail.in.yahoo.com ([202.43.219.149]:46010 "HELO
	web8401.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1751071AbVIWDKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 23:10:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=02mEIxFGwKI/45UE9sZcQiN2Yvy3dixxh9LvevlpGIjG8ECJhIdkIL3CUahlZUfjIwf4tyYp92xBuCy/l43wlp2Ux3apoK3AEr0reiPwJLea4SpidK7K7Xu1ZcCY4t5GJPauIVL2hVsCV1bFBLKKlozjMKG5Dv8RYaHTjAelRGU=  ;
Message-ID: <20050923031003.32068.qmail@web8401.mail.in.yahoo.com>
Date: Fri, 23 Sep 2005 04:10:03 +0100 (BST)
From: vikas gupta <vikas_gupta51013@yahoo.co.in>
Subject: Re: AIO Support and related package information??
To: =?iso-8859-1?q?S=E9bastien=20Dugu=E9?= <sebastien.dugue@bull.net>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <1127375190.2051.53.camel@frecb000686>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Sebastein,
Well Thanks For your Reply...
I will Try to Provide support on Arm Platform ...
but while cross building in configure script only i am
getting error i had given follwing option with
configure script
CC=<pathto cross compiler> ./configure --host=<arm
host> --prefix=<build library> 

But i am getting errors ...
Can you please look into the matter 

Thanks in advance 

 

--- Sébastien Dugué <sebastien.dugue@bull.net> wrote:

>   Hi Vikas,
> 
> 
> On Thu, 2005-09-22 at 04:08 +0100, vikas gupta
> wrote:
> > hello ALL ,
> > 
> > I am very curious about the AIO support in kernel.
> I
> > have downloaded the
> > recent kernel 2.6.13 and applied suparna's patches
> on
> > that but now i got stuck as
> > now there are two different packages are
> available.
> 
>   You should try Ben LaHaise's patchset which
> includes
> Suparna's patches. It's available as a single patch
> at:
> 
>
http://www.kvack.org/~bcrl/patches/aio-2.6.13-rc6-B1-all.diff
> 
> 
> and broken down at:
>
http://www.kvack.org/~bcrl/patches/aio-2.6.13-rc6-B1/
> 
> > 
> > 1) libaio rpm
> > 
> 
>   libaio is meant as a way for using the kernel AIO
> support but 
> does not provide a POSIX compliant interface.
> 
> > There are many rpm available such as
> > libaio-0.3.xxx-02.src rpm and many
> > more but at http://lse.sourceforge.net/io/aio.html
> > ,Somebody has said to use
> > libaio-0.3.99 package ..
> 
>   I've been using libaio-0.3.92 with success.
> 
> > 
> > So can you please give me some guidelines on after
> > applying the patch how
> > to proceed further???
> > 
> > Is these packages are part of linux kernel
> > installation ????
> > 
> > Is this package implementation is really necessary
> and
> > if yes then what
> > are the packages we need to install.
> > 
> > And if any other resource is required then from
> where
> > i can get that
> > resource.
> > 
> > 2) libposix API library of 
> > http://www.bullopensource.org/posix.
> > 
> >         How to use it???
> >         Is it any other way of implementing the
> AIO
> > Support or it is to
> > provide posix conformance to the kernel.
> 
> 
>   Just like libaio, libposix-aio uses the kernel AIO
> support but 
> provides a POSIX compliant interface.
> 
>   There are no man pages yet, but you can look a the
> SuSV3 
> specification (links are on
> http://www.bullopensource.org/posix/).
> 
>   For completeness, I should add that there is a
> POSIX AIO
> implementation in glibc librt but it uses helper
> threads to achieve
> asynchrony and does not use kernel support.
> 
> > 
> > 3) What is the relation between libposixaio
> pacakage
> > supported by bullsource.net and libaio pacakage
> > supported by redhat ....
> 
>   None, libposix-aio used to rely on libaio for the
> syscalls but that's
> no longer the case.
> 
> > 
> > 4) I am able to built that libposix package
> without
> > libaio ??????
> 
>   Normal.
> 
> > 
> > 5) are these pacakages are supported for othewr
> > platforms such as arm and ppc ,I am not able to
> build
> > libposix for arm platform.Do Cross compiling is
> > supported ???
> > 
> 
>   Right now support is provided for:
> 
> 	i386	- tested
> 	ia64	- not tested
> 	x86_64	- not tested
> 
>   If you're willing to add support for other
> platforms there is
> only one file to add for implementing the
> architecture dependant
> syscalls, such as syscall_arm.h or syscall_ppc.h.
> Look at the sources.
> 
> > 
> > 
> > 6) How to use these api in test program
> > 
> >   Can i use it as mentioned below ????
> > 
> >   Test1.c
> > 
> >   #include <aio.h>
> >   #include <errno.h>
> >   #include <stdio.h>
> >   #include <string.h>
> >   #include <unistd.h>
> > 
> >   #define BYTES 8
> > 
> >   int main( int argc, char *argv[] )
> >   {
> >       int i, r;
> >       int fildes;
> >       struct aiocb cb;
> >       char buff[BYTES];
> > 
> >       if ((fildes = open( "/etc/resolv.conf",
> O_RDONLY
> > )) < 0) {
> >           perror( "opening file" ); return 1;
> >       }
> > 
> >       cb.aio_fildes = fildes;
> >       cb.aio_offset = 0;
> >       cb.aio_buf = buff;
> >       cb.aio_nbytes = BYTES;
> >       cb.aio_reqprio = 0;
> >       cb.aio_sigevent.sigev_notify = SIGEV_NONE;
> > 
> >       errno = 0;
> >       r = aio_read( &cb );
> >       printf( "aio_read() ret: %i\terrno: %i\n",
> r,
> > errno );
> > 
> >       while (aio_error( &cb ) == EINPROGRESS) {
> > usleep( 10 ); }
> > 
> >       for (i = 0; i < BYTES; i++) { printf( "%c ",
> > buff[i] ); } printf(
> > "\n" );
> > 
> >       errno = 0;
> >       r = aio_return( &cb );
> >       printf( "aio_return() ret: %i\tBYTES:
> %i\terrno:
> > %i\n", r, BYTES,
> > errno );
> > 
> >       return 0;
> > }
> 
>   That should be OK. Look at the examples in
> libposix-aio, in
> the check and testbed subdirectories.
> 
> 
> > 
> > 
> > 
> > Any other information, if u can provide then it
> will
> > be of great use ...
> > 
> > 
> > Thanks in advance ...
> > 
> > Vikas
> 
>   Hope this helps,
> 
=== message truncated ===



		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
