Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbWDASXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWDASXE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 13:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbWDASXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 13:23:03 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:46489 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751584AbWDASXC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 13:23:02 -0500
Date: Sat, 1 Apr 2006 20:22:58 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Blue Fox <blue_fox33@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: make menuconfig fails under 2.6.16
Message-ID: <20060401182258.GA30539@fiberbit.xs4all.nl>
References: <BAY110-F25D3E7350EA99B3B40F1C9FFD70@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <BAY110-F25D3E7350EA99B3B40F1C9FFD70@phx.gbl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday April 1st 2006 at 20:11 Blue Fox wrote:

> 1.] One line summary of the problem:
> make menuconfig does not work under linux 2.6.16. Build failed.
> 
> [2.] Full description of the problem/report:
> Trying to make menuconfig with ncurses on linux 2.6.15.5 fails.
> 
> [3.] Keywords (i.e., modules, networking, kernel):
> scripts lxdialog
> [4.] Kernel version (from /proc/version):
> Linux version 2.6.15.5-ybi (root@raven) (gcc version 4.0.2) #1 PREEMPT Sat  
>     17:23:44 CET 2006
> 
> [5.] Output of Oops.. message (if applicable) with symbolic information
> 
> HOSTLD  scripts/kconfig/lxdialog/lxdialog
> scripts/kconfig/lxdialog/checklist.o: In function 
> `print_item':checklist.c:(.text+0x64): undefined reference to `wmove'

You seem not to have the "curses" library installed. Try installing it
from your distribution. The kbuild system searches for libncursesw.so,
libncurses.so or libcurses.so, in that order. In your case it probably
can't find any (n)curses(w) package.
-- 
Marco Roeland
