Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317786AbSFMWdw>; Thu, 13 Jun 2002 18:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317789AbSFMWdw>; Thu, 13 Jun 2002 18:33:52 -0400
Received: from quechua.inka.de ([212.227.14.2]:9017 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S317786AbSFMWdv>;
	Thu, 13 Jun 2002 18:33:51 -0400
From: Bernd Eckenfels <ecki-news2002-06@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Very large font size crashing X Font Server and Grounding Server to a Halt
In-Reply-To: <Pine.LNX.4.44.0206132128570.4999-100000@server3.jumpleads.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17IdAA-0001aJ-00@sites.inka.de>
Date: Fri, 14 Jun 2002 00:33:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0206132128570.4999-100000@server3.jumpleads.com> you wrote:
> It has always puzzled me that a process using lots of memory can bring 
> down an entire (otherwise relatively idle) server to the extent that one 
> cannot even get mingetty on a local terminal to respond to keypresses. I 
> can confirm that the described situation is not just a one-off.

Well, with crrent versions you have to have 2 or 3 of them to realy make a
server trtash. Something like:

tail /dev/zero 

recovers with the oom killer

tail /dev/zero & tail /dev/zero & tail /dev/zero

will most likely trash for minutes.

Some kind of penalty could be introduced, because this is better to set up
than ulimit. On a system with large amounts of users you simply cant set the
ulimit of a single user to mainram/concurrent-users or
mainram/concurrent-evil-users.

Greetings
Bernd
