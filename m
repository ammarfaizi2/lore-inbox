Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273394AbSISVPy>; Thu, 19 Sep 2002 17:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273414AbSISVPy>; Thu, 19 Sep 2002 17:15:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10465 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S273394AbSISVPu>; Thu, 19 Sep 2002 17:15:50 -0400
Date: Thu, 19 Sep 2002 23:20:47 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Rob Ransbottom <rir@attbi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Clumsey make, README
In-Reply-To: <Pine.LNX.3.96.1020918101954.20879A-100000@localhost>
Message-ID: <Pine.NEB.4.44.0209192316440.20803-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Rob Ransbottom wrote:

> After many, many kernel rebuilds for hardware additions
> and replacements.  Usually on the same kernel version.
> An idea forced its way into my preoccupied mind.
>
> Why not build all the modules whether I need them or
> not?  Then if I need a module in the future it is
> waiting under /lib/modules.
>
> So I am asking if a:
>
> make all_modules
>
> directive exists or should be added.
> Anyone with the disk space might find this
> convenient.  Then you could make all_modules &
> make modules_install before building your kernel.
>...

This sounds like a good idea. But one problem I could imagine is that you
can build several different versions of a module, e.g.:

<M> Reiserfs support
  [ ]   Enable reiserfs debug mode
  [ ]   Stats in /proc/fs/reiserfs

If you build all modules you have 2x2=4 possibilities to build the
Reiserfs module and the question whether to enable the debug mode or not
has a big impact on the performance.

> rob                     Live the dream.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


