Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbTBXLAZ>; Mon, 24 Feb 2003 06:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266535AbTBXLAZ>; Mon, 24 Feb 2003 06:00:25 -0500
Received: from angband.namesys.com ([212.16.7.85]:22401 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S266527AbTBXLAY>; Mon, 24 Feb 2003 06:00:24 -0500
Date: Mon, 24 Feb 2003 14:10:36 +0300
From: Oleg Drokin <green@namesys.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  comments on st_blksize and f_bsize for 2.5
Message-ID: <20030224141036.A11501@namesys.com>
References: <3E526C94.3020109@namesys.com> <20030224102009.GB14024@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224102009.GB14024@win.tue.nl>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Feb 24, 2003 at 11:20:09AM +0100, Andries Brouwer wrote:

> The trivial part is st_blksize: all agree.
> Quoting the man page:
>        The value st_blksize gives the "preferred" blocksize
>        for efficient file system I/O.  (Writing to a file in
>        smaller chunks may cause an inefficient read-modify-rewrite.)

> The nontrivial part is f_bsize. As far as I can see
> BSD and SYSV and SUS all differ. And there are the use
> in struct statfs and the use in struct statvfs that are
> nonequivalent.
> Maybe BSD f_iosize, f_bsize in statfs corresponds to
> SYSV f_bsize, f_frsize in statfs. Linux is again a
> bit different.

Traditionally in Linux f_bsize in struct statfs is used as FS block size.
(e.g. df calculates fs capacity by multiplying amount of blocks on
fs by f_bsize).
Actually, this is the only field in struct statfs that holds any data regarding
fs blocksize. (well, some arches have f_frsize, but it is marked as unused).

Bye,
    Oleg
