Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319222AbSIKQYF>; Wed, 11 Sep 2002 12:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319223AbSIKQYF>; Wed, 11 Sep 2002 12:24:05 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:1936 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S319222AbSIKQYE>; Wed, 11 Sep 2002 12:24:04 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 11 Sep 2002 09:33:52 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Xuan Baldauf <xuan--lkml@baldauf.org>
cc: linux-kernel@vger.kernel.org, Reiserfs List <reiserfs-list@namesys.com>
Subject: Re: Heuristic readahead for filesystems
In-Reply-To: <3D7F647B.1E0707FB@baldauf.org>
Message-ID: <Pine.LNX.4.44.0209110929390.1576-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2002, Xuan Baldauf wrote:

> Hello,
>
> I wonder wether Linux implements a kind of heuristic
> readahead for filesystems:
>
> If an application reads a directory with getdents() and if
> in the past, it stat()ed a significant part of the directory
> entries, it is likely that it will stat() every entry of
> every directory it reads with getdents() in the future. Thus
> readahead for the stat data could improve the perfomance,
> especially if the stat data is located closely to each other
> on disk.
>
> If an application did a stat()..open()..read() sequence on a
> file, it is likely that, after the next stat(), it will open
> and read the mentioned file. Thus, one could readahead the
> start of a file on stat() of that file.
>
> Combined: If an application walks a directory tree and
> visits each file, it is likely that it will continue up to
> the end of that tree.

M$ Win XP does exactly something like this and keep applications
( windows\prefetch ) and boot profiles that it uses to prefetch disk data
and avoid long page fault latencies. It does kind-of-work but care should
be taken adopting a similar technique on Linux ( patents ).



- Davide


