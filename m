Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319173AbSIKQhi>; Wed, 11 Sep 2002 12:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319224AbSIKQhh>; Wed, 11 Sep 2002 12:37:37 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:56539 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319173AbSIKQhh>; Wed, 11 Sep 2002 12:37:37 -0400
Date: Wed, 11 Sep 2002 13:42:06 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Xuan Baldauf <xuan--lkml@baldauf.org>
cc: linux-kernel@vger.kernel.org, Reiserfs List <reiserfs-list@namesys.com>
Subject: Re: Heuristic readahead for filesystems
In-Reply-To: <3D7F647B.1E0707FB@baldauf.org>
Message-ID: <Pine.LNX.4.44L.0209111340060.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2002, Xuan Baldauf wrote:

> I wonder wether Linux implements a kind of heuristic
> readahead for filesystems:

> If an application did a stat()..open()..read() sequence on a
> file, it is likely that, after the next stat(), it will open
> and read the mentioned file. Thus, one could readahead the
> start of a file on stat() of that file.

> Example: See this diff strace:

Your observation is right, but I'm not sure how much it will
matter if we start reading the file at stat() time or at
read() time.

This is because one disk seek takes about 10 million CPU
cycles on modern systems and we'll have completed the stat(),
open() and started the read() before the disk arm has started
moving ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

