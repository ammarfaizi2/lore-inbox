Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUAYXP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbUAYXPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:15:55 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:65153 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S265339AbUAYXPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:15:41 -0500
From: Eric <eric@cisu.net>
To: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: 2.6.2-rc1-mm2 kernel oops
Date: Sun, 25 Jan 2004 17:14:57 -0600
User-Agent: KMail/1.5.94
References: <4013D0AA.8060906@blueyonder.co.uk> <16404.8968.349900.566999@gargle.gargle.HOWL> <4014283D.9040207@blueyonder.co.uk>
In-Reply-To: <4014283D.9040207@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@fs.tum.de>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401251714.57799.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 January 2004 14:34, Sid Boyce wrote:
> John Stoffel wrote:
> > Sid> Andrew Morton wrote:
> >
> > Sid> Sid Boyce <sboyce@xxxxxxxxxxxxxxxx> wrote:
> >>>>I get this on bootup, Athlon XP2200+
> >>>>=====================================
> >>>>Linux version 2.6.2-rc1-mm2 (root@barrabas) (gcc version 3.3.1 (SuSE
> >>>>...
> >>>>EIP is at test_wp_bit+0x36/0x90
> >>>
> >>>oh crap, why does this thing keep breaking? Please send your .config
> >>>over,
> >>>thanks.
> >
> > Sid> Linus aslso asked if 2.6.2-rc1 work -- I shall build it
> > Sid> shortly. I also get the same error with 2.6.2-rc1-mm3.
> >
> > It doesn't work for me here, I started with 2.6.2-rc1 and moved up
> > through mm1 and mm3, all either hind on boot (after the uncompressing
> > message) or crashed with the test_wp_bit Oops that seems to be going
> > around.
> >
> > 2.6.1-mm4 is the last stable version that works for me.
> >
> > John
> >    John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
> > 	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
>
> See my previous post, I just commented out the line that Adrian Bunk
> asked me to remove and it's now up and running.
> Regards
> Sid.

	I am now having this problem. See the thread "Kernels > 2.6.1-mm3 do not 
boot." I had a kernel that would hang after uncompressing. Seems that gcc 3.3 
generates bad code w/ -funit-at-a-time. Now I get the test_wp_bit oops w/ 
kernel version 2.6.2-rc2-mm2.
	Since I have already commented out the line.. and it led to this oops, what 
the heck is the real problem here?
	Seems alot of other SMP systems are breaking with this too.

2x AMD 2000MP SMP system
1GB Highmem system

eric:/home/bot403 # gcc -v
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/3.3/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr 
--with-local-prefix=/usr/local --infodir=/usr/share/info 
--mandir=/usr/share/man --libdir=/usr/lib 
--enable-languages=c,c++,f77,objc,java,ada --disable-checking --enable-libgcj 
--with-gxx-include-dir=/usr/include/g++ --with-slibdir=/lib 
--with-system-zlib --enable-shared --enable-__cxa_atexit i486-suse-linux
Thread model: posix
gcc version 3.3 20030226 (prerelease) (SuSE Linux)


-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
