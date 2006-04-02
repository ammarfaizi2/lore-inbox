Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWDBGd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWDBGd3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 01:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWDBGd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 01:33:29 -0500
Received: from bay110-f12.bay110.hotmail.com ([65.54.229.22]:23317 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751069AbWDBGd2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 01:33:28 -0500
Message-ID: <BAY110-F1201ECD426A949996E3F11FFD40@phx.gbl>
X-Originating-IP: [80.108.9.40]
X-Originating-Email: [blue_fox33@hotmail.com]
In-Reply-To: <20060401182258.GA30539@fiberbit.xs4all.nl>
From: "Blue Fox" <blue_fox33@hotmail.com>
To: marco.roeland@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: make menuconfig fails under 2.6.16
Date: Sun, 02 Apr 2006 08:33:23 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 02 Apr 2006 06:33:28.0373 (UTC) FILETIME=[5A305650:01C6561F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for information.

I am using Linux from Scratch. NCURSES is part of the installation process. 
/usr/lib/libncurses.so is installed on the system. After analysing the 
problem I encountered that it has to be a link to /lib/libncurses.so.5 which 
is a link to libncurses.so.5.5.

The link in my /usr/lib was broken. After restoring it, build is working.
Thank you for help.
BR Fox


>From: Marco Roeland <marco.roeland@xs4all.nl>
>To: Blue Fox <blue_fox33@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: PROBLEM: make menuconfig fails under 2.6.16
>Date: Sat, 1 Apr 2006 20:22:58 +0200
>
>On Saturday April 1st 2006 at 20:11 Blue Fox wrote:
>
> > 1.] One line summary of the problem:
> > make menuconfig does not work under linux 2.6.16. Build failed.
> >
> > [2.] Full description of the problem/report:
> > Trying to make menuconfig with ncurses on linux 2.6.15.5 fails.
> >
> > [3.] Keywords (i.e., modules, networking, kernel):
> > scripts lxdialog
> > [4.] Kernel version (from /proc/version):
> > Linux version 2.6.15.5-ybi (root@raven) (gcc version 4.0.2) #1 PREEMPT 
>Sat
> >     17:23:44 CET 2006
> >
> > [5.] Output of Oops.. message (if applicable) with symbolic information
> >
> > HOSTLD  scripts/kconfig/lxdialog/lxdialog
> > scripts/kconfig/lxdialog/checklist.o: In function
> > `print_item':checklist.c:(.text+0x64): undefined reference to `wmove'
>
>You seem not to have the "curses" library installed. Try installing it
>from your distribution. The kbuild system searches for libncursesw.so,
>libncurses.so or libcurses.so, in that order. In your case it probably
>can't find any (n)curses(w) package.
>--
>Marco Roeland


