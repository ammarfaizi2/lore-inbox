Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136338AbRDWCZw>; Sun, 22 Apr 2001 22:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136339AbRDWCZn>; Sun, 22 Apr 2001 22:25:43 -0400
Received: from leng.mclure.org ([64.81.48.142]:1288 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S136338AbRDWCZZ>; Sun, 22 Apr 2001 22:25:25 -0400
Date: Sun, 22 Apr 2001 19:25:20 -0700
From: Manuel McLure <manuel@mclure.org>
To: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
Message-ID: <20010422192520.A3618@ulthar.internal.mclure.org>
In-Reply-To: <20010422102234.A1093@ulthar.internal.mclure.org> <200104222138.XAA00666@kufel.dom>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200104222138.XAA00666@kufel.dom>; from kufel!ankry@green.mif.pg.gda.pl on Sun, Apr 22, 2001 at 14:38:55 -0700
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.04.22 14:38 Andrzej Krzysztofowicz wrote:
> > 
> > I'm having a problem with "su -" on ac11/ac12. ac5 doesn't show the
> > problem.
> > The problem is easy to reproduce - go to a console, log in as root, do
> an
> > "su -" (this will succeed) and then another "su -". The second "su -"
> > should hang - ps shows it started bash and that the bash process is
> > sleeping. You need to "kill -9" the bash to get your prompt back.
> 
> No problem here.
> 
> P233MMX
> 
> # uname -a
> Linux kufel 2.4.3-ac12 #2 nie kwi 22 15:32:51 CEST 2001 i586 unknown
> 
> # ls -l /lib/libc-*
> -rwxr-xr-x   1 root     root      1060168 Nov 19 11:17 /lib/libc-2.1.3.so
> 
> # gcc --version
> egcs-2.91.66
> (kernel with the fix by Niels Kristian Bech Jensen <nkbj@image.dk>)
> 
> # su --version
> su (GNU sh-utils) 2.0
> 
> Maybe it is RH7 specyfic ? Or you have some compiler / hardware problem ?
> 
> Andrzej

Did you try nesting more than one "su -"? The first one after a boot works
for me - every other one fails.
I'm on RH71 - this may be specific to this release. It's also
kernel-dependent, I can reboot with ac5 and the problem does not happen.
The kernel is compiled with the same compiler as yours.

My libc is 2.2.2 while yours is 2.1.3 - this may be the difference.

-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft

