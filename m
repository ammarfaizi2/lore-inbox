Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319545AbSIMHmT>; Fri, 13 Sep 2002 03:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319547AbSIMHmT>; Fri, 13 Sep 2002 03:42:19 -0400
Received: from dns.vamo.orbitel.bg ([195.24.63.30]:16403 "EHLO
	dns.vamo.orbitel.bg") by vger.kernel.org with ESMTP
	id <S319545AbSIMHmS>; Fri, 13 Sep 2002 03:42:18 -0400
Date: Fri, 13 Sep 2002 10:47:04 +0300 (EEST)
From: Ivan Ivanov <ivandi@vamo.orbitel.bg>
To: linux-kernel@vger.kernel.org
Subject: XFS?
Message-ID: <Pine.LNX.4.44.0209131011340.4066-100000@magic.vamo.orbitel.bg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that you missed the main problem with all this new "great"
filesystems. And the main problem is potential data loss in case of a
crash. Only ext3 supports ordered or journal data mode.

XFS and JFS are designed for large multiprocessor machines powered by UPS
etc., where the risk of power fail, or some kind of tecnical problem is
veri low.

On the other side Linux works in much "risky" environment - old
machines, assembled from "yellow" parts, unstable power suply and so on.

With XFS every time when power fails while writing to file the entire file
is lost. The joke is that it is normal according FAQ :)
JFS has the same problem.
With ReiserFS this happens sometimes, but much much rarely. May be v4 will
solve this problem at all.

The above three filesystems have problems with badblocks too.

So the main problem is how usable is the filesystem. I mean if a company
spends a few tousand $ to provide a "low risky" environment, then may be
it will use AIX or IRIX, but not Linux.
And if I am running a <$1000 "server" I will never use XFS/JFS.

-----------------
Best Regards
Ivan



