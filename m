Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289463AbSAKWNQ>; Fri, 11 Jan 2002 17:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290137AbSAKWNG>; Fri, 11 Jan 2002 17:13:06 -0500
Received: from [208.29.163.248] ([208.29.163.248]:41683 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S289463AbSAKWM5>; Fri, 11 Jan 2002 17:12:57 -0500
Date: Fri, 11 Jan 2002 13:46:16 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, <felix-dietlibc@fefe.de>,
        <andersen@codepoet.org>
Subject: Re: [RFC] klibc requirements, round 2
In-Reply-To: <20020110231849.GA28945@kroah.com>
Message-ID: <Pine.LNX.4.40.0201111340080.15378-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would personally rather see dietlibc / uClibc get ported to the
remaining platforms and have them become fairly standard options for
staticly linking small programs rather then spend the effort to create a
klibc and then make it portable as well.

I would rather have the people looking at making a small, optimized libc
work on one codebase instead of scattering their efforts amoung several
:-)

while the dietlibc / uClibc may not be quite as small and optimized as a
klibc would be the fact that people are currently able to survive with
glibc indicates that the space issue probably isn't _that_ high a priority
(if klibc produces a 100K binary while dietlibc produces a 120K binary and
glibc produces a 2M binary the difference in space between klibc and
dietlibc really doesn't matter much :-)

David Lang



On Thu, 10 Jan 2002, Greg KH wrote:

> So, what's the available options to try to meet these requirements?
>
> Here's some proposed solutions:
>   - dietlibc / uClibc
>     Nice options.  Both of these libraries are already fairly complete.
>     One drawback is they are not portable to all platforms.  With some
>     work, this can probably be solved.
>
>   - klibc
>     Portability can be achieved through using the kernel unistd.h file
>     for the syscall logic, and having a very small _start function
>     written.  For an example of this kind of code, see the initramfs
>     patches from Al Viro on his ftp site:
> 	    ftp://ftp.math.psu.edu/pub/viro/
>     This would involve writing/porting a lot of the basic library
>     functions.  They could be copied from the existing libc
>     implementations, but this would be a separate project, requiring
>     maintenance over time, and people willing to do the work.
>
> Is this all a good summary?  Any other comments from people?
>
> How about responses from the dietlibc and uClibc people on the odds of
> them being able to port to the remaining platforms?
>
> In the meantime, I'll go off and play with klibc, and see if I can get
> some portability based off of Al's example code.  If anyone is
> interested, the code can be found at:
> 	http://linuxusb.bkbits.net:8088/klibc
>
