Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSHJS2j>; Sat, 10 Aug 2002 14:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSHJS2i>; Sat, 10 Aug 2002 14:28:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33030 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317181AbSHJS2i>; Sat, 10 Aug 2002 14:28:38 -0400
Date: Sat, 10 Aug 2002 11:33:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Paul Larson <plars@austin.ibm.com>, Hubertus Franke <frankeh@us.ibm.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       Andrew Morton <akpm@zip.com.au>, <andrea@suse.de>,
       Dave Jones <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
In-Reply-To: <20020810182317.A306@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208101132490.2197-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Aug 2002, Jamie Lokier wrote:
>
> Linus Torvalds wrote:
> > Doing a simple strace shows that all the systems I have regular access to
> > use the "getcwd()" system call anyway, which gets this right on /proc (and
> > other filesystems that do not guarantee unique inode numbers)
> 
> Oh dear -- what of programs that assume duplicate inode numbers are hard
> links, and therefore assume the same contents will be found in each
> duplicate?

Well, anybody who tries to back up /proc with "tar" is in for some 
surprises anyway ;)

			Linus

