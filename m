Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSE2CtC>; Tue, 28 May 2002 22:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313201AbSE2CtB>; Tue, 28 May 2002 22:49:01 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:51617 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S313190AbSE2CtB>;
	Tue, 28 May 2002 22:49:01 -0400
Date: Wed, 29 May 2002 12:48:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file locks in 2.4.18
Message-Id: <20020529124844.7adb15b4.sfr@canb.auug.org.au>
In-Reply-To: <20020528163358.51e33760.skraw@ithnet.com>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On Tue, 28 May 2002 16:33:58 +0200 Stephan von Krawczynski <skraw@ithnet.com> wrote:
>
> what is the preferred way to increase the maximum number of locks per
> file in 2.4.18 (and above :-)? Is this fs-type-dependant? My concern is
> reiserfs 3.6. I found out the hard way that there is a max of around 128
> currently...

Are you referring to fcntl locks?  If so what are the symptoms of not
being able to get a lock?  As far as I am aware, there should be no limit
on the number of locks per file (except memory, of course).  There is a
per process limit on the number of file locks, but it is infinite by default.

The file system can place restrictions on file locking, but I am
pretty sure that reiserfs does not.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
