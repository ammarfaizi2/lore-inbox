Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTDDNTk (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 08:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbTDDNTj (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:19:39 -0500
Received: from imsp015.netvigator.com ([218.102.32.61]:35785 "EHLO
	imsp015.netvigator.com") by vger.kernel.org with ESMTP
	id S263527AbTDDNTR (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 08:19:17 -0500
From: Michael Frank <mflt1@micrologica.com.hk>
To: Robert Woerle Paceblade/Support <robert@paceblade.com>
Subject: Re: [Swsusp] internal compiler error
Date: Fri, 4 Apr 2003 21:29:05 +0800
User-Agent: KMail/1.5.1
References: <3E8D7C65.5050505@paceblade.com>
In-Reply-To: <3E8D7C65.5050505@paceblade.com>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
X-OS: GNU/Linux 2.4.21-pre5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304042129.05470.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 04 April 2003 20:36, Robert Woerle Paceblade/Support wrote:
> now i get this when i try to compile 2.4.20 with any swsusp patch !! (
> tried , beta19 and beta19-14 and beta19-16)
>
> the thing i changed is that i now use Suse 8.2 and before i had suse 8.1
> and everything was fine .
>
> i dont know if there is a gcc differenc between those 2 but it looks
> like !!
>
> Cheers Rob
>
>
>
> cc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
> -malign-functions=0 -malign-jumps=0 -malign-loops=0   -nostdinc
> -iwithprefix include -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c
> -o sched.o sched.c
> cc1: warning: -malign-loops is obsolete, use -falign-loops
> cc1: warning: -malign-jumps is obsolete, use -falign-jumps
> cc1: warning: -malign-functions is obsolete, use -falign-functions
> sched.c: In function `schedule':
> sched.c:611: warning: comparison between signed and unsigned
> sched.c:640: warning: comparison between signed and unsigned
> sched.c:709: internal compiler error: in merge_assigned_reloads, at
> reload1.c:6133
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.


The obsolete messages point to some gcc-3x. It is no good for kernel compiles because there are many complex tricks in the kernel.

You ought to use gcc2.95-3. You can look for gcc295 compat package and libs at suse site. 

Michael

P.S. Official compiler _is_ gcc2.95-3 also for 2.5 series. This is _not_ "obsolete" documentation. 

Could someone authoritative from kernel list please confirm that above still applies



