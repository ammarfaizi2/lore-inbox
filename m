Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262650AbSKCWrK>; Sun, 3 Nov 2002 17:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262914AbSKCWrK>; Sun, 3 Nov 2002 17:47:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41992 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262650AbSKCWrJ>; Sun, 3 Nov 2002 17:47:09 -0500
Date: Sun, 3 Nov 2002 14:53:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
In-Reply-To: <Pine.LNX.4.44.0211031439330.11657-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211031452380.11657-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Nov 2002, Linus Torvalds wrote:
> 
> The above should work pretty much on all block drivers out there, btw:
> the ones that don't understand SCSI commands should just ignore requests
> that aren't the regular REQ_CMD commands.

Note that "should work" does not necessarily mean "does work". For
example, in the IDE world, some of the generic packet command stuff is
only understood by ide-cd.c, and the generic IDE layer doesn't necessarily
understand it even if you have a disk that speaks ATAPI. I think Jens will 
fix that wart.

		Linus

