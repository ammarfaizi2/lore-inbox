Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbULaPAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbULaPAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 10:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbULaPAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 10:00:19 -0500
Received: from 6.143.111.62.revers.nsm.pl ([62.111.143.6]:35974 "HELO
	mother.localdomain") by vger.kernel.org with SMTP id S262098AbULaO6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 09:58:37 -0500
Date: Sun, 21 Nov 2004 20:35:46 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: posix timer test program / glibc patch to make glibc posix compliant
Message-ID: <20041121193546.GA11338@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0411181616590.418@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411181616590.418@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 04:26:07PM -0800, Christoph Lameter wrote:
> 2. the source code of the program

 How to compile your program? I'm getting linker errors:

zdzichu@mother:/mnt/ram% gcc -lpthread ct.c
/tmp/ccHn66Ii.o(.text+0x19): In function `t_clock_getres':
: undefined reference to `clock_getres'
/tmp/ccHn66Ii.o(.text+0x5c): In function `t_clock_gettime':
: undefined reference to `clock_gettime'
/tmp/ccHn66Ii.o(.text+0x9f): In function `t_clock_settime':
: undefined reference to `clock_settime'
/tmp/ccHn66Ii.o(.text+0xe2): In function `t_clock_getcpuclockid':
: undefined reference to `clock_getcpuclockid'
/tmp/ccHn66Ii.o(.text+0x13b): In function `t_timer_create':
: undefined reference to `timer_create'
/tmp/ccHn66Ii.o(.text+0x17e): In function `t_timer_gettime':
: undefined reference to `timer_gettime'
/tmp/ccHn66Ii.o(.text+0x1c4): In function `t_timer_settime':
: undefined reference to `timer_settime'
/tmp/ccHn66Ii.o(.text+0x20a): In function `t_timer_delete':
: undefined reference to `timer_delete'
/tmp/ccHn66Ii.o(.text+0x247): In function `t_timer_getoverrun':
: undefined reference to `timer_getoverrun'
/tmp/ccHn66Ii.o(.text+0xdb6): In function `clock_scan':
: undefined reference to `clock_gettime'
/tmp/ccHn66Ii.o(.text+0xdd8): In function `clock_scan':
: undefined reference to `clock_gettime'
collect2: ld returned 1 exit status
zdzichu@mother:/mnt/ram% fg

 (-lpthread is needed to get rid of 'undefined reference to pthread_*'
errors). I have glibc-2.3.3-200410112214.

-- 
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."

