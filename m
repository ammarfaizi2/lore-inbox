Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbSJJKtI>; Thu, 10 Oct 2002 06:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263344AbSJJKtI>; Thu, 10 Oct 2002 06:49:08 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:52740 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S263342AbSJJKtH>; Thu, 10 Oct 2002 06:49:07 -0400
Message-ID: <3DA55C8C.760584EE@aitel.hist.no>
Date: Thu, 10 Oct 2002 12:55:08 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.40mm1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
References: <1034104637.29468.1483.camel@phantasy> <XFMail.20021009103325.pochini@shiny.it> <20021009170517.GA5608@mark.mielke.cc> <3DA4852B.7CC89C09@denise.shiny.it> <20021009222438.GD5608@mark.mielke.cc> <20021009232002.GC2654@bjl1.asuk.net> <20021010030736.GA8805@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> I might be wrong, but it seems to me that O_STREAMING isn't the answer
> to everything. The primary benefactors of O_STREAMING would be
> applications that read very large files that do not fit into RAM, from
> start to finish.

It don't have to be a file that don't fit into RAM.  Remember, other
running apps wants memory and cache too, so the "fair share" of memory
for _this_ process is much smaller than all of RAM.
So, O_STREAMING makes sense for all files where we know that we're going
sequentially and that caching this for long won't help. 
(Because the contents likely will be pushed out before we need
them again anyway (DVD case) or we know were going to delete
the file, or we simply don't want to push anything else
out even if we could cache this.)

Helge Hafting
