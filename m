Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbUJ0Idu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbUJ0Idu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 04:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbUJ0Idt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 04:33:49 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:4108 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262333AbUJ0Ido (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 04:33:44 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "H. Peter Anvin" <hpa@zytor.com>, Tonnerre <tonnerre@thundrix.ch>
Subject: Re: The naming wars continue...
Date: Wed, 27 Oct 2004 11:33:25 +0300
User-Agent: KMail/1.5.4
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041026203137.GB10119@thundrix.ch> <417F2251.7010404@zytor.com>
In-Reply-To: <417F2251.7010404@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 October 2004 07:21, H. Peter Anvin wrote:
> Tonnerre wrote:
> > Salut,
> > 
> > On Tue, Oct 26, 2004 at 02:43:54PM +0300, Denis Vlasenko wrote:
> > 
> >>Having /usr/XnnRmm was a mistake in the first place.
> > 
> > 
> > BSD has /X11R6, whilst I'd agree that /opt/xorg is probably a lot more
> > appropriate. If you want I can  take this discussion back to the X.Org
> > folks again, but I don't think it's actually going to change anything.
> > 
> 
> /opt/X (or /usr/X) is really what it probably should be.

Why there is any distinction between, say, gcc and X?
KDE and Midnight Commander? etc... Why some of them go
to /opt while others are spread across dozen of dirs?
This seems to be inconsistent to me.

I won't push my solution to anyone, just going to show you
how does it look:

# ls /usr/app -1
Linux-PAM-0.75
MPlayer-0.90rc4
SDL-1.2.6
acrobat-5.06
acroread-5.0.8
alsa-lib-0.9.0beta12
alsa-lib-0.9.7
alsa-utils-0.9.0beta12
alsa-utils-0.9.7
apache-1.3.24
atk-1.2.4
audiofile-0.2.3
audiogalaxy-0520
autofs-4.1.3
bash-2.05b
bglibs-1.005
binutils-2.15.91.0.1
bridge-utils-0.9.6
bsdftpd-6.0-ssl-0.5.2
busybox-1.00-pre6
...

Typical package under /usr/app:

# ls -l /usr/app/gcc-3.4.1
total 12
-r-xr-xr-x    1 root     root         1429 Oct 25 13:39 !vda_install
-r-xr-xr-x    1 root     root          874 Sep 15  2003 !vda_install_root
-r-xr-xr-x    1 root     root          157 Aug 17  2003 !vda_ver
drwxr-xr-x    2 root     root          360 Oct 25 13:39 bin
drwxr-xr-x    3 root     root           72 Jul 15 16:54 include
drwxr-xr-x    2 root     root          224 Jul 15 16:54 info
drwxr-xr-x    3 root     root          336 Jul 15 16:54 lib
drwxr-xr-x    3 root     root           72 Jul 15 16:54 libexec
drwxr-xr-x    4 root     root           96 Jul 15 16:54 man

This is how it is made visible to the rest of system:

# ls -l /usr/lib /usr/bin | grep gcc-3.4.1
lrwxrwxrwx    1 root     root           26 Oct 25 13:39 c++ -> /usr/app/gcc-3.4.1/bin/c++
lrwxrwxrwx    1 root     root           26 Oct 25 13:39 cpp -> /usr/app/gcc-3.4.1/bin/cpp
lrwxrwxrwx    1 root     root           26 Oct 25 13:39 g++ -> /usr/app/gcc-3.4.1/bin/g++
lrwxrwxrwx    1 root     root           26 Oct 25 13:39 gcc -> /usr/app/gcc-3.4.1/bin/gcc
lrwxrwxrwx    1 root     root           29 Oct 25 13:39 gccbug -> /usr/app/gcc-3.4.1/bin/gccbug
lrwxrwxrwx    1 root     root           27 Oct 25 13:39 gcov -> /usr/app/gcc-3.4.1/bin/gcov
lrwxrwxrwx    1 root     root           44 Oct 25 13:39 i386-pc-linux-gnu-c++ -> /usr/app/gcc-3.4.1/bin/i386-pc-linux-gnu-c++
lrwxrwxrwx    1 root     root           44 Oct 25 13:39 i386-pc-linux-gnu-g++ -> /usr/app/gcc-3.4.1/bin/i386-pc-linux-gnu-g++
lrwxrwxrwx    1 root     root           44 Oct 25 13:39 i386-pc-linux-gnu-gcc -> /usr/app/gcc-3.4.1/bin/i386-pc-linux-gnu-gcc
lrwxrwxrwx    1 root     root           50 Oct 25 13:39 i386-pc-linux-gnu-gcc-3.4.1 -> /usr/app/gcc-3.4.1/bin/i386-pc-linux-gnu-gcc-3.4.1
lrwxrwxrwx    1 root     root           34 Oct 25 13:39 libiberty.a -> /usr/app/gcc-3.4.1/lib/libiberty.a
lrwxrwxrwx    1 root     root           34 Oct 25 13:39 libstdc++.a -> /usr/app/gcc-3.4.1/lib/libstdc++.a
lrwxrwxrwx    1 root     root           35 Oct 25 13:39 libstdc++.la -> /usr/app/gcc-3.4.1/lib/libstdc++.la
lrwxrwxrwx    1 root     root           35 Oct 25 13:39 libstdc++.so -> /usr/app/gcc-3.4.1/lib/libstdc++.so
lrwxrwxrwx    1 root     root           37 Oct 25 13:39 libstdc++.so.6 -> /usr/app/gcc-3.4.1/lib/libstdc++.so.6
lrwxrwxrwx    1 root     root           41 Oct 25 13:39 libstdc++.so.6.0.1 -> /usr/app/gcc-3.4.1/lib/libstdc++.so.6.0.1
lrwxrwxrwx    1 root     root           34 Oct 25 13:39 libsupc++.a -> /usr/app/gcc-3.4.1/lib/libsupc++.a
lrwxrwxrwx    1 root     root           35 Oct 25 13:39 libsupc++.la -> /usr/app/gcc-3.4.1/lib/libsupc++.la

It's pretty modular: I can remove and install packages
as needed, I can go back to older versions to check
regressions etc...

BTW today I just added uclibc and some uc-compiled apps to the mix.
They coexist nicely with the rest of the system 
(I needed only some almost trivial tricks)

uc-Midnight Commander is 3 times smaller than glibc one :)
--
vda

