Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbTFEWfw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265239AbTFEWfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:35:50 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:1570 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265237AbTFEWfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:35:43 -0400
Date: Thu, 5 Jun 2003 15:45:34 -0700
From: Andrew Morton <akpm@digeo.com>
To: Edward Tandi <ed@efix.biz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 latest: breaks gnome
Message-Id: <20030605154534.355380e1.akpm@digeo.com>
In-Reply-To: <1054852458.1886.18.camel@wires.home.biz>
References: <20030604142241.0dc6f34e.shemminger@osdl.org>
	<3EDE7398.70005@tmsusa.com>
	<20030605111212.33e63d46.shemminger@osdl.org>
	<3EDFB3E2.2090308@tmsusa.com>
	<20030605143346.197a8923.akpm@digeo.com>
	<3EDFBD08.5060902@tmsusa.com>
	<1054852458.1886.18.camel@wires.home.biz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jun 2003 22:49:15.0203 (UTC) FILETIME=[B083A130:01C32BB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Tandi <ed@efix.biz> wrote:
>
> FYI,
> 
> I have just tried mm5. I have Gnome2 working (using kdm) but am still
> having the same problems as mm3:

It would be very interesting to know if these things still happen with just
2.5.70 plus

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm5/broken-out/linus.patch

> 1) gnome-terminal still only works as root.

Don't know.

> 2) xosview still freezes (reading /proc/*)

We changed the format of /proc/stat and broke xosview.  I just tried 1.8.0,
not joy.

> 3) rmmod still not working -"Can't open 'analog': No such file or
> directory"

need more details on this.

> 4) su - <user> returns "operation not permitted". Works as root though
> and thereafter as <user>.

Don't know.

> 5) This is the second time this has happened after switching to 2.5.x;
> My Evolution groups (left-hand icon bar) have gone missing.

Don't know.  2.5 might be triggering latent bugs in evolution.  It's
happened before..

> 6) from /var/log/messages: /sbin/mingetty[2583]: /dev/tty4: cannot open
> tty: Inappropriate ioctl for device

Don't know.

> 7) Excessive "anticipatory scheduling elevator" messages allover in
> /var/log/messages.

Will fix sometime.

> 8) from dmesg: process `named' is using obsolete setsockopt SO_BSDCOMPAT

Overly noisy warning.  How frequently do they occur?

> I think there is something "not quite right" in the terminal I/O area.

Tracking down the kernel version at which this started to occur would be
good.

