Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268033AbTBRVjM>; Tue, 18 Feb 2003 16:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268034AbTBRVjM>; Tue, 18 Feb 2003 16:39:12 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:21890 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S268033AbTBRVjL>; Tue, 18 Feb 2003 16:39:11 -0500
Date: Tue, 18 Feb 2003 22:49:01 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Petri Koistinen <petri.koistinen@iki.fi>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [TRIVIAL] README: patch -p1, remove make dep
In-Reply-To: <Pine.LNX.4.44.0302182044550.943-100000@dsl-hkigw4e42.dial.inet.fi>
Message-ID: <Pine.LNX.4.33.0302182239320.25571-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Either I am doing all wrong, but I think you need to use -p1 to apply
> patches. Make dep is unnecessary now.

No, you do it right;-) The instructions seem to be a leftover from the
time when Linus named the kernel directory linux/ (as opposed to
linux-2.5.xx).

> --- linux-2.5.62/README.orig	2003-02-18 20:27:00.000000000 +0200
> +++ linux-2.5.62/README	2003-02-18 20:27:20.000000000 +0200
> @@ -69,10 +69,10 @@
>     install by patching, get all the newer patch files, enter the
>     directory in which you unpacked the kernel source and execute:
>
> -		gzip -cd patchXX.gz | patch -p0
> +		gzip -cd patchXX.gz | patch -p1
>
>     or
> -		bzip2 -dc patchXX.bz2 | patch -p0
> +		bzip2 -dc patchXX.bz2 | patch -p1
>
>     (repeat xx for all versions bigger than the version of your current
>     source tree, _in_order_) and you should be ok.  You may want to remove

However, your patch gets us only half-way to correct instructions,
since for 'patch -p1' one also needs to cd into the kernel directory.
E.g., something like

     install by patching, get all the newer patch files, enter the
     top level directory of the kernel source (the one named
     linux-2.xx.yy) and execute:

               gzip -cd ../patchXX.gz | patch -p1
     or
               bzip2 -dc ../patchXX.bz2 | patch -p1

     (repeat xx for all versions bigger than the version of your current
     source tree, _in_order_) and you should be ok. Don't forget to rename
     the kernel directory to linux-2.xx.zz where zz is the number of the
     lates patch you applied.

may be better?

Tim

