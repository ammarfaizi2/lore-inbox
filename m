Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbQLPBmN>; Fri, 15 Dec 2000 20:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130153AbQLPBmD>; Fri, 15 Dec 2000 20:42:03 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:6 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129716AbQLPBlz>; Fri, 15 Dec 2000 20:41:55 -0500
Date: Fri, 15 Dec 2000 17:11:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kurt Garloff <garloff@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, miquels@cistron.nl,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: TIOCGDEV ioctl
In-Reply-To: <20001216015537.G21372@garloff.suse.de>
Message-ID: <Pine.LNX.4.10.10012151710040.1325-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2000, Kurt Garloff wrote:
> 
> The kernel provides this information -- sort of:
> It contains the TIOCTTYGSTRUCT syscall which returns a struct. Of course,
> it changes between different kernel archs and revisions, so using it is
> an ugly hack. Grab for TIOCTTYGSTRUCT_HACK in the bootlogd.c file of the
> sysvinit sources. Shudder!

Please instead do the same thing /dev/tty does, namely a sane interface
that shows it as a symlink in /proc (or even in /dev)

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
