Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbSKBW4M>; Sat, 2 Nov 2002 17:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261483AbSKBW4M>; Sat, 2 Nov 2002 17:56:12 -0500
Received: from quechua.inka.de ([193.197.184.2]:49597 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S261485AbSKBW4M>;
	Sat, 2 Nov 2002 17:56:12 -0500
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44.0211021025420.2413-100000@home.transmeta.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E1887Hv-00027a-00@sites.inka.de>
Date: Sun, 3 Nov 2002 00:02:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0211021025420.2413-100000@home.transmeta.com> you wrote:
> I think it was a mistake to have permissions be part of the inode in the
> first place, but that's UNIX for you. A direntry-based approach is _so_ 
> much more flexible, and doesn't really have any downsides. 

The main downside is the problem, that an object then can have multiple
different permissions and there is no easy way to ensure a basic level:

a- the kernel can't drop priveledges on a modified object easyly (this would
require your attribution to contain a version or checksumed reference)
b- the user can't drop/restrict a object once he knows that it's data is now
more sensitive (he has to worry about all old hard and softlinks to the
file)
c- how do you handle renames or moves of the data instances? move the
associated permissions of the moved entry and let all others point to nil
like breakign symlinks?

Greetings
Bernd
