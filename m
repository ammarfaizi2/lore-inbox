Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267486AbUHXO1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267486AbUHXO1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 10:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267532AbUHXO1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 10:27:53 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:35774 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S267486AbUHXO0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 10:26:37 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: kde@mail.kde.org
Subject: Re: [kde] konstruct, nother problem
Date: Tue, 24 Aug 2004 10:26:34 -0400
User-Agent: KMail/1.6.82
References: <200408232246.33253.gene.heskett@verizon.net>
In-Reply-To: <200408232246.33253.gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408241026.34768.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.62.54] at Tue, 24 Aug 2004 09:26:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 August 2004 22:46, Gene Heskett wrote:
>Greetings;
>
>Trying, so far unsuccessfully, to build kde 3.3 with konstruct.
>
>I got past the ogg stuff, thanks to Tami, but now its making
> something in the general area of libsmoke, and cc1plus is going
> absolutely berzerkers, eating memory at about 1 meg every 2
> seconds.  This forces me into the swap about 2 minutes after I
> restart the make, and in 30 minutes its into swap over 500 megs and
> unusable, as in the x corner clock stops, and it may take 10
> minutes for a
>ctl-alt-backspace to be recognized.
>
>Stopping x, and doing a 'swapoff -a;swapon -a' pretty much cleans
> the system up, but even without x running, doing the make in
> konstruct starts grabbing sawp in about 2 minutes, with top showing
> cc1plus as using >40%, and it has shown as much as 87%, of a half
> gig of ram system.
>
>Has anyone else seen this effect?  BTW, kernel is 2.6.8.1-mm4,
>compiled for himem (4Gig) support but running on just one stick of
>ram as I think one of them is flaky & I'm trying to figure out which
>one.  I'll rebuild it without that just for grins, but somehow that
>shoe doesn't fit IMO.

Addendum: rebooted to 2.6.9-rc1 and restarted the 3.3 make process.  I 
did not get thru libsmokekde's make, had to ctl-c it when cc1plus had 
grabbed all available memory (top said 79.3%) includeing about 350 
megs of swap.  This on a system with 512megs of ram and 4Gb of swap.

Here is a clip from that process:
---------------
make[5]: Entering directory 
`/usr/src/konstruct/kde/kdebindings/work/kdebindings-3.3.0/smoke/kde'
if /bin/sh ../../libtool --silent --mode=compile --tag=CXX g++ 
-DHAVE_CONFIG_H -I. -I. -I../.. -I./.. -I/root/kde3.3/include 
-I/usr/X11R6/include   -DQT_THREAD_SUPPORT -I/root/kde3.3/include 
-I/usr/X11R6/include -D_REENTRANT  -Wnon-virtual-dtor -Wno-long-long 
-Wundef -ansi -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wcast-align 
-Wconversion -Wchar-subscripts -Wall -W -Wpointer-arith 
-Wwrite-strings -O2 -I/root/kde3.3/include -I/usr/X11R6/include 
-L/root/kde3.3/lib-L/usr/X11R6/lib -O2 -pipe -Wformat-security 
-Wmissing-format-attribute -fno-exceptions -fno-check-new -fno-common 
-MT libsmokekde_la.all_cpp.lo -MD -MP -MF 
".deps/libsmokekde_la.all_cpp.Tpo" -c -o libsmokekde_la.all_cpp.lo 
libsmokekde_la.all_cpp.cpp; \
then mv -f ".deps/libsmokekde_la.all_cpp.Tpo" 
".deps/libsmokekde_la.all_cpp.Plo"; else rm -f 
".deps/libsmokekde_la.all_cpp.Tpo"; exit 1; fi
In file included from libsmokekde_la.all_cpp.cpp:6:
x_4.cpp:4271: warning: `class x_KBookmarkOwner' has virtual functions 
but
   non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:6:
x_4.cpp: In function `void xcall_KCodecs(short int, void*, 
Smoke::StackItem*)':
x_4.cpp:12072: warning: unused variable `x_KCodecs*xself'
In file included from libsmokekde_la.all_cpp.cpp:8:
x_6.cpp: At global scope:
x_6.cpp:7186: warning: `class x_KFileFilter' has virtual functions but
   non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:8:
x_6.cpp:15643: warning: `class x_KFileTreeViewToolTip' has virtual 
functions
   but non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:10:
x_8.cpp: In function `void xcall_KJS(short int, void*, 
Smoke::StackItem*)':
x_8.cpp:5496: warning: unused parameter `Smoke::StackItem*args'
In file included from libsmokekde_la.all_cpp.cpp:11:
x_9.cpp: At global scope:
x_9.cpp:2011: warning: `class x_KMimeTypeResolverBase' has virtual 
functions
   but non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:11:
x_9.cpp: In function `void xcall_KParts(short int, void*, 
Smoke::StackItem*)':
x_9.cpp:14320: warning: unused parameter `Smoke::StackItem*args'
In file included from libsmokekde_la.all_cpp.cpp:12:
x_10.cpp: At global scope:
x_10.cpp:15779: warning: `class x_KRegExpEditorInterface' has virtual 
functions
   but non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:13:
x_11.cpp: In function `void xcall_KSharedConfig(short int, void*,
   Smoke::StackItem*)':
x_11.cpp:8219: warning: unused variable `x_KSharedConfig*xself'
In file included from libsmokekde_la.all_cpp.cpp:15:
x_13.cpp: In function `void xcall_KWallet(short int, void*, 
Smoke::StackItem*)
   ':
x_13.cpp:1064: warning: unused parameter `Smoke::StackItem*args'
In file included from libsmokekde_la.all_cpp.cpp:15:
x_13.cpp: In function `void xcall_KXMLGUI(short int, void*, 
Smoke::StackItem*)
   ':
x_13.cpp:5336: warning: unused parameter `Smoke::StackItem*args'
In file included from libsmokekde_la.all_cpp.cpp:17:
x_15.cpp: At global scope:
x_15.cpp:11769: warning: `class x_QFilePreview' has virtual functions 
but
   non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:18:
x_16.cpp:20259: warning: `class x_QImageConsumer' has virtual 
functions but
   non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:19:
x_17.cpp:828: warning: `class x_QJpUnicodeConv' has virtual functions 
but
   non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:19:
x_17.cpp:23597: warning: `class x_QNetworkProtocolFactoryBase' has 
virtual
   functions but non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:20:
x_18.cpp:3486: warning: `class x_QPolygonScanner' has virtual 
functions but
   non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:21:
x_19.cpp:7867: warning: `class x_QSqlDriverCreatorBase' has virtual 
functions
   but non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:22:
x_20.cpp:12960: warning: `class x_QToolTip' has virtual functions but
   non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:22:
x_20.cpp:27974: warning: `class x_QXmlContentHandler' has virtual 
functions but
   non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:22:
x_20.cpp:28092: warning: `class x_QXmlDTDHandler' has virtual 
functions but
   non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:22:
x_20.cpp:28147: warning: `class x_QXmlDeclHandler' has virtual 
functions but
   non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:22:
x_20.cpp:28596: warning: `class x_QXmlEntityResolver' has virtual 
functions but
   non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:22:
x_20.cpp:28641: warning: `class x_QXmlErrorHandler' has virtual 
functions but
   non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:22:
x_20.cpp:28859: warning: `class x_QXmlLexicalHandler' has virtual 
functions but
   non-virtual destructor
In file included from libsmokekde_la.all_cpp.cpp:22:
x_20.cpp:29166: warning: `class x_QXmlReader' has virtual functions 
but
   non-virtual destructor
make[5]: *** [libsmokekde_la.all_cpp.lo] Error 1
make[4]: *** [all-recursive] Interrupt
make[3]: *** [all-recursive] Interrupt
make[2]: *** [all] Interrupt
make[1]: *** [build-work/kdebindings-3.3.0/Makefile] Interrupt
make: *** [install] Interrupt

The above error 1 was me ctl-c'ing it while I still had a system, the 
toolbar clock was already doing 10 second at a time pauses.  It had 
been working on this one file for about 15 minutes then.

What, short of installing a few terrabytes of memory, can I do about 
this?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
