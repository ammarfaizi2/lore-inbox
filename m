Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbTIGFnT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 01:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTIGFnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 01:43:19 -0400
Received: from dragon.woods.net ([166.70.175.35]:28546 "EHLO c.smtp.woods.net")
	by vger.kernel.org with ESMTP id S263114AbTIGFnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 01:43:18 -0400
Date: Sat, 6 Sep 2003 23:43:17 -0600 (MDT)
From: Aaron Dewell <acd@woods.net>
To: linux-kernel@vger.kernel.org
Subject: partition recovery question resolution
Message-ID: <Pine.LNX.4.44.0309062335230.20670-100000@dragon.woods.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I ended up resolving the question I posted last week.  The reason the partition
devices read all zeros was because, in fact, those positions on the disk were
all zeros.  Somehow, everything past 1.1 GB got set to all zeros on the disk,
so it was all correct.  I was confused trying to resolve that with a backup (dd)
copy of the disk that I had, which I finally noticed was about 1.1 GB long, not
4.3 as I was expecting.  Thus the inconsistancies that I was seeing.

Anyway, thanks for the input.

I am somewhat curious how it got zerod in the first place.  I wasn't working on
it at first, but the person who was claims the file started at 4.3 GB (the right
size).  So, at some point it got truncated.  The modification time was not
updated on the file.  Doing a dd back to the disk with a short file shouldn't
affect anything past the end of the file, right?  Therefore, there would have
had to have been some kind of condition whereby the file got truncated while a
dd was going on, and for some reason, it started writing zeros instead of
stopping.

It doesn't matter for my problem at this point, since the files are gone either
way, but it might make an interesting academic question.  :-)

Aaron

