Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265026AbSKFNAm>; Wed, 6 Nov 2002 08:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265027AbSKFNAm>; Wed, 6 Nov 2002 08:00:42 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:8637 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265026AbSKFNAj>;
	Wed, 6 Nov 2002 08:00:39 -0500
Date: Wed, 6 Nov 2002 13:06:12 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Jordan Breeding <jordan.breeding@attbi.com>, linux-kernel@vger.kernel.org
Subject: Re: unitialized timers with 2.5.46-bk
Message-ID: <20021106130612.GA2666@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	Jordan Breeding <jordan.breeding@attbi.com>,
	linux-kernel@vger.kernel.org
References: <3DC891A9.5030404@attbi.com> <3DC89B50.2DBF413@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC89B50.2DBF413@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 08:32:16PM -0800, Andrew Morton wrote:
 > > function=0xc036ca30, data=0x0
 > > Call Trace:
 > >   [<c012d568>] check_timer_failed+0x68/0x70
 > >   [<c036ca30>] floppy_shutdown+0x0/0xe0
 > >   [<c012d8bb>] del_timer+0x1b/0x90
 > >   [<c036a458>] reschedule_timeout+0x28/0xd0
 > >   [<c03708f0>] floppy_find+0x0/0x60
 > >   [<c0105094>] init+0x54/0x180
 > >   [<c0105040>] init+0x0/0x180
 > >   [<c0108d9d>] kernel_thread_helper+0x5/0x18
 > hm.  Except this one.

Here's a very similar one too..

function=0xc029547c, data=0x0
Call Trace:
 [<c012ab30>] check_timer_failed+0x40/0x5c
 [<c029547c>] floppy_shutdown+0x0/0x118
 [<c012b266>] del_timer+0x16/0x10c
 [<c029319e>] reschedule_timeout+0x22/0xa8
 [<c0297754>] do_fd_request+0x0/0x90
 [<c0105101>] init+0x75/0x204
 [<c010508c>] init+0x0/0x204
 [<c0106f0d>] kernel_thread_helper+0x5/0xc

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
