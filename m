Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVF1AIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVF1AIO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 20:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVF1AIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 20:08:12 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:29853 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262117AbVF1AGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 20:06:31 -0400
Message-ID: <42C0948A.1080903@namesys.com>
Date: Mon, 27 Jun 2005 17:06:34 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Markus T?rnqvist <mjt@nysv.org>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>, Steve Lord <lord@xfs.org>,
       vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org> <42C0578F.7030608@namesys.com> <20050627212628.GB27805@thunk.org>
In-Reply-To: <20050627212628.GB27805@thunk.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What happens when the ext3 inode tables get hit by sector damage? Like
us, ext3 has data munging if you hit the wrong thing, its just that our
sources of data munging are different in the details.  Details matter
though, and so we are improving with each release, and V4 does have some
real improvements.  I hope the next major release will have atomic
transactions that don't have that niggling 5% left undone that prevents
them from being fully there, and then reiser4 can seriously advance the
field of reliability in filesystems rather than just playing catchup.

Good luck with ext3,

Hans

Theodore Ts'o wrote:

>However, logically speaking, if a filesystem is designed such that in
>certain cases, the fsck program has to brute-force search every single
>disk block looking for data structures that _look_ like they might be
>part of the filesystem data, well, that's always going to be more
>error prone than one where the filesystem metadata is in
>easily-predicted locations.  It sounds like you've added some more
>checks in reiser4, and that's definitely a good thing.  Time will tell
>whether they are sufficient or not.
>
>Regards,
>
>						- Ted
>
>
>  
>

