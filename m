Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277798AbRKXMZY>; Sat, 24 Nov 2001 07:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278078AbRKXMZP>; Sat, 24 Nov 2001 07:25:15 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:49284 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S277798AbRKXMY6>; Sat, 24 Nov 2001 07:24:58 -0500
Message-ID: <3BFF9199.C01CB9FD@randomlogic.com>
Date: Sat, 24 Nov 2001 04:24:57 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Which gcc version?
In-Reply-To: <Pine.SGI.4.31L.02.0111231532000.13038141-100000@irix2.gl.umbc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Jasen wrote:
> 
> On Fri, 23 Nov 2001, J Sloan wrote:
> 
> > This is all silly FUD - time for the pointer again -
> >
> > http://www.bero.org/gcc296.html
> 
> Redhat apologists are given the due they deserve.
> 
> Their first cut at a released 2.96 should never have made it out of the
> labs alive, and for that matter, neither should have 7.0.
> 
> That said, the versions in 7.1, and the patches available have done
> reasonably well for everything that I've tried to compile (kernels
> included).
> 
> What are they going to do about gcc 3.0.x? It'll be amusing to watch.
> 

I installed RH 7.0 when it was released and was sorely dissappointed.
The compiler never worked for anything I tried to compile (and seeing as
how programming was 50% of my job, THAT was a MAJOR issue). I quickly
went back to RH 6.2.

That said, I now run RH 7.1 and 7.2 (depending upon the box, this one
runs 7.1 w/kernel 2.4.14).

[root@keroon /root]# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)
[root@keroon /root]# 

Works just fine for everything. The problem with the RH 7.1 release is
with make, not gcc. make 3.79.x has bugs that cause, among other things,
internal assertion errors. Though it works fine for the kernel, it will
not work for many other programs (see disscussion groups, e.g. -
gnu.org, for more info). So I back-rev'd that to 3.78.1-4:

[root@keroon /root]# make -v
GNU Make version 3.78.1, by Richard Stallman and Roland McGrath.
Built for i386-redhat-linux-gnu
Copyright (C) 1988, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99
	Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

Report bugs to <bug-make@gnu.org>.

[root@keroon /root]# 


and everything works just peachy. I compile everything for Athlon, and
it still works fine.

PGA
-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
